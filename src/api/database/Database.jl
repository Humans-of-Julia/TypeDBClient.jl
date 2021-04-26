# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.api.database;
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
#     @CheckReturnValue
#     String schema();
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
