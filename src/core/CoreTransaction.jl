# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

struct CoreTransaction <: AbstractCoreTransaction
    type::Union{Nothing,Int}
    options::Union{Nothing,GraknOptions}
    bidirectional_stream::BidirectionalStream
    conceptMgr::Union{Nothing,T} where {T<:AbstractConceptManager}
    logicMgr::Union{Nothing,T} where {T<:AbstractLogicManager}
    queryMgr::Union{Nothing,T} where {T<:AbstractQueryManager}
end


function CoreTransaction(session::CoreSession , sessionId::Array{UInt8,1}, type::Int, options::GraknOptions)
    try
        type = type
        options = options
        stub = GraknCoreBlockingStub(gRPCChannel(session.address * ":" * string(session.port)))
        conceptMgr = ConceptManagerImpl()
        logicMgr = LogicManagerImpl()
        queryMgr = QueryManagerImpl()
        bidirectionalStream = BidirectionalStream(stub, session_transmitter(session))
        result = CoreTransaction(type, options, bidirectionalStream, conceptMgr, logicMgr, queryMgr)
        open_res, req_task = transaction_execute(result, transaction_open_req(sessionId, type, options, session.networkLatencyMillis), false)

        return result
    catch ex
        throw(GraknClientException("Error while building transaction", ex))
    end
end

function transaction_execute(transaction::T, request::grakn.protocol.Transaction_Req, batch::Bool) where {T<:AbstractCoreTransaction}
        return transaction_query(transaction, request, batch)
end

function transaction_execute(transaction::T, request::grakn.protocol.Transaction_Req) where {T<:AbstractCoreTransaction}
    return transaction_query(transaction, request, true)
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
