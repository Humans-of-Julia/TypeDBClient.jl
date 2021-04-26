# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.api.concept.type;
# 
# import typedb.client.api.TypeDBTransaction;
# import typedb.client.api.concept.thing.Relation;
# 
# import javax.annotation.CheckReturnValue;
# import javax.annotation.Nullable;
# import java.util.stream.Stream;
# 
# public interface RelationType extends ThingType {
# 
#     @Override
#     default boolean isRelationType() {
#         return true;
#     }
# 
#     @Override
#     RelationType.Remote asRemote(TypeDBTransaction transaction);
# 
#     interface Remote extends ThingType.Remote, RelationType {
# 
#         @CheckReturnValue
#         Relation create();
# 
#         @Override
#         @CheckReturnValue
#         Stream<? extends Relation> getInstances();
# 
#         @CheckReturnValue
#         Stream<? extends RoleType> getRelates();
# 
#         @Nullable
#         @CheckReturnValue
#         RoleType getRelates(String roleLabel);
# 
#         void setRelates(String roleLabel);
# 
#         void setRelates(String roleLabel, String overriddenLabel);
# 
#         void unsetRelates(String roleLabel);
# 
#         @Override
#         @CheckReturnValue
#         Stream<? extends RelationType> getSubtypes();
# 
#         void setSupertype(RelationType superRelationType);
#     }
# }
