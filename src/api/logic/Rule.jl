# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.api.logic;
# 
# import typedb.client.api.TypeDBTransaction;
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
#     Rule.Remote asRemote(TypeDBTransaction transaction);
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
