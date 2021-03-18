# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api.concept.type;
# 
# import grakn.client.api.GraknTransaction;
# import grakn.client.api.concept.thing.Entity;
# 
# import javax.annotation.CheckReturnValue;
# import java.util.stream.Stream;
# 
# public interface EntityType extends ThingType {
# 
#     @Override
#     @CheckReturnValue
#     default boolean isEntityType() {
#         return true;
#     }
# 
#     @Override
#     @CheckReturnValue
#     EntityType.Remote asRemote(GraknTransaction transaction);
# 
#     interface Remote extends ThingType.Remote, EntityType {
# 
#         @CheckReturnValue
#         Entity create();
# 
#         @Override
#         @CheckReturnValue
#         Stream<? extends Entity> getInstances();
# 
#         @Override
#         @CheckReturnValue
#         Stream<? extends EntityType> getSubtypes();
# 
#         void setSupertype(EntityType superEntityType);
#     }
# }
