# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

struct CoreTransaction <: AbstractCoreTransaction
    type::Union{Nothing,Int32}
    options::Union{Nothing,GraknOptions}
    bidirectional_stream::BidirectionalStream
    transaction_id::Union{Nothing,UUID}
    session_id::Array{UInt8,1}
    request_timout::Real
end

Base.show(io::IO, transaction::AbstractCoreTransaction) = print(io, transaction)
function Base.print(io::IO, transaction::AbstractCoreTransaction)
    res_string = "Transaction $(transaction.transaction_id) with session_id: $(transaction.session_id)"
    print(io, res_string)
end


function CoreTransaction(session::CoreSession ,
                        sessionId::Array{UInt8,1},
                        type::Int32,
                        options::GraknOptions;
                        request_timout::Real=session.request_timeout)
    type = type
    options = options
    input_channel = Channel{Proto.Transaction_Client}(10)
    proto_options = copy_to_proto(options, Proto.Options)

    grpc_controller = gRPCController(request_timeout=request_timout)

    req_result, status = transaction(session.client.core_stub.blockingStub, grpc_controller, input_channel)
    output_channel = grpc_result_or_error(req_result, status, result->result)

    open_req = TransactionRequestBuilder.open_req(session.sessionID, type, proto_options,session.networkLatencyMillis)

    bidirectionalStream = BidirectionalStream(input_channel, output_channel)
    trans_id = uuid4()
    result = CoreTransaction(type, options, bidirectionalStream, trans_id, sessionId, request_timout)

    req_result = execute(result, open_req, false)
    tmp_result = req_result[1]
    kind_of_result = which_oneof(tmp_result, :res)
    open_req_res = getproperty(tmp_result, kind_of_result)

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
        !is_open(transaction) && throw(GraknClientException(CLIENT_TRANSACTION_CLOSED))
        result = single_request(transaction.bidirectional_stream, request, batch)
        return result
end

function is_open(transaction::T)::Bool where {T<:AbstractCoreTransaction}
    return transaction.bidirectional_stream.is_open.value
end

function close(transaction::T)::Bool where {T<:AbstractCoreTransaction}
    close(transaction.bidirectional_stream)
end
