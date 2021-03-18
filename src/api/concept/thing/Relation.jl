# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api.concept.thing;
# 
# import grakn.client.api.GraknTransaction;
# import grakn.client.api.concept.type.RelationType;
# import grakn.client.api.concept.type.RoleType;
# 
# import javax.annotation.CheckReturnValue;
# import java.util.List;
# import java.util.Map;
# import java.util.stream.Stream;
# 
# public interface Relation extends Thing {
# 
#     @Override
#     @CheckReturnValue
#     default boolean isRelation() {
#         return true;
#     }
# 
#     @Override
#     @CheckReturnValue
#     RelationType getType();
# 
#     @Override
#     @CheckReturnValue
#     Relation.Remote asRemote(GraknTransaction transaction);
# 
#     interface Remote extends Thing.Remote, Relation {
# 
#         void addPlayer(RoleType roleType, Thing player);
# 
#         void removePlayer(RoleType roleType, Thing player);
# 
#         @CheckReturnValue
#         Stream<? extends Thing> getPlayers(RoleType... roleTypes);
# 
#         @CheckReturnValue
#         Map<? extends RoleType, ? extends List<? extends Thing>> getPlayersByRoleType();
# 
#         @CheckReturnValue
#         Stream<? extends RoleType> getRelating();
# 
#         @Override
#         @CheckReturnValue
#         Relation.Remote asRelation();
#     }
# }
