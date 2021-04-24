# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

mutable struct QueryManagerImpl
end

#
# package typedb.client.query;
#
# import typedb.client.api.TypeDBOptions;
# import typedb.client.api.TypeDBTransaction;
# import typedb.client.api.answer.ConceptMap;
# import typedb.client.api.answer.ConceptMapGroup;
# import typedb.client.api.answer.Numeric;
# import typedb.client.api.answer.NumericGroup;
# import typedb.client.api.query.QueryFuture;
# import typedb.client.api.query.QueryManager;
# import typedb.client.concept.answer.ConceptMapGroupImpl;
# import typedb.client.concept.answer.ConceptMapImpl;
# import typedb.client.concept.answer.NumericGroupImpl;
# import typedb.client.concept.answer.NumericImpl;
# import typedb.protocol.QueryProto;
# import typedb.protocol.TransactionProto;
# import graql.lang.query.GraqlDefine;
# import graql.lang.query.GraqlDelete;
# import graql.lang.query.GraqlInsert;
# import graql.lang.query.GraqlMatch;
# import graql.lang.query.GraqlUndefine;
# import graql.lang.query.GraqlUpdate;
#
# import java.util.stream.Stream;
#
# import static typedb.client.common.rpc.RequestBuilder.QueryManager.defineReq;
# import static typedb.client.common.rpc.RequestBuilder.QueryManager.deleteReq;
# import static typedb.client.common.rpc.RequestBuilder.QueryManager.insertReq;
# import static typedb.client.common.rpc.RequestBuilder.QueryManager.matchAggregateReq;
# import static typedb.client.common.rpc.RequestBuilder.QueryManager.matchGroupAggregateReq;
# import static typedb.client.common.rpc.RequestBuilder.QueryManager.matchGroupReq;
# import static typedb.client.common.rpc.RequestBuilder.QueryManager.matchReq;
# import static typedb.client.common.rpc.RequestBuilder.QueryManager.undefineReq;
# import static typedb.client.common.rpc.RequestBuilder.QueryManager.updateReq;
#
# public final class QueryManagerImpl implements QueryManager {
#
#     private final TypeDBTransaction.Extended transactionRPC;
#
#     public QueryManagerImpl(TypeDBTransaction.Extended transactionRPC) {
#         this.transactionRPC = transactionRPC;
#     }
#
#     @Override
#     public Stream<ConceptMap> match(GraqlMatch query) {
#         return match(query, TypeDBOptions.core());
#     }
#
#     @Override
#     public Stream<ConceptMap> match(GraqlMatch query, TypeDBOptions options) {
#         return stream(matchReq(query, options.proto()))
#                 .flatMap(rp -> rp.getMatchResPart().getAnswersList().stream())
#                 .map(ConceptMapImpl::of);
#     }
#
#     @Override
#     public QueryFuture<Numeric> match(GraqlMatch.Aggregate query) {
#         return match(query, TypeDBOptions.core());
#     }
#
#     @Override
#     public QueryFuture<Numeric> match(GraqlMatch.Aggregate query, TypeDBOptions options) {
#         return query(matchAggregateReq(query, options.proto()))
#                 .map(r -> r.getMatchAggregateRes().getAnswer())
#                 .map(NumericImpl::of);
#     }
#
#     @Override
#     public Stream<ConceptMapGroup> match(GraqlMatch.Group query) {
#         return match(query, TypeDBOptions.core());
#     }
#
#     @Override
#     public Stream<ConceptMapGroup> match(GraqlMatch.Group query, TypeDBOptions options) {
#         return stream(matchGroupReq(query, options.proto()))
#                 .flatMap(rp -> rp.getMatchGroupResPart().getAnswersList().stream())
#                 .map(ConceptMapGroupImpl::of);
#     }
#
#     @Override
#     public Stream<NumericGroup> match(GraqlMatch.Group.Aggregate query) {
#         return match(query, TypeDBOptions.core());
#     }
#
#     @Override
#     public Stream<NumericGroup> match(GraqlMatch.Group.Aggregate query, TypeDBOptions options) {
#         return stream(matchGroupAggregateReq(query, options.proto()))
#                 .flatMap(rp -> rp.getMatchGroupAggregateResPart().getAnswersList().stream())
#                 .map(NumericGroupImpl::of);
#     }
#
#     @Override
#     public Stream<ConceptMap> insert(GraqlInsert query) {
#         return insert(query, TypeDBOptions.core());
#     }
#
#     @Override
#     public Stream<ConceptMap> insert(GraqlInsert query, TypeDBOptions options) {
#         return stream(insertReq(query, options.proto()))
#                 .flatMap(rp -> rp.getInsertResPart().getAnswersList().stream())
#                 .map(ConceptMapImpl::of);
#     }
#
#     @Override
#     public QueryFuture<Void> delete(GraqlDelete query) {
#         return delete(query, TypeDBOptions.core());
#     }
#
#     @Override
#     public QueryFuture<Void> delete(GraqlDelete query, TypeDBOptions options) {
#         return queryVoid(deleteReq(query, options.proto()));
#     }
#
#     @Override
#     public Stream<ConceptMap> update(GraqlUpdate query) {
#         return update(query, TypeDBOptions.core());
#     }
#
#     @Override
#     public Stream<ConceptMap> update(GraqlUpdate query, TypeDBOptions options) {
#         return stream(updateReq(query.toString(), options.proto()))
#                 .flatMap(rp -> rp.getInsertResPart().getAnswersList().stream())
#                 .map(ConceptMapImpl::of);
#     }
#
#     @Override
#     public QueryFuture<Void> define(GraqlDefine query) {
#         return define(query, TypeDBOptions.core());
#     }
#
#     @Override
#     public QueryFuture<Void> define(GraqlDefine query, TypeDBOptions options) {
#         return queryVoid(defineReq(query, options.proto()));
#     }
#
#     @Override
#     public QueryFuture<Void> undefine(GraqlUndefine query) {
#         return undefine(query, TypeDBOptions.core());
#     }
#
#     @Override
#     public QueryFuture<Void> undefine(GraqlUndefine query, TypeDBOptions options) {
#         return queryVoid(undefineReq(query, options.proto()));
#     }
#
#     private QueryFuture<Void> queryVoid(TransactionProto.Transaction.Req.Builder req) {
#         return transactionRPC.query(req).map(res -> null);
#     }
#
#     private QueryFuture<QueryProto.QueryManager.Res> query(TransactionProto.Transaction.Req.Builder req) {
#         return transactionRPC.query(req).map(TransactionProto.Transaction.Res::getQueryManagerRes);
#     }
#
#     private Stream<QueryProto.QueryManager.ResPart> stream(TransactionProto.Transaction.Req.Builder req) {
#         return transactionRPC.stream(req).map(TransactionProto.Transaction.ResPart::getQueryManagerResPart);
#     }
# }
