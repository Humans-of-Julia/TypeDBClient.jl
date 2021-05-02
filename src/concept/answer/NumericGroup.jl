# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

struct NumericGroup{T<:AbstractConcept}
    owner::T
    numeric::Number
end

function NumericGroup(res::Proto.NumericGroup)
    owner = instantiate(res.owner)
    numeric = _read_proto_number(res.number)
    return NumericGroup(owner, numeric)
end

function NumericGroup(res::Vector{Proto.NumericGroup})
    return NumericGroup.(res)
end
