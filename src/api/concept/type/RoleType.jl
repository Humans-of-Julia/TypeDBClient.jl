# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api.concept.type;
# 
# import grakn.client.api.GraknTransaction;
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
#     RoleType.Remote asRemote(GraknTransaction transaction);
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