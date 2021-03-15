# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api;
# 
# import grakn.client.api.database.DatabaseManager;
# 
# import javax.annotation.CheckReturnValue;
# 
# public interface Client extends AutoCloseable {
# 
#     @CheckReturnValue
#     boolean isOpen();
# 
#     @CheckReturnValue
#     DatabaseManager databases();
# 
#     @CheckReturnValue
#     Session session(String database, Session.Type type);
# 
#     @CheckReturnValue
#     Session session(String database, Session.Type type, GraknOptions options);
# 
#     @CheckReturnValue
#     boolean isCluster();
# 
#     @CheckReturnValue
#     Client.Cluster asCluster();
# 
#     void close();
# 
#     interface Cluster extends Client {
# 
#         @Override
#         @CheckReturnValue
#         DatabaseManager.Cluster databases();
#     }
# }
