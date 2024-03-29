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

# For testing line below commented out FU
# proto(::AttributeType{V}) where {V} = V

# Porting note: Java client calls into RequstBuilder but it really
# has nothing to to with requests... I think it's probably better
# migrating the function here.
function proto(t::AbstractAttributeType)
    Proto._Type(
        label = t.label.name,
        encoding = encoding(t)
    )
    # return RoleTypeRequestBuilder.proto_role_type(t.label, encoding(t))
end

# function to get the value type out of a given AttributeType
proto_value_type(type::AttributeType{V}) where {V} = V

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

# Technically, we can reuse the logic from ThingType. Maybe refactor soon.
function get_subtypes(r::RemoteConcept{<: AbstractAttributeType})

    concept = r.concept
    req = TypeRequestBuilder.get_subtypes_req(label(concept))
    res = execute(r.transaction, req)
    typs = res.type_res_part.type_get_subtypes_res_part.types

    if is_root(concept) && proto_value_type(concept) !== VALUE_TYPE.OBJECT
        return filter(t -> proto(t) == proto(concept) || label(t) == label(concept),
                        [instantiate(t) for t in typs])
    else
        return instantiate.(typs)
    end
end

"""
    get_owners(r::RemoteConcept{<: AbstractAttributeType}, only_key = false)

Returns all ThingTypes which owns the given AttributeType
"""
function get_owners(r::RemoteConcept{<: AbstractAttributeType}, only_key = false)

    req = AttributeTypeRequestBuilder.get_owners_req(r.concept.label, only_key)
    res = stream(r.transaction, req)
    return instantiate.(collect(Iterators.flatten(
        r.type_res_part.attribute_type_get_owners_res_part.owners for r in res)))
end

"""
    get_regex(r::RemoteConcept{<:AbstractAttributeType})

For AttributeTypes with the value type String it is possible to set a regex pattern
to proof the incoming string to fulfill the pattern. Otherwise the insert will fail.
The function wil give back a regex string if set. The regex string follows the conventions
of the Java programming language.
"""
function get_regex(r::RemoteConcept{<:AbstractAttributeType})

    req = AttributeTypeRequestBuilder.get_regex_req(r.concept.label)
    res = execute(r.transaction, req)
    regex = res.type_res.attribute_type_get_regex_res.regex
    return isempty(regex) ? nothing : regex
end


"""
    set_regex(r::RemoteConcept{<:AbstractAttributeType},
        regex::Optional{AbstractString})

For AttributeTypes with the value type String it is possible to set a regex pattern
to check the incoming string matches the pattern, otherwise the insert will fail.
The function will set a regex string to a given attribute. The regex string follows the
conventions of the Java programming language.
"""
function set_regex(r::RemoteConcept{<:AbstractAttributeType}, regex::Optional{AbstractString})

    regex_str = regex === nothing ? "" : regex
    req = AttributeTypeRequestBuilder.set_regex_req(r.concept.label, regex_str)
    return execute(r.transaction, req)
end

proto_attribute_value(value::Bool) = Proto.Attribute_Value(; boolean = value)
proto_attribute_value(value::AbstractFloat) = Proto.Attribute_Value(; double = value)
proto_attribute_value(value::Integer) = Proto.Attribute_Value(; long = value)
proto_attribute_value(value::AbstractString) = Proto.Attribute_Value(; string = value)

# Java client uses epoch of 1970-01-01T00:00:00Z and value is stored as milliseconds
# https://github.com/vaticle/typedb-client-java/blob/fb535f8c9494ec6ff93421e1a962510c6cb46139/concept/thing/AttributeImpl.java#L491
function proto_attribute_value(value::DateTime)
    milliseconds_since_1970 = round(Int64, datetime2unix(value) * 1000)
    return Proto.Attribute_Value(; date_time = milliseconds_since_1970)
end

function Base.get(r::RemoteConcept{<:AbstractAttributeType}, value)
    req = AttributeTypeRequestBuilder.get_req(r.concept.label, proto_attribute_value(value))
    res = execute(r.transaction, req)
    if hasproperty(res.type_res.attribute_type_get_res, :attribute)
        return Attribute(res.type_res.attribute_type_get_res.attribute)
    else
        return nothing
    end
end

function put(r::RemoteConcept{<: AbstractAttributeType}, value)
    req = AttributeTypeRequestBuilder.put_req(r.concept.label, proto_attribute_value(value))
    res = execute(r.transaction, req)
    return Attribute(res.type_res.attribute_type_put_res.attribute)
end
