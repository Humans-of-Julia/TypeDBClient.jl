# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

mutable struct LogicManager <: AbstractLogicManager
    transaction::AbstractCoreTransaction
end

"""
    get_rule(log_mgr::AbstractLogicManager, label::AbstractString)

The get_rule function will return the rule for the given label
"""
function get_rule(log_mgr::AbstractLogicManager, label::AbstractString)
    res = execute(log_mgr.transaction, LogicManagerRequestBuilder.get_rule_req(label))
    result = if which_oneof(res.logic_manager_res.get_rule_res, :res) == :rule
                Rule(res.logic_manager_res.get_rule_res.rule)
             else
                nothing
             end
    return result
end
"""
    get_rules(log_mgr::AbstractLogicManager)

Here we get all rules in the schema exposed by the session.
"""
function get_rules(log_mgr::AbstractLogicManager)
    dbResult = stream(log_mgr.transaction, LogicManagerRequestBuilder.get_rules_req())
    answers = [res.logic_manager_res_part.get_rules_res_part.rules for res in dbResult]
    rules = map(Rule,answers)
    result = reduce(vcat, rules)
    return result
end

"""
    put_rule(log_mgr::AbstractLogicManager, label::AbstractString, when::AbstractString, then::AbstractString)

The function gives the possibility to formulate a rule and put it in the database. The when
and then clauses will be written in TypeQL terms.
"""
function put_rule(log_mgr::AbstractLogicManager, label::AbstractString, when::AbstractString, then::AbstractString)
    res = execute(log_mgr.transaction, LogicManagerRequestBuilder.put_rule_req(label, when, then))
    result = Rule(res.logic_manager_res.get_rule_res.rule)
    return result
end
