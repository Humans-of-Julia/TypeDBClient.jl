# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api;
# 
# import grakn.client.api.database.DatabaseManager;
# 
# import javax.annotation.CheckReturnValue;
# 
# public interface GraknClient extends AutoCloseable {
# 
#     @CheckReturnValue
#     boolean isOpen();
# 
#     @CheckReturnValue
#     DatabaseManager databases();
# 
#     @CheckReturnValue
#     GraknSession session(String database, GraknSession.Type type);
# 
#     @CheckReturnValue
#     GraknSession session(String database, GraknSession.Type type, GraknOptions options);
# 
#     @CheckReturnValue
#     boolean isCluster();
# 
#     @CheckReturnValue
#     GraknClient.Cluster asCluster();
# 
#     void close();
# 
#     interface Cluster extends GraknClient {
# 
#         @Override
#         @CheckReturnValue
#         DatabaseManager.Cluster databases();
#     }
# }
