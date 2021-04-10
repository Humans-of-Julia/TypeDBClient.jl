# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

struct Relation <: AbstractThing
    iid::String
    type::RelationType
end

function Relation(t::Proto.Thing)
    iid = join(string(v, base = 16, pad = 2) for v in t.iid)
    return Relation(iid, RelationType(t._type))
end

# TODO seems unnecessary?
as_relation(r::Relation) = r

# Remote functions

# TODO depends on concepts: RoleType, Thing
