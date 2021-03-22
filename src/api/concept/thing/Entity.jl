# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api.concept.thing;
# 
# import grakn.client.api.GraknTransaction;
# import grakn.client.api.concept.type.EntityType;
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
#     Entity.Remote asRemote(GraknTransaction transaction);
# 
#     interface Remote extends Thing.Remote, Entity {}
# }
