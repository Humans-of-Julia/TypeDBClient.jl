# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.common;
# 
# import javax.annotation.Nullable;
# import java.util.Objects;
# import java.util.Optional;
# 
# public class Label {
# 
#     private final String scope;
#     private final String name;
#     private final int hash;
# 
#     private Label(@Nullable String scope, String name) {
#         this.scope = scope;
#         this.name = name;
#         this.hash = Objects.hash(name, scope);
#     }
# 
#     public static Label of(String name) {
#         return new Label(null, name);
#     }
# 
#     public static Label of(String scope, String name) {
#         return new Label(scope, name);
#     }
# 
#     public Optional<String> scope() {
#         return Optional.ofNullable(scope);
#     }
# 
#     public String name() {
#         return name;
#     }
# 
#     public String scopedName() {
#         if (scope == null) return name;
#         else return scope + ":" + name;
#     }
# 
#     @Override
#     public String toString() {
#         return scopedName();
#     }
# 
#     @Override
#     public boolean equals(Object o) {
#         if (this == o) return true;
#         if (o == null || getClass() != o.getClass()) return false;
# 
#         Label that = (Label) o;
#         return this.name.equals(that.name) && Objects.equals(this.scope, that.scope);
#     }
# 
#     @Override
#     public int hashCode() {
#         return hash;
#     }
# }
