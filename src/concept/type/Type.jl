# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

"""
    instantiate(p)

Create a suitable object according to the type specified in the ProtoBuf object `p`.
Return value will be a subtype of `AbstractType`.
"""
function instantiate(t::Proto._Type)
    label = hasproperty(t, :scope) ? Label(t.scope, t.label) : Label(t.label)
    if t.encoding == Proto.Type_Encoding.ROLE_TYPE
        return RoleType(label, t.root)
    elseif t.encoding == Proto.Type_Encoding.RELATION_TYPE
        return RelationType(label, t.root)
    elseif t.encoding == Proto.Type_Encoding.ATTRIBUTE_TYPE
        return AttributeType(label, t.root, t.value_type)
    elseif t.encoding == Proto.Type_Encoding.ENTITY_TYPE
        return EntityType(label, t.root)
    elseif t.encoding == Proto.Type_Encoding.THING_TYPE
        return ThingType(label, t.root)
    else
        throw(TypeDBClientException(CONCEPT_BAD_ENCODING, t.encoding))
    end
end

"""
    ==(type1::AbstractType, type2::AbstractType)
secures the equality of two types by comparing the two labels and the
same type.
"""
function ==(type1::AbstractType, type2::AbstractType)
    if type1 === type2
        return true
    elseif typeof(type1) == typeof(type2) && type1.label == type2.label
        return true
    else
        return false
    end
end

"""
    encoding(t)

Return the ProtoBuf encoding value for the given concept type `t`.
"""
function encoding end

encoding(t::AbstractEntityType) = Proto.Type_Encoding.ENTITY_TYPE
encoding(t::AbstractRelationType) = Proto.Type_Encoding.RELATION_TYPE
encoding(t::AbstractAttributeType) = Proto.Type_Encoding.ATTRIBUTE_TYPE
encoding(t::AbstractRoleType) = Proto.Type_Encoding.ROLE_TYPE
encoding(t::AbstractThingType) = Proto.Type_Encoding.THING_TYPE

# TODO The UNRECOGNIZED enum is missing; need to regenerate from proto?
# encoding(t::AbstractType) = Proto.Type_Encoding.UNRECOGNIZED

# I don't think this is unnecessary since the user can broadcast themselves
# proto(types::AbstractVector{T}) where {T <: AbstractType} = proto.(types)
