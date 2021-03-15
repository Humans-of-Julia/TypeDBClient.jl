# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api.database;
# 
# import javax.annotation.CheckReturnValue;
# import java.util.List;
# 
# public interface DatabaseManager {
# 
#     @CheckReturnValue
#     boolean contains(String name);
# 
#     // TODO: Return type should be 'Database' but right now that would require 2 server calls in Cluster
#     void create(String name);
# 
#     @CheckReturnValue
#     Database get(String name);
# 
#     @CheckReturnValue
#     List<? extends Database> all();
# 
#     interface Cluster extends DatabaseManager {
# 
#         @Override
#         @CheckReturnValue
#         Database.Cluster get(String name);
# 
#         @Override
#         @CheckReturnValue
#         List<Database.Cluster> all();
#     }
# }
