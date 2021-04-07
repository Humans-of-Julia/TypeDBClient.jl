# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

struct AttributeType{T} <: AbstractAttributeType
    label::Label
    is_root::Bool
end

# Encode the value type (as defined in Proto.AttributeType_ValueType) in the type parameter
function AttributeType(name::String, is_root::Bool, value_type::EnumType)
    AttributeType{value_type}(Label(name), is_root)
end

let
    function _as_something(value_type::EnumType)
        return function(t::AttributeType{T}) where {T}
            t.is_root || throw(GraknClientException(INVALID_CONCEPT_CASTING, T))
            return AttributeType(Label("attribute"), true, value_type)
        end
    end

    global as_boolean   = _as_something(Proto.AttributeType_ValueType.BOOLEAN)
    global as_long      = _as_something(Proto.AttributeType_ValueType.LONG)
    global as_double    = _as_something(Proto.AttributeType_ValueType.DOUBLE)
    global as_string    = _as_something(Proto.AttributeType_ValueType.STRING)
    global as_date_time = _as_something(Proto.AttributeType_ValueType.DATETIME)
end
