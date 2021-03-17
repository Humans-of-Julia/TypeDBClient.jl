# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.core;
# 
# import com.google.protobuf.ByteString;
# import grakn.client.api.GraknOptions;
# import grakn.client.api.Transaction;
# import grakn.client.api.concept.ConceptManager;
# import grakn.client.api.logic.LogicManager;
# import grakn.client.api.query.QueryFuture;
# import grakn.client.api.query.QueryManager;
# import grakn.client.common.GraknClientException;
# import grakn.client.common.Proto;
# import grakn.client.concept.ConceptManagerImpl;
# import grakn.client.logic.LogicManagerImpl;
# import grakn.client.query.QueryManagerImpl;
# import grakn.client.stream.BidirectionalStream;
# import grakn.client.stream.RequestTransmitter;
# import grakn.protocol.TransactionProto;
# import grakn.protocol.TransactionProto.Transaction.ResPart;
# import io.grpc.StatusRuntimeException;
# 
# import java.util.stream.Stream;
# 
# import static grakn.client.common.ErrorMessage.Client.TRANSACTION_CLOSED;
# 
# public class CoreTransaction implements Transaction.Extended {
# 
#     private final Transaction.Type type;
#     private final GraknOptions options;
#     private final ConceptManager conceptManager;
#     private final LogicManager logicManager;
#     private final QueryManager queryManager;
# 
#     private final BidirectionalStream bidirectionalStream;
# 
#     CoreTransaction(CoreSession sessionRPC, ByteString sessionId, Type type,
#                     GraknOptions options, RequestTransmitter transmitter) {
#         try {
#             sessionRPC.reconnect();
#             this.type = type;
#             this.options = options;
#             conceptManager = new ConceptManagerImpl(this);
#             logicManager = new LogicManagerImpl(this);
#             queryManager = new QueryManagerImpl(this);
#             bidirectionalStream = new BidirectionalStream(sessionRPC.channel(), transmitter);
#             execute(Proto.Transaction.open(sessionId, type.proto(), options.proto(), sessionRPC.networkLatencyMillis()), false);
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
#     public ConceptManager concepts() { return conceptManager; }
# 
#     @Override
#     public LogicManager logic() { return logicManager; }
# 
#     @Override
#     public QueryManager query() { return queryManager; }
# 
#     @Override
#     public TransactionProto.Transaction.Res execute(TransactionProto.Transaction.Req.Builder request) {
#         return execute(request, true);
#     }
# 
#     private TransactionProto.Transaction.Res execute(TransactionProto.Transaction.Req.Builder request, boolean batch) {
#         return query(request, batch).map(res -> res).get();
#     }
# 
#     @Override
#     public QueryFuture<TransactionProto.Transaction.Res> query(TransactionProto.Transaction.Req.Builder request) {
#         return query(request, true);
#     }
# 
#     private QueryFuture<TransactionProto.Transaction.Res> query(
#             TransactionProto.Transaction.Req.Builder request, boolean batch) {
#         if (!isOpen()) throw new GraknClientException(TRANSACTION_CLOSED);
#         return () -> bidirectionalStream.single(request, batch).get();
#     }
# 
#     @Override
#     public Stream<ResPart> stream(TransactionProto.Transaction.Req.Builder request) {
#         if (!isOpen()) throw new GraknClientException(TRANSACTION_CLOSED);
#         return bidirectionalStream.stream(request);
#     }
# 
#     @Override
#     public void commit() {
#         try {
#             execute(Proto.Transaction.commit());
#         } finally {
#             close();
#         }
#     }
# 
#     @Override
#     public void rollback() {
#         execute(Proto.Transaction.rollback());
#     }
# 
#     @Override
#     public void close() {
#         bidirectionalStream.close();
#     }
# }