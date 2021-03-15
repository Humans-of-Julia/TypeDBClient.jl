# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api.query;
# 
# import java.util.function.Function;
# 
# public interface QueryFuture<T> {
# 
#     T get();
# 
#     default <U> QueryFuture<U> map(Function<T, U> function) {
#         return new Mapped<>(this, function);
#     }
# 
#     class Mapped<T, U> implements QueryFuture<U> {
# 
#         private final QueryFuture<T> queryFuture;
#         private final Function<T, U> function;
# 
#         public Mapped(QueryFuture<T> queryFuture, Function<T, U> function) {
#             this.queryFuture = queryFuture;
#             this.function = function;
#         }
# 
#         @Override
#         public U get() {
#             return function.apply(queryFuture.get());
#         }
#     }
# }
