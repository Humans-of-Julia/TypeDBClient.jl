# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

struct Attribute{S, T} <: AbstractAttribute
    iid::String
    type::AttributeType{S}
    value::T
end

function Attribute(t::Proto.Thing)
    iid = bytes2hex(t.iid)
    isempty(iid) && throw(TypeDBClientException(CONCEPT_MISSING_IID))

    attribute_type = instantiate(t._type)
    value_type = first(typeof(attribute_type).parameters)

    if value_type == Proto.AttributeType_ValueType.BOOLEAN
        return Attribute(iid, attribute_type, t.value.boolean)
    elseif value_type == Proto.AttributeType_ValueType.LONG
        return Attribute(iid, attribute_type, t.value.long)
    elseif value_type == Proto.AttributeType_ValueType.DOUBLE
        return Attribute(iid, attribute_type, t.value.double)
    elseif value_type == Proto.AttributeType_ValueType.STRING
        return Attribute(iid, attribute_type, t.value.string)
    elseif value_type == Proto.AttributeType_ValueType.DATETIME
        return Attribute(iid, attribute_type, t.value.date_time)
    else
        throw(TypeDBClientException(CONCEPT_BAD_VALUE_TYPE))
    end
end

function get_owners(transaction::AbstractCoreTransaction,
                    attribute::AbstractAttribute,
                    thing_type::Optional{AbstractThingType} = nothing)
    iid = attribute.iid
    owner_req = thing_type === nothing ?
                                ThingRequestBuilder.attribute_get_owners_req(iid) :
                                ThingRequestBuilder.attribute_get_owners_req(iid, proto(thing_type))

    res_owners = stream(transaction, owner_req)
    return instantiate.(collect(Iterators.flatten(
        r.thing_res_part.attribute_get_owners_res_part.things for r in res_owners)))
end
