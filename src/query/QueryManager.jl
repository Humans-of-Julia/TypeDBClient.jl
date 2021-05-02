# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

function match(transaction::AbstractCoreTransaction, query::String, options = Proto.Options())
    db_result =  execute(transaction, QueryManagerRequestBuilder.match_req(query, options))
    maps = map(x->ConceptMap(x), [entry.query_manager_res_part.match_res_part.answers for entry in db_result])
    result = reduce(vcat, maps)
    return result
end

function match_aggregate(transaction::AbstractCoreTransaction, query::String, options = Proto.Options())
    db_result =  execute(transaction, QueryManagerRequestBuilder.match_aggregate_req(query, options))
    result = [_read_proto_number(entry.query_manager_res.match_aggregate_res.answer) for entry in db_result]
    return result
end

function match_group(transaction::AbstractCoreTransaction, query::String, options = Proto.Options())
    db_result =  execute(transaction, QueryManagerRequestBuilder.match_group_req(query, options))
    maps =  [ConceptMapGroup(item.query_manager_res_part.match_group_res_part.answers) for item in db_result]
    result = reduce(vcat, maps)
    return result
end

function match_group_aggregate(transaction::AbstractCoreTransaction, query::String, options = Proto.Options())
    db_result =  execute(transaction, QueryManagerRequestBuilder.match_group_aggregate_req(query, options))
    maps = [NumericGroup(item.match_group_aggregate_res_part.answers) for item in db_result]
    result = reduce(vcat, maps)
    return result
end

function insert(transaction::AbstractCoreTransaction, query::String, options = Proto.Options())
    db_result = execute(transaction, QueryManagerRequestBuilder.insert_req(query, options))
    maps = map(x->ConceptMap(x), [entry.query_manager_res_part.insert_res_part.answers for entry in db_result])
    result = reduce(vcat, maps)
    return result
end

function delete(transaction::AbstractCoreTransaction, query::String, options = Proto.Options())
    execute(transaction, QueryManagerRequestBuilder.delete_req(query, options))
end

function update(transaction::AbstractCoreTransaction, query::String, options = Proto.Options())
    db_result = execute(transaction, QueryManagerRequestBuilder.update_req(query, options))
    maps = map(x->ConceptMap(x), [entry.query_manager_res_part.update_res_part.answers for entry in db_result])
    result = reduce(vcat, maps)
    return result
end
# function explain(self, explainable: ConceptMap.Explainable, options: GraknOptions = None)
#     if not options:
#         options = GraknOptions.core()
#     return (_Explanation.of(ex) for rp in self.stream(query_manager_explain_req(explainable.explainable_id(), options.proto())) for ex in rp.explain_res_part.explanations)

# end
# function define(self, query: str, options: GraknOptions = None)
#     if not options:
#         options = GraknOptions.core()
#     return self.query_void(query_manager_define_req(query, options.proto()))

# function undefine(self, query: str, options: GraknOptions = None)
#     if not options:
#         options = GraknOptions.core()
#     return self.query_void(query_manager_undefine_req(query, options.proto()))
#     end
# end

# function query_void(self, req: transaction_proto.Transaction.Req)
#     return self._transaction_ext.run_query(req)
# end

# function query(self, req: transaction_proto.Transaction.Req)
#     return self._transaction_ext.run_query(req).map(lambda res: res.query_manager_res)
# end

# function stream(self, req: transaction_proto.Transaction.Req)
#     return (rp.query_manager_res_part for rp in self._transaction_ext.stream(req))
# end
