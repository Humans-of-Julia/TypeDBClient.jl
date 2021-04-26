# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.api.concept.type;
# 
# import typedb.client.api.TypeDBTransaction;
# import typedb.client.api.concept.thing.Entity;
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
#     EntityType.Remote asRemote(TypeDBTransaction transaction);
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
