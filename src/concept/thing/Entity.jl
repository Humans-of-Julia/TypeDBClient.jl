# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

struct Entity <: AbstractEntity
    iid::AbstractString
    type::EntityType
end

function Entity(t::Proto.Thing)
    iid = bytes2hex(t.iid)
    isempty(iid) && throw(TypeDBClientException(CONCEPT_MISSING_IID))
    return Entity(iid, instantiate(t._type))
end
