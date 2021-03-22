# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api.query;
# 
# import grakn.client.api.GraknOptions;
# import grakn.client.api.answer.ConceptMap;
# import grakn.client.api.answer.ConceptMapGroup;
# import grakn.client.api.answer.Numeric;
# import grakn.client.api.answer.NumericGroup;
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
#     Stream<ConceptMap> match(GraqlMatch query, GraknOptions options);
# 
#     @CheckReturnValue
#     QueryFuture<Numeric> match(GraqlMatch.Aggregate query);
# 
#     @CheckReturnValue
#     QueryFuture<Numeric> match(GraqlMatch.Aggregate query, GraknOptions options);
# 
#     @CheckReturnValue
#     Stream<ConceptMapGroup> match(GraqlMatch.Group query);
# 
#     @CheckReturnValue
#     Stream<ConceptMapGroup> match(GraqlMatch.Group query, GraknOptions options);
# 
#     @CheckReturnValue
#     Stream<NumericGroup> match(GraqlMatch.Group.Aggregate query);
# 
#     @CheckReturnValue
#     Stream<NumericGroup> match(GraqlMatch.Group.Aggregate query, GraknOptions options);
# 
#     Stream<ConceptMap> insert(GraqlInsert query);
# 
#     Stream<ConceptMap> insert(GraqlInsert query, GraknOptions options);
# 
#     QueryFuture<Void> delete(GraqlDelete query);
# 
#     QueryFuture<Void> delete(GraqlDelete query, GraknOptions options);
# 
#     Stream<ConceptMap> update(GraqlUpdate query);
# 
#     Stream<ConceptMap> update(GraqlUpdate query, GraknOptions options);
# 
#     QueryFuture<Void> define(GraqlDefine query);
# 
#     QueryFuture<Void> define(GraqlDefine query, GraknOptions options);
# 
#     QueryFuture<Void> undefine(GraqlUndefine query);
# 
#     QueryFuture<Void> undefine(GraqlUndefine query, GraknOptions options);
# }
