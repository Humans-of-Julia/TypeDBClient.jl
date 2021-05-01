# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

struct NumericGroup
    owner::AbstractConcept
    numeric::Number
end

function NumericGroup(res::Proto.NumericGroup)
    _owner = instantiate(res.owner)
    _numeric = _read_proto_number(res.number)
    return NumericGroup(_owner, _numeric)
end
