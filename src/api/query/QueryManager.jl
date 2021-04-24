# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.api.query;
# 
# import typedb.client.api.TypeDBOptions;
# import typedb.client.api.answer.ConceptMap;
# import typedb.client.api.answer.ConceptMapGroup;
# import typedb.client.api.answer.Numeric;
# import typedb.client.api.answer.NumericGroup;
# import graql.lang.query.GraqlDefine;
# import graql.lang.query.GraqlDelete;
# import graql.lang.query.GraqlInsert;
# import graql.lang.query.GraqlMatch;
# import graql.lang.query.GraqlUndefine;
# import graql.lang.query.GraqlUpdate;
# 
# import javax.annotation.CheckReturnValue;
# import java.util.stream.Stream;
# 
# public interface QueryManager {
# 
#     @CheckReturnValue
#     Stream<ConceptMap> match(GraqlMatch query);
# 
#     @CheckReturnValue
#     Stream<ConceptMap> match(GraqlMatch query, TypeDBOptions options);
# 
#     @CheckReturnValue
#     QueryFuture<Numeric> match(GraqlMatch.Aggregate query);
# 
#     @CheckReturnValue
#     QueryFuture<Numeric> match(GraqlMatch.Aggregate query, TypeDBOptions options);
# 
#     @CheckReturnValue
#     Stream<ConceptMapGroup> match(GraqlMatch.Group query);
# 
#     @CheckReturnValue
#     Stream<ConceptMapGroup> match(GraqlMatch.Group query, TypeDBOptions options);
# 
#     @CheckReturnValue
#     Stream<NumericGroup> match(GraqlMatch.Group.Aggregate query);
# 
#     @CheckReturnValue
#     Stream<NumericGroup> match(GraqlMatch.Group.Aggregate query, TypeDBOptions options);
# 
#     Stream<ConceptMap> insert(GraqlInsert query);
# 
#     Stream<ConceptMap> insert(GraqlInsert query, TypeDBOptions options);
# 
#     QueryFuture<Void> delete(GraqlDelete query);
# 
#     QueryFuture<Void> delete(GraqlDelete query, TypeDBOptions options);
# 
#     Stream<ConceptMap> update(GraqlUpdate query);
# 
#     Stream<ConceptMap> update(GraqlUpdate query, TypeDBOptions options);
# 
#     QueryFuture<Void> define(GraqlDefine query);
# 
#     QueryFuture<Void> define(GraqlDefine query, TypeDBOptions options);
# 
#     QueryFuture<Void> undefine(GraqlUndefine query);
# 
#     QueryFuture<Void> undefine(GraqlUndefine query, TypeDBOptions options);
# }
