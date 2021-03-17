# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api;
# 
# import grakn.client.api.concept.ConceptManager;
# import grakn.client.api.logic.LogicManager;
# import grakn.client.api.query.QueryFuture;
# import grakn.client.api.query.QueryManager;
# import grakn.protocol.TransactionProto;
# 
# import javax.annotation.CheckReturnValue;
# import java.util.stream.Stream;
# 
# public interface Transaction extends AutoCloseable {
# 
#     @CheckReturnValue
#     boolean isOpen();
# 
#     @CheckReturnValue
#     Type type();
# 
#     @CheckReturnValue
#     GraknOptions options();
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
#     interface Extended extends Transaction {
# 
#         TransactionProto.Transaction.Res execute(TransactionProto.Transaction.Req.Builder request);
# 
#         QueryFuture<TransactionProto.Transaction.Res> query(TransactionProto.Transaction.Req.Builder request);
# 
#         Stream<TransactionProto.Transaction.ResPart> stream(TransactionProto.Transaction.Req.Builder request);
#     }
# }
