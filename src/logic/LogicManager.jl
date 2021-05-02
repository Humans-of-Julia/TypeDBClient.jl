# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

abstract type AbstractLogicManager end

mutable struct LogicManager <: AbstractLogicManager
    txn::AbstractCoreTransaction
end

function get_rule(log_mgr::AbstractLogicManager, label::String)
    res = first(execute(log_mgr.txn, LogicManagerRequestBuilder.get_rule_req(label)))
    result = if whichOneOf(res.get_rule_res,"res") == "rule"
                Rule(res.get_rule_res.rule)
             else
                nothing
             end
    return result
end

# def get_rules(self):
#     return (_Rule.of(r) for rp in self.stream(logic_manager_get_rules_req()) for r in rp.get_rules_res_part.rules)

# def put_rule(self, label: str, when: str, then: str):
#     return _Rule.of(self.execute(logic_manager_put_rule_req(label, when, then)).put_rule_res.rule)
