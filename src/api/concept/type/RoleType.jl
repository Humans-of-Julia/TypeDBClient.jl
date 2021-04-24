# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.api.concept.type;
# 
# import typedb.client.api.TypeDBTransaction;
# 
# import java.util.stream.Stream;
# 
# public interface RoleType extends Type {
# 
#     @Override
#     default boolean isRoleType() {
#         return true;
#     }
# 
#     @Override
#     RoleType.Remote asRemote(TypeDBTransaction transaction);
# 
#     interface Remote extends Type.Remote, RoleType {
# 
#         @Override
#         RoleType getSupertype();
# 
#         @Override
#         Stream<? extends RoleType> getSupertypes();
# 
#         @Override
#         Stream<? extends RoleType> getSubtypes();
# 
#         RelationType getRelationType();
# 
#         Stream<? extends RelationType> getRelationTypes();
# 
#         Stream<? extends ThingType> getPlayers();
#     }
# }
