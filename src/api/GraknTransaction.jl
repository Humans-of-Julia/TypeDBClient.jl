# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.api;
# 
# import typedb.client.api.concept.ConceptManager;
# import typedb.client.api.logic.LogicManager;
# import typedb.client.api.query.QueryFuture;
# import typedb.client.api.query.QueryManager;
# import typedb.protocol.TransactionProto;
# 
# import javax.annotation.CheckReturnValue;
# import java.util.stream.Stream;
# 
# public interface TypeDBTransaction extends AutoCloseable {
# 
#     @CheckReturnValue
#     boolean isOpen();
# 
#     @CheckReturnValue
#     Type type();
# 
#     @CheckReturnValue
#     TypeDBOptions options();
# 
#     @CheckReturnValue
#     ConceptManager concepts();
# 
#     @CheckReturnValue
#     LogicManager logic();
# 
#     @CheckReturnValue
#     QueryManager query();
# 
#     void commit();
# 
#     void rollback();
# 
#     void close();
# 
#     enum Type {
#         READ(0),
#         WRITE(1);
# 
#         private final int id;
#         private final boolean isWrite;
# 
#         Type(int id) {
#             this.id = id;
#             this.isWrite = id == 1;
#         }
# 
#         public static Type of(int value) {
#             for (Type t : values()) {
#                 if (t.id == value) return t;
#             }
#             return null;
#         }
# 
#         public int id() {
#             return id;
#         }
# 
#         public boolean isRead() { return !isWrite; }
# 
#         public boolean isWrite() { return isWrite; }
# 
#         public TransactionProto.Transaction.Type proto() {
#             return TransactionProto.Transaction.Type.forNumber(id);
#         }
#     }
# 
#     interface Extended extends TypeDBTransaction {
# 
#         TransactionProto.Transaction.Res execute(TransactionProto.Transaction.Req.Builder request);
# 
#         QueryFuture<TransactionProto.Transaction.Res> query(TransactionProto.Transaction.Req.Builder request);
# 
#         Stream<TransactionProto.Transaction.ResPart> stream(TransactionProto.Transaction.Req.Builder request);
#     }
# }
