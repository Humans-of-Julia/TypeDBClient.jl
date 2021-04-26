# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.api.concept.thing;
# 
# import typedb.client.api.TypeDBTransaction;
# import typedb.client.api.concept.type.RelationType;
# import typedb.client.api.concept.type.RoleType;
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
#     Relation.Remote asRemote(TypeDBTransaction transaction);
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
