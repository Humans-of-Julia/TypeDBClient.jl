# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

# The following abstract types mimics the Concept type hierarchy:
#
# Concept
#   |__ Thing
#   |     |__ Relation
#   |     |__ Entity
#   |     |__ Attribute{VALUE}
#   |__ Type
#         |__ ThingType
#         |     |__ RelationType
#         |     |__ EntityType
#         |     |__ AttributeType
#         |__ RoleType

abstract type AbstractConcept end
abstract type AbstractConceptManager end

abstract type AbstractThing <: AbstractConcept end
abstract type AbstractType  <: AbstractConcept end

# Things
abstract type AbstractRelation     <: AbstractThing end
abstract type AbstractEntity       <: AbstractThing end
abstract type AbstractAttribute{T} <: AbstractThing end

# Types
abstract type AbstractThingType     <: AbstractType end
abstract type AbstractRoleType      <: AbstractType end

# Thing types
abstract type AbstractRelatioinType <: AbstractThingType end
abstract type AbstractEntityType    <: AbstractThingType end
abstract type AbstractAttributeType <: AbstractThingType end

# Remote objects are wrapper for regular concept types

struct Remote{T}
    data::T
    transaction  # TODO specify type when it's ready
end

"""
    as_remote(x, t)

Wrap a concept with a `GraknTransaction`.
"""
as_remote(x::T, t) where {T <: AbstractConcept} = Remote{T}(x, t)

# TODO check with Frank about the transaction API
# execute(x::Remote{T}, request::P.Transaction_Req) = execute(x.transaction, request).type_res
# stream(x::Remote{T}, request::P.Transaction_Req) = execute(x.transaction, request)  # iterator?

#  RelationType

struct RelationType <: AbstractThingType
    label::Label
    is_root::Bool
end

RelationType(t::P._Type) = RelationType(Label(t.label), t.root)

# Relation

struct Relation <: AbstractThing
    iid::String
    type::RelationType
end

function Relation(t::P.Thing)
    iid = join(string(v, base = 16, pad = 2) for v in t.iid)
    return Relation(iid, RelationType(t._type))
end

# RelationType functions

function create(x::Remote{RelationType})
    res_proto = execute(relation_type_create_req(x.data.label))
    return RelationType(res_proto.relation_type_create_req.relation) # Thing => RelationType
end
