# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.api;
# 
# import typedb.client.api.database.DatabaseManager;
# 
# import javax.annotation.CheckReturnValue;
# 
# public interface TypeDBClient extends AutoCloseable {
# 
#     @CheckReturnValue
#     boolean isOpen();
# 
#     @CheckReturnValue
#     DatabaseManager databases();
# 
#     @CheckReturnValue
#     TypeDBSession session(String database, TypeDBSession.Type type);
# 
#     @CheckReturnValue
#     TypeDBSession session(String database, TypeDBSession.Type type, TypeDBOptions options);
# 
#     @CheckReturnValue
#     boolean isCluster();
# 
#     @CheckReturnValue
#     TypeDBClient.Cluster asCluster();
# 
#     void close();
# 
#     interface Cluster extends TypeDBClient {
# 
#         @Override
#         @CheckReturnValue
#         DatabaseManager.Cluster databases();
#     }
# }
