# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api.logic;
# 
# import grakn.client.api.GraknTransaction;
# import graql.lang.pattern.Pattern;
# 
# import javax.annotation.CheckReturnValue;
# 
# public interface Rule {
# 
#     @CheckReturnValue
#     String getLabel();
# 
#     @CheckReturnValue
#     Pattern getWhen();
# 
#     @CheckReturnValue
#     Pattern getThen();
# 
#     @CheckReturnValue
#     Rule.Remote asRemote(GraknTransaction transaction);
# 
#     @CheckReturnValue
#     boolean isRemote();
# 
#     interface Remote extends Rule {
# 
#         void setLabel(String label);
# 
#         void delete();
# 
#         @CheckReturnValue
#         boolean isDeleted();
#     }
# }
