# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api;
# 
# import grakn.client.api.database.Database;
# import grakn.protocol.SessionProto;
# 
# import javax.annotation.CheckReturnValue;
# 
# public interface Session extends AutoCloseable {
# 
#     @CheckReturnValue
#     boolean isOpen();
# 
#     @CheckReturnValue
#     Type type();
# 
#     @CheckReturnValue
#     Database database();
# 
#     @CheckReturnValue
#     GraknOptions options();
# 
#     @CheckReturnValue
#     Transaction transaction(Transaction.Type type);
# 
#     @CheckReturnValue
#     Transaction transaction(Transaction.Type type, GraknOptions options);
# 
#     void close();
# 
#     enum Type {
#         DATA(0),
#         SCHEMA(1);
# 
#         private final int id;
#         private final boolean isSchema;
# 
#         Type(int id) {
#             this.id = id;
#             this.isSchema = id == 1;
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
#         public boolean isData() { return !isSchema; }
# 
#         public boolean isSchema() { return isSchema; }
# 
#         public SessionProto.Session.Type proto() {
#             return SessionProto.Session.Type.forNumber(id);
#         }
#     }
# }
