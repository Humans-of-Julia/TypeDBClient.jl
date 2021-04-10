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
# execute(x::Remote{T}, request::Proto.Transaction_Req) = execute(x.transaction, request).type_res
# stream(x::Remote{T}, request::Proto.Transaction_Req) = execute(x.transaction, request)  # iterator?
