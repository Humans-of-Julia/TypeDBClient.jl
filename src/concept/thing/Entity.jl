# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

struct Entity <: AbstractThing
    iid::String
    type::EntityType
end

function Entity(t::Proto.Thing)
    iid = bytes2hex(t.iid)
    isempty(iid) && throw(GraknClientException(CONCEPT_MISSING_IID))
    return Entity(iid, instantiate(t._type))
end
