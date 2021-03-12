# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE


# from datetime import datetime
# from typing import List

# import grakn_protocol.protobuf.concept_pb2 as concept_proto

# from grakn.common.exception import GraknClientException
# from grakn.concept.type.value_type import ValueType

function iid(iid_::String)
    bytes = hex2bytes(lstrip(iid_,['0','x']))
end

function thing(thing_)
    proto_thing = grakn.protocol.Thing()
    proto_thing.iid = iid(get_iid(thing_))

    proto_thing
end

function type_(_type)
    proto_type = grakn.protocol.Type()
    proto_type.label = get_label(_type)
    proto_type.encoding = encoding(_type)

    if _type.is_role_type()
        proto_type.scope = get_scope(_type)
    end

    proto_type
end

function types(types_)
    map(_type -> type_(_type), types_)
end

function boolean_attribute_value(value::Bool)
    value_proto = grakn.protocol.Attribute_Value()
    value_proto.boolean = value
    return value_proto
end

function long_attribute_value(value::Int)
    value_proto = grakn.protocol.Attribute_Value()
    value_proto.long = value
    return value_proto
end

function double_attribute_value(value::T) where {T<:AbstractFloat}
    value_proto = grakn.protocol.Attribute_Value()
    value_proto.double = value
    return value_proto
end

function string_attribute_value(value::String)
    value_proto = grakn.protocol.Attribute_Value()
    value_proto.string = value
    return value_proto
end

function datetime_attribute_value(value::DateTime)
    value_proto = grakn.protocol.Attribute_Value()
    value_proto.date_time = Second(value - DateTime(1970, 1, 1))
    return value_proto


function value_type(value_type_::ValueType)
    if findfirst(x-> x == value_type_, instances(ValueType)) === nothing
         throw(GraknClientException("Unrecognised value type: " + string(value_type_)))
    else    
        findfirst(x-> x == value_type_, instances(ValueType))
    end
end

function encoding(_type)
    if is_entity_type(_type)
        return Int("ENTITY_TYPE")
    elseif is_relation_type(_type)
        return Int("RELATION_TYPE")
    elseif is_attribute_type(_type)
        return Int("ATTRIBUTE_TYPE")
    elseif is_role_type(_type)
        return Int("ROLE_TYPE")
    elseif is_thing_type(_type)
        return Int("THING_TYPE")
    elseif true
        raise GraknClientException("Unrecognised type encoding: " + str(_type))
    end
end


# def iid(iid_: str): erl.
#     return bytes.fromhex(iid_.lstrip("0x"))


# def thing(thing_): erl.
#     proto_thing = concept_proto.Thing()
#     proto_thing.iid = iid(thing_.get_iid())
#     return proto_thing


# def type_(_type):   erl.
#     proto_type = concept_proto.Type()
#     proto_type.label = _type.get_label()
#     proto_type.encoding = encoding(_type)

#     if _type.is_role_type():
#         proto_type.scope = _type.get_scope()

#     return proto_type


# def types(types_: List): erl.
#     return map(lambda _type: type_(_type), types_)


# def boolean_attribute_value(value: bool): erl.
#     value_proto = concept_proto.Attribute.Value()
#     value_proto.boolean = value
#     return value_proto


# def long_attribute_value(value: int): erl.
#     value_proto = concept_proto.Attribute.Value()
#     value_proto.long = value
#     return value_proto


# def double_attribute_value(value: float): erl.
#     value_proto = concept_proto.Attribute.Value()
#     value_proto.double = value
#     return value_proto


# def string_attribute_value(value: str): erl.
#     value_proto = concept_proto.Attribute.Value()
#     value_proto.string = value
#     return value_proto


# def datetime_attribute_value(value: datetime):  erl.
#     value_proto = concept_proto.Attribute.Value()
#     value_proto.date_time = int((value - datetime(1970, 1, 1)).total_seconds() * 1000)
#     return value_proto


# def value_type(value_type_: ValueType):  erl.
#     if value_type_ == ValueType.BOOLEAN:
#         return concept_proto.AttributeType.ValueType.Value("BOOLEAN")
#     elif value_type_ == ValueType.LONG:
#         return concept_proto.AttributeType.ValueType.Value("LONG")
#     elif value_type_ == ValueType.DOUBLE:
#         return concept_proto.AttributeType.ValueType.Value("DOUBLE")
#     elif value_type_ == ValueType.STRING:
#         return concept_proto.AttributeType.ValueType.Value("STRING")
#     elif value_type_ == ValueType.DATETIME:
#         return concept_proto.AttributeType.ValueType.Value("DATETIME")
#     elif value_type_ == ValueType.OBJECT:
#         return concept_proto.AttributeType.ValueType.Value("OBJECT")
#     else:
#         raise GraknClientException("Unrecognised value type: " + str(value_type_))


# def encoding(_type):
#     if _type.is_entity_type():
#         return concept_proto.Type.Encoding.Value("ENTITY_TYPE")
#     elif _type.is_relation_type():
#         return concept_proto.Type.Encoding.Value("RELATION_TYPE")
#     elif _type.is_attribute_type():
#         return concept_proto.Type.Encoding.Value("ATTRIBUTE_TYPE")
#     elif _type.is_role_type():
#         return concept_proto.Type.Encoding.Value("ROLE_TYPE")
#     elif _type.is_thing_type():
#         return concept_proto.Type.Encoding.Value("THING_TYPE")
#     else:
#         raise GraknClientException("Unrecognised type encoding: " + str(_type))
