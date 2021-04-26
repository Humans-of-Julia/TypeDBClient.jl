# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

struct AttributeType{V} <: AbstractAttributeType
    label::Label
    is_root::Bool
end

# More convenient for reference
const VALUE_TYPE = Proto.AttributeType_ValueType

# Encode the value type (as defined in VALUE_TYPE) in the type parameter
function AttributeType(name::String, is_root::Bool, value_type::EnumType)
    AttributeType{value_type}(Label(name), is_root)
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
