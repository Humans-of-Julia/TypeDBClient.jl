# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.api.concept.type;
# 
# import typedb.client.api.TypeDBTransaction;
# import typedb.client.api.concept.Concept;
# import typedb.client.common.Label;
# 
# import javax.annotation.CheckReturnValue;
# import javax.annotation.Nullable;
# import java.util.stream.Stream;
# 
# public interface Type extends Concept {
# 
#     @CheckReturnValue
#     Label getLabel();
# 
#     @CheckReturnValue
#     boolean isRoot();
# 
#     @Override
#     default boolean isType() {
#         return true;
#     }
# 
#     @Override
#     Remote asRemote(TypeDBTransaction transaction);
# 
#     interface Remote extends Type, Concept.Remote {
# 
#         void setLabel(String label);
# 
#         @CheckReturnValue
#         boolean isAbstract();
# 
#         @Nullable
#         @CheckReturnValue
#         Type getSupertype();
# 
#         @CheckReturnValue
#         Stream<? extends Type> getSupertypes();
# 
#         @CheckReturnValue
#         Stream<? extends Type> getSubtypes();
#     }
# }
