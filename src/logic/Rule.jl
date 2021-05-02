# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

abstract type AbstractRule end

struct Rule <: AbstractRule
    label::String
    when::String
    then::String
end

function Rule(rule::Proto.Rule)
    _label = rule.label
    _when = rule.when
    _then = rule.then

    return Rule(_label, _when, _then)
end

"""
    Remote

Wrapper type that encapsulates a Rule and transaction.
"""
struct RemoteRule{D <: AbstractRule, T <: AbstractCoreTransaction}
    rule::D
    transaction::T
end

"""
    as_remote(x, t)

Create a `Remote`(@ref) object for a concept `x` with a
transaction `t`.
"""
function as_remote(x::D, t::T) where {
    D<: AbstractRule, T <: AbstractCoreTransaction
}
    return RemoteRule{D, T}(x, t)
end

function Base.show(io::IO, rule::Rule)
    println(io, "Rule:")
    println(io, "label: $(rule.label) when: $(rule.when) , then: $(rule.then)")
end

is_remote(rule::Rule) = false
is_remote(rule::RemoteRule) = true


function set_label(remote::RemoteRule, new_label::String)
    dbResult = execute(remote.rule.transaction, RuleRequestBuilder.rule_set_label_req(remote.label, new_label))
    remote.rule.label = new_label
    return remote
end

function delete(remote::RemoteRule)
    execute(remote.transaction, RuleRequestBuilder.rule_delete_req(remote.rule.label))
end

function is_deleted(remote::RemoteRule)
    dbResult = execute(remote.transaction, LogicManagerRequestBuilder.get_rule_req(remote.rule.label))
    return !hasproperty(dbResult[1].logic_manager_res.get_rule_res,:res)
end
