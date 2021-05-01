# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

function match(transaction::AbstractCoreTransaction, query::String, options = Proto.Options())
    db_result =  execute(transaction, QueryManagerRequestBuilder.match_req(query, options))
    result = ConceptMap[]
    maps = map(x->ConceptMap(x), [entry.query_manager_res_part.match_res_part.answers for entry in db_result])
    for items in maps
        result = vcat(result, items)
    end
    return result
end

function match_aggregate(transaction::AbstractCoreTransaction, query::String, options = Proto.Options())
    db_result =  execute(transaction, QueryManagerRequestBuilder.match_aggregate_req(query, options))
    result = [_read_proto_number(entry.query_manager_res.match_aggregate_res.answer) for entry in db_result]
    return result
end

# function match_group(self, query: str, options: GraknOptions = None)
#     if not options:
#         options = GraknOptions.core()
#     return (_ConceptMapGroup.of(cmg) for rp in self.stream(query_manager_match_group_req(query, options.proto()))
#             for cmg in rp.match_group_res_part.answers)

# end
# function match_group_aggregate(self, query: str, options: GraknOptions = None)
#     if not options:
#         options = GraknOptions.core()
#     return (_NumericGroup.of(ng) for rp in self.stream(query_manager_match_group_aggregate_req(query, options.proto()))
#             for ng in rp.match_group_aggregate_res_part.answers)

# end

function insert(transaction::AbstractCoreTransaction, query::String, options = Proto.Options())
    req = TransactionRequestBuilder.commit_req()
    req.req_id = bytes(uuid4())
    commit_req = Proto.Transaction_Client(;reqs= [req])
    db_result = execute(transaction, QueryManagerRequestBuilder.insert_req(query, options))
    # sleep(2)
    # if !istaskdone(db_result)
    #     @debug "insert task failed: $(istaskfailed(db_result))"
    #     put!(transaction.bidirectional_stream.input_channel, commit_req)
    # end
    maps = map(x->ConceptMap(x), [entry.query_manager_res_part.insert_res_part.answers for entry in db_result])
    return maps
end

# function delete(self, query: str, options: GraknOptions = None)
#     if not options:
#         options = GraknOptions.core()
#     return self.query_void(query_manager_delete_req(query, options.proto()))

# end
# function update(self, query: str, options: GraknOptions = None)
#     if not options:
#         options = GraknOptions.core()
#     return (_ConceptMap.of(cm) for rp in self.stream(query_manager_update_req(query, options.proto())) for cm in rp.update_res_part.answers)

# end
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

#uitility Functions

function _read_proto_number(proto_numeric)
    kind_of_result = which_oneof(proto_numeric, :value)
    return getproperty(proto_numeric, kind_of_result)
end
