# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

struct Explanation{T<:AbstractRule}
    rule::T
    variable_mapping::Dict{String,Vector{String}}
    conclusion::ConceptMap
    condition::ConceptMap
end

function Explanation(explanation::Proto.Explanation)
    rule = Rule(explanation.rule)
    mapping = _var_mapping_of(explanation.var_mapping)
    conclusion = ConceptMap(explanation.conclusion)
    condition = ConceptMap(explanation.condition)
    return Explanation(rule, mapping, conclusion, condition)
end

function Base.show(io::IO, exp::Explanation)
   println(io, "Explanation:")
   println(io, "\t rule: $(exp.rule)")
   println(io, "\t variable_mapping: $(exp.variable_mapping)")
   println(io, "\t then_answer: $(exp.conclusion)")
   println(io, "\t when_answer: $(exp.condition)")
end


function _var_mapping_of(var_mapping::Dict{AbstractString,Proto.Explanation_VarList})
    mapping = Dict{String,Vector{String}}()
    for (key, varList) in var_mapping
        mapping[key] = varList.vars
    end
    return mapping
end
