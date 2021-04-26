# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.api;
# 
# import typedb.client.api.database.Database;
# import typedb.protocol.SessionProto;
# 
# import javax.annotation.CheckReturnValue;
# 
# public interface TypeDBSession extends AutoCloseable {
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
#     TypeDBOptions options();
# 
#     @CheckReturnValue
#     TypeDBTransaction transaction(TypeDBTransaction.Type type);
# 
#     @CheckReturnValue
#     TypeDBTransaction transaction(TypeDBTransaction.Type type, TypeDBOptions options);
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
