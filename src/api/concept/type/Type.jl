# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api.concept.type;
# 
# import grakn.client.api.Transaction;
# import grakn.client.api.concept.Concept;
# import grakn.client.common.Label;
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
#     Remote asRemote(Transaction transaction);
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
