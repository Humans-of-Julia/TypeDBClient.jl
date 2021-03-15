# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api.concept.type;
# 
# import grakn.client.api.Transaction;
# 
# import java.util.stream.Stream;
# 
# public interface RoleType extends Type {
# 
#     String getScope();
# 
#     String getScopedLabel();
# 
#     @Override
#     default boolean isRoleType() {
#         return true;
#     }
# 
#     @Override
#     RoleType.Remote asRemote(Transaction transaction);
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
