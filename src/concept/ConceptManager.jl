# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

struct ConceptManager{T <: AbstractCoreTransaction} <: AbstractConceptManager
    transaction::T
end

struct Root
end

# Get root something type. The hard coded strings came from GraqlToken
Base.get(cm::ConceptManager, ::Type{EntityType}, ::Root) = get(cm, ThingType, "entity")
Base.get(cm::ConceptManager, ::Type{RelationType}, ::Root) = get(cm, ThingType, "relation")
Base.get(cm::ConceptManager, ::Type{AttributeType}, ::Root) = get(cm, ThingType, "attribute")
Base.get(cm::ConceptManager, ::Type{ThingType}, ::Root) = get(cm, ThingType, "thing")

function Base.get(cm::ConceptManager, ::Type{EntityType}, label::String)
    t = get(cm, ThingType, label)
    t !== nothing && t isa EntityType && return t
    return nothing
end

function put(cm::ConceptManager, ::Type{EntityType}, label::Optional{String})
    res = execute(cm, ConceptManagerRequestBuilder.put_entity_type_req(label))
    if which_oneof(res, :res) == :put_entity_type_res
        return instantiate(res.put_entity_type_res.entity_type)
    end
    return nothing
end

function Base.get(cm::ConceptManager, ::Type{RelationType}, label::String)
    t = get(cm, ThingType, label)
    t !== nothing && t isa RelationType && return t
    return nothing
end

function put(cm::ConceptManager, ::Type{RelationType}, label::String)
    res = execute(cm, ConceptManagerRequestBuilder.put_relation_type_req(label))
    if which_oneof(res, :res) == :put_relation_type_res
        return instantiate(res.put_relation_type_res.relation_type)
    end
    return nothing
end

function Base.get(cm::ConceptManager, ::Type{AttributeType}, label::String)
    t = get(cm, ThingType, label)
    t !== nothing && t isa AttributeType && return t
    return nothing
end

function put(cm::ConceptManager, ::Type{AttributeType}, label::String, value_type::EnumType)
    res = execute(cm, ConceptManagerRequestBuilder.put_attribute_type_req(label, value_type))
    if which_oneof(res, :res) == :put_attribute_type_res
        return instantiate(res.put_attribute_type_res.attribute_type)
    end
    return nothing
end

function Base.get(cm::ConceptManager, ::Type{ThingType}, label::String)
    req = ConceptManagerRequestBuilder.get_thing_type_req(label)
    res = execute(cm, req)
    if which_oneof(res, :res) == :get_thing_type_res
        if hasproperty(res.get_thing_type_res, :thing_type)
            return instantiate(res.get_thing_type_res.thing_type)
        else
            return nothing
        end
    end
    return nothing
end

function Base.get(cm::ConceptManager, iid::String)
    res = get_proto_thing(cm, iid)
    res !== nothing && return instantiate(res)
    return nothing
end



function execute(cm::ConceptManager, req::Proto.Transaction_Req)
    result = execute(cm.transaction, req, false)
    return result.concept_manager_res
end

# get_proto_thing is supposed to be a vehicle to get things in its proto form to get
# a result for setting up set_has etc.
function get_proto_thing(cm::ConceptManager, iid::String)
    req = ConceptManagerRequestBuilder.get_thing_req(iid)
    res = execute(cm, req)
    if which_oneof(res, :res) == :get_thing_res
        if hasproperty(res.get_thing_res, :thing)
            return res.get_thing_res.thing
        else
            return nothing
        end
    end
    return nothing
end
