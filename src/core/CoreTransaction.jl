# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

struct CoreTransaction <: AbstractCoreTransaction
    type::Union{Nothing,Int32}
    options::Union{Nothing,GraknOptions}
    bidirectional_stream::BidirectionalStream
    transaction_id::Union{Nothing,UUID}
    session_id::Array{UInt8,1}
end

Base.show(io::IO, transaction::AbstractCoreTransaction) = Base.print(io, transaction)
function Base.print(io::IO, transaction::AbstractCoreTransaction)
    res_string = "Transaction $(transaction.transaction_id) with session_id: $(transaction.session_id)"
    print(io, res_string)
end


function CoreTransaction(session::CoreSession , sessionId::Array{UInt8,1}, type::Int32, options::GraknOptions)
    type = type
    options = options
    input_channel = Channel{Proto.Transaction_Client}(10)
    proto_options = copy_to_proto(options, Proto.Options)

    req_result, status = transaction(session.client.core_stub.blockingStub, gRPCController(), input_channel)
    output_channel = grpc_result_or_error(req_result, status, result->result)

    open_req = TransactionRequestBuilder.open_req(session.sessionID, type, proto_options,session.networkLatencyMillis)

    bidirectionalStream = BidirectionalStream(input_channel, output_channel, status)
    trans_id = uuid4()
    result = CoreTransaction(type, options, bidirectionalStream, trans_id, sessionId)

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

#@Override
#     public Res execute(Req.Builder request) {
#         return execute(request, true);
#     }
#
#     private Res execute(Req.Builder request, boolean batch) {
#         return query(request, batch).map(res -> res).get();
#     }

#
# package grakn.client.core;
#
# import com.google.protobuf.ByteString;
# import grakn.client.api.GraknOptions;
# import grakn.client.api.GraknTransaction;
# import grakn.client.api.concept.ConceptManager;
# import grakn.client.api.logic.LogicManager;
# import grakn.client.api.query.QueryFuture;
# import grakn.client.api.query.QueryManager;
# import grakn.client.common.exception.GraknClientException;
# import grakn.client.concept.ConceptManagerImpl;
# import grakn.client.logic.LogicManagerImpl;
# import grakn.client.query.QueryManagerImpl;
# import grakn.client.stream.BidirectionalStream;
# import grakn.protocol.TransactionProto.Transaction.Req;
# import grakn.protocol.TransactionProto.Transaction.Res;
# import grakn.protocol.TransactionProto.Transaction.ResPart;
# import io.grpc.StatusRuntimeException;
#
# import java.util.stream.Stream;
#
# import static grakn.client.common.exception.ErrorMessage.Client.TRANSACTION_CLOSED;
# import static grakn.client.common.rpc.RequestBuilder.Transaction.commitReq;
# import static grakn.client.common.rpc.RequestBuilder.Transaction.openReq;
# import static grakn.client.common.rpc.RequestBuilder.Transaction.rollbackReq;
#
# public class CoreTransaction implements GraknTransaction.Extended {
#
#     private final GraknTransaction.Type type;
#     private final GraknOptions options;
#     private final ConceptManager conceptMgr;
#     private final LogicManager logicMgr;
#     private final QueryManager queryMgr;
#
#     private final BidirectionalStream bidirectionalStream;
#
#     CoreTransaction(CoreSession session, ByteString sessionId, Type type, GraknOptions options) {
#         try {
#             this.type = type;
#             this.options = options;
#             conceptMgr = new ConceptManagerImpl(this);
#             logicMgr = new LogicManagerImpl(this);
#             queryMgr = new QueryManagerImpl(this);
#             bidirectionalStream = new BidirectionalStream(session.stub(), session.transmitter());
#             execute(openReq(sessionId, type.proto(), options.proto(), session.networkLatencyMillis()), false);
#         } catch (StatusRuntimeException e) {
#             throw GraknClientException.of(e);
#         }
#     }
#
#     @Override
#     public Type type() { return type; }
#
#     @Override
#     public GraknOptions options() { return options; }
#
#     @Override
#     public boolean isOpen() { return bidirectionalStream.isOpen(); }
#
#     @Override
#     public ConceptManager concepts() { return conceptMgr; }
#
#     @Override
#     public LogicManager logic() { return logicMgr; }
#
#     @Override
#     public QueryManager query() { return queryMgr; }
#
#     @Override
#     public Res execute(Req.Builder request) {
#         return execute(request, true);
#     }
#
#     private Res execute(Req.Builder request, boolean batch) {
#         return query(request, batch).map(res -> res).get();
#     }
#
#     @Override
#     public QueryFuture<Res> query(Req.Builder request) {
#         return query(request, true);
#     }
#
#     private QueryFuture<Res> query(Req.Builder request, boolean batch) {
#         if (!isOpen()) throw new GraknClientException(TRANSACTION_CLOSED);
#         BidirectionalStream.Single<Res> single = bidirectionalStream.single(request, batch);
#         return single::get;
#     }
#
#     @Override
#     public Stream<ResPart> stream(Req.Builder request) {
#         if (!isOpen()) throw new GraknClientException(TRANSACTION_CLOSED);
#         return bidirectionalStream.stream(request);
#     }
#
#     @Override
#     public void commit() {
#         try {
#             execute(commitReq());
#         } finally {
#             close();
#         }
#     }
#
#     @Override
#     public void rollback() {
#         execute(rollbackReq());
#     }
#
#     @Override
#     public void close() {
#         bidirectionalStream.close();
#     }
# }
