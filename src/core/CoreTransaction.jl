# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

struct CoreTransaction <: AbstractCoreTransaction
    type::Optional{Int32}
    options::Optional{TypeDBOptions}
    bidirectional_stream::BidirectionalStream
    transaction_id::Optional{UUID}
    session_id::Bytes
    request_timeout::Real
    session::AbstractCoreSession
    error_break_time::Real
end

function Base.show(io::IO, transaction::AbstractCoreTransaction)
    res_string = "Transaction $(transaction.transaction_id) with session_id: $(transaction.session_id)"
    print(io, res_string)
end


function CoreTransaction(session::CoreSession ,
                        sessionId::Bytes,
                        type::EnumType,
                        options::TypeDBOptions;
                        request_timeout::Real=session.request_timeout,
                        use_blocking_stub::Bool = true,
                        error_break_time::Real = session.error_break_time)

    function trans_return(res)
        return res
    end

    type = type
    options = options
    input_channel = Channel{Proto.Transaction_Client}()
    proto_options = copy_to_proto(options, Proto.Options)

    grpc_controller = gRPCController(request_timeout = request_timeout)

    if use_blocking_stub
        req_result, status = Proto.transaction(session.client.core_stub.blockingStub, grpc_controller, input_channel)
    else
        res = Proto.transaction(session.client.core_stub.asyncStub, grpc_controller, input_channel, trans_return)
        wait(res)
        req_result, status = fetch(res)
    end
    output_channel = grpc_result_or_error(req_result, status, result->result)

    open_req = TransactionRequestBuilder.open_req(session.sessionID, type, proto_options, session.networkLatencyMillis)

    bidirectionalStream = BidirectionalStream(input_channel, output_channel, status, error_break_time = error_break_time)
    trans_id = uuid4()
    result = CoreTransaction(type, options, bidirectionalStream, trans_id, sessionId, request_timeout, session, error_break_time)

    # The following is only for warming up Transaction. If we didn't do this
    # it could happen that a transaction reach a timeout.
    req_result = execute(result, open_req, false)
    kind_of_result = Proto.which_oneof(req_result, :res)
    getproperty(req_result, kind_of_result)

    return result
end

function execute(transaction::T, request::R, batch::Bool) where {T<:AbstractCoreTransaction, R<:Proto.ProtoType}
    return query(transaction, request, batch)
end

function execute(transaction::T, request::R) where {T<:AbstractCoreTransaction, R<:Proto.ProtoType}
    return query(transaction, request, true)
end

function query(transaction::T, request::R) where {T<:AbstractCoreTransaction, R<:Proto.ProtoType}
    return query(transaction, request, true);
end

function query(transaction::T, request::R, batch::Bool) where {T<:AbstractCoreTransaction, R<:Proto.ProtoType}
    !is_open(transaction) && throw(TypeDBClientException(CLIENT_TRANSACTION_CLOSED))

    result = Union{Proto.Transaction_Res, Proto.Transaction_ResPart}[]
    try
        result = single_request(transaction.bidirectional_stream, request, batch)
    catch ex
        close(transaction)
        rethrow(ex)
    end

    return result
end

function stream(transaction::T, request::R, batch::Bool = true) where {T<:AbstractCoreTransaction, R<:Proto.ProtoType}
    !is_open(transaction) && throw(TypeDBClientException(CLIENT_TRANSACTION_CLOSED))

    result = Union{Proto.Transaction_Res, Proto.Transaction_ResPart}[]
    try
        result = stream_request(transaction.bidirectional_stream, request, batch)
    catch ex
        close(transaction)
        rethrow(ex)
    end

    return result
end

function is_open(transaction::T)::Bool where {T<:AbstractCoreTransaction}
    return transaction.bidirectional_stream.is_open.value
end

function close(transaction::T)::Bool where {T<:AbstractCoreTransaction}
    try
        close(transaction.bidirectional_stream)
        delete!(transaction.session, transaction.transaction_id)
    catch ex
        throw(TypeDBClientException("something went wrong closing Transaction", ex))
    end
    true
end
