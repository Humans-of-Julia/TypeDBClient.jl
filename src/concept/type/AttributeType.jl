# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

"""
    AttributeType{V} <: AbstractAttributeType

Type parameter `V` contains the value type of an attribute.

```
(OBJECT = 0, BOOLEAN = 1, LONG = 2, DOUBLE = 3, STRING = 4, DATETIME = 5)
```
"""
struct AttributeType{V} <: AbstractAttributeType
    label::Label
    is_root::Bool
end

# More convenient for reference
const VALUE_TYPE = Proto.AttributeType_ValueType

# Encode the value type (as defined in VALUE_TYPE) in the type parameter
function AttributeType(label::Label, is_root::Bool, value_type::EnumType)
    AttributeType{value_type}(label, is_root)
end

# Define conversion functions
let
    function _as_something(value_type::EnumType)
        return function(t::AttributeType{V}) where {V}
            t.is_root || throw(TypeDBClientException(INVALID_CONCEPT_CASTING, V))
            return AttributeType(Label("attribute"), true, value_type)
        end
    end

    global as_boolean   = _as_something(VALUE_TYPE.BOOLEAN)
    global as_long      = _as_something(VALUE_TYPE.LONG)
    global as_double    = _as_something(VALUE_TYPE.DOUBLE)
    global as_string    = _as_something(VALUE_TYPE.STRING)
    global as_date_time = _as_something(VALUE_TYPE.DATETIME)
end

proto(::AttributeType{V}) where {V} = V

# TODO What is Object value type in Java? It needs to return `false` for that.
is_writable(::AttributeType) = true
is_writable(::AttributeType{VALUE_TYPE.OBJECT}) = false

is_keyable(::AttributeType) = false
is_keyable(::AttributeType{VALUE_TYPE.LONG}) = true

# ------------------------------------------------------------------------
# Remote functions
# ------------------------------------------------------------------------

# The following functions do not need to be ported since they're already
# defined in ThingType.jl:
#   set_supertype
#   get_instances

# TODO get_subtypes has some filtering logic...

function get_owners(r::RemoteConcept{C,T}, only_key = false) where {
    C <: AbstractAttributeType, T <: AbstractCoreTransaction
}
    req = AttributeTypeRequestBuilder.get_owners_req(r.concept.label, only_key)
    res = stream(r.transaction, req)
    return instantiate.(collect(Iterators.flatten(
        r.type_res_part.attribute_type_get_owners_res_part.owners for r in res)))
end

#= TODO

proto_attribute_value(value::Bool) = Proto.Attribute_Value(; boolean = value)
proto_attribute_value(value::AbstractFloat) = Proto.Attribute_Value(; double = value)
proto_attribute_value(value::Integer) = Proto.Attribute_Value(; long = value)
proto_attribute_value(value::AbstractString) = Proto.Attribute_Value(; string = value)

# TODO check epoch definition
proto_attribute_value(value::DateTime) = Proto.Attribute_Value(; datetime = value)

function put(r::RemoteConcept{C,T}, value) where {
    C <: AbstractAttributeType, T <: AbstractCoreTransaction
}
    req = AttributeTypeRequestBuilder.put_req(r.concept.label, proto_attribute_value(value))
    res = execute(r.transaction, req)
end

=#
