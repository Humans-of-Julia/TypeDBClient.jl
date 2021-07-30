# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

struct Relation <: AbstractRelation
    iid::String
    type::RelationType
end

function Relation(t::Proto.Thing)
    iid = bytes2hex(t.iid)
    isempty(iid) && throw(TypeDBClientException(CONCEPT_MISSING_IID))
    return Relation(iid, instantiate(t._type))
end

# TODO seems unnecessary?
as_relation(r::Relation) = r

function set_relates(trans::AbstractCoreTransaction,
                    label::Label,
                    role_label::String,
                    overridden_label::Optional{String} = nothing)

    relates_req = RelationTypeRequestBuilder.set_relates_req(label,
                                                role_label,
                                                overridden_label)

    execute(trans, relates_req)
    return nothing
end

# Remote functions


# TODO depends on concepts: RoleType, Thing
