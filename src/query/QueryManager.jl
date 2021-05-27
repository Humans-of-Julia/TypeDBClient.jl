# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

function match(transaction::AbstractCoreTransaction, query::AbstractString, options = Proto.Options())
    db_result =  stream(transaction, QueryManagerRequestBuilder.match_req(query, options))
    db_result === nothing && return nothing

    return reduce(vcat, map(ConceptMap, [entry.query_manager_res_part.match_res_part.answers for entry in db_result]))
end

function match_aggregate(transaction::AbstractCoreTransaction, query::AbstractString, options = Proto.Options())
    db_result =  execute(transaction, QueryManagerRequestBuilder.match_aggregate_req(query, options))
    return _read_proto_number(db_result.query_manager_res.match_aggregate_res.answer)
end

function match_group(transaction::AbstractCoreTransaction, query::AbstractString, options = Proto.Options())
    db_result =  stream(transaction, QueryManagerRequestBuilder.match_group_req(query, options))
    db_result === nothing && return nothing

    return reduce(vcat, [ConceptMapGroup(item.query_manager_res_part.match_group_res_part.answers) for item in db_result])
end

function match_group_aggregate(transaction::AbstractCoreTransaction, query::AbstractString, options = Proto.Options())
    db_result =  stream(transaction, QueryManagerRequestBuilder.match_group_aggregate_req(query, options))
    db_result === nothing && return nothing

    return reduce(vcat, [NumericGroup(item.match_group_aggregate_res_part.answers) for item in db_result])
end

function insert(transaction::AbstractCoreTransaction, query::AbstractString, options = Proto.Options())
    db_result = stream(transaction, QueryManagerRequestBuilder.insert_req(query, options))
    db_result === nothing && return nothing

    return reduce(vcat, map(ConceptMap, [entry.query_manager_res_part.insert_res_part.answers for entry in db_result]))
end

function delete(transaction::AbstractCoreTransaction, query::AbstractString, options = Proto.Options())
    execute(transaction, QueryManagerRequestBuilder.delete_req(query, options))
    return nothing
end

function update(transaction::AbstractCoreTransaction, query::AbstractString, options = Proto.Options())
    db_result = stream(transaction, QueryManagerRequestBuilder.update_req(query, options))
    db_result === nothing && return nothing

    return reduce(vcat, map(ConceptMap, [entry.query_manager_res_part.update_res_part.answers for entry in db_result]))
end

function explain(transaction::AbstractCoreTransaction, explainable::AbstractExplainable, options = Proto.Options())
    @error "explain isn't implemented yet"
    # return (_Explanation.of(ex) for rp in self.stream(query_manager_explain_req(explainable.explainable_id(), options.proto())) for ex in rp.explain_res_part.explanations)
end

function define(transaction::AbstractCoreTransaction, query::AbstractString, options = Proto.Options())
    execute(transaction, QueryManagerRequestBuilder.define_req(query, options))
    return nothing
end

function undefine(transaction::AbstractCoreTransaction, query::AbstractString, options = Proto.Options())
    execute(transaction, QueryManagerRequestBuilder.undefine_req(query, options))
    return nothing
end

function commit(transaction::AbstractCoreTransaction)
    execute(transaction, TransactionRequestBuilder.commit_req())
    return nothing
end
