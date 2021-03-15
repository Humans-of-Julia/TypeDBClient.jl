# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api.database;
# 
# import javax.annotation.CheckReturnValue;
# import java.util.Optional;
# import java.util.Set;
# 
# public interface Database {
# 
#     @CheckReturnValue
#     String name();
# 
#     void delete();
# 
#     interface Cluster extends Database {
# 
#         @CheckReturnValue
#         Set<? extends Replica> replicas();
# 
#         @CheckReturnValue
#         Optional<? extends Replica> primaryReplica();
# 
#         @CheckReturnValue
#         Replica preferredReplica();
#     }
# 
#     interface Replica {
# 
#         @CheckReturnValue
#         Cluster database();
# 
#         @CheckReturnValue
#         String address();
# 
#         @CheckReturnValue
#         boolean isPrimary();
# 
#         @CheckReturnValue
#         boolean isPreferred();
# 
#         @CheckReturnValue
#         long term();
#     }
# }
