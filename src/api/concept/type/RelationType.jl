# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api.concept.type;
# 
# import grakn.client.api.GraknTransaction;
# import grakn.client.api.concept.thing.Relation;
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
#     RelationType.Remote asRemote(GraknTransaction transaction);
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
