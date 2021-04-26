# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

function instantiate(t::Proto.Thing)
    if t._type.encoding == Proto.Type_Encoding.ENTITY_TYPE
        return Entity(t)
    elseif t._type.encoding == Proto.Type_Encoding.RELATION_TYPE
        return Relation(t)
    elseif t._type.encoding == Proto.Type_Encoding.ATTRIBUTE_TYPE
        return Attribute(t)
    else
        throw(TypeDBClientException(CONCEPT_BAD_ENCODING))
    end
end
