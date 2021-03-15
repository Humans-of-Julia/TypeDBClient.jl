# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api.logic;
# 
# import graql.lang.pattern.Pattern;
# 
# import javax.annotation.CheckReturnValue;
# import javax.annotation.Nullable;
# import java.util.stream.Stream;
# 
# public interface LogicManager {
# 
#     @Nullable
#     @CheckReturnValue
#     Rule getRule(String label);
# 
#     @CheckReturnValue
#     Stream<? extends Rule> getRules();
# 
#     Rule putRule(String label, Pattern when, Pattern then);
# }
