# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.api.concept.thing;
# 
# import typedb.client.api.TypeDBTransaction;
# import typedb.client.api.concept.type.EntityType;
# 
# import javax.annotation.CheckReturnValue;
# 
# public interface Entity extends Thing {
# 
#     @Override
#     @CheckReturnValue
#     default boolean isEntity() {
#         return true;
#     }
# 
#     @Override
#     @CheckReturnValue
#     EntityType getType();
# 
#     @Override
#     @CheckReturnValue
#     Entity.Remote asRemote(TypeDBTransaction transaction);
# 
#     interface Remote extends Thing.Remote, Entity {}
# }
