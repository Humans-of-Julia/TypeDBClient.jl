# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

struct EntityType <: AbstractEntityType
    label::Label
    is_root::Bool
end

function create(x::RemoteConcept{EntityType})
    result = execute(x.transaction, EntityTypeRequestBuilder.create_req(x.concept.label))
    return Entity(result.type_res.entity_type_create_res.entity)
end
