# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

Optional{T} = Union{Nothing,T}

function _set_supertype_for_type(context, abstract_type::Type{<:g.AbstractThingType}, norm_type::String, super_type::String)
    attr = g.get(ConceptManager(context[:transaction]), abstract_type, norm_type)
    super_type = g.get(ConceptManager(context[:transaction]), abstract_type, super_type)
    g.set_supertype(g.as_remote(attr, context[:transaction]),
                    super_type)
end

function _is_supertype_for_type(context, abstract_type::Type{<:g.AbstractThingType}, attr_name::String, super_type_name::String)
    attr = g.get(ConceptManager(context[:transaction]), abstract_type, attr_name)
    super_type = g.get_supertype(g.as_remote(attr, context[:transaction]))

    return super_type.label.name == super_type_name
end

function _supertypes_contain(context, abstract_type::Type{<:g.AbstractThingType}, attr_name::String)
    super_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), abstract_type, attr_name)
    res_types = g.get_supertypes(g.as_remote(attr, context[:transaction]))
    res_array = Bool[]
    for attr in res_types
        push!(res_array, in(attr.label.name, super_types))
    end
    return res_array
end

function _subtypes_contain(context, abstract_type::Type{<:g.AbstractThingType}, attr_name::String)
    super_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), abstract_type, attr_name)
    res_types = g.get_subtypes(g.as_remote(attr, context[:transaction]))
    res_array = Bool[]
    for attr in res_types
        push!(res_array, in(attr.label.name, super_types))
    end

    return res_array
end

function _get_owns_contain(context, abstract_type::Type{<:g.AbstractThingType}, owner::String, is_key::Bool=false)
    key_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), abstract_type, owner)
    types_owns = g.get_owns(g.as_remote(attr, context[:transaction]),
                                nothing,
                                is_key)
    res_array = Bool[]
    for i in 1:length(key_types)
        key_type = g.get(ConceptManager(context[:transaction]),
                            ThingType,
                            key_types[i])
        push!(res_array, in(key_type, types_owns))
    end

    return res_array
end

function _entity_set_owns(entity::String, attribute_type::String, context, is_key = false, overriden::Optional{String} = nothing)
    cm = ConceptManager(context[:transaction])

    loc_entity = get(cm, g.EntityType, entity)
    rem_entitiy = g.as_remote(loc_entity, context[:transaction])
    loc_attribute = get(cm, g.AttributeType, attribute_type)

    if overriden !== nothing
        overriden_attr = get(cm, g.AttributeType, overriden)
    else
        overriden_attr = overriden
    end

    @assert rem_entitiy !== nothing && loc_attribute !== nothing "$entity or $attribute_type wasn't there"
    g.set_owns(rem_entitiy, loc_attribute, is_key, overriden_attr)
    return nothing
end

function _get_players_contain(relation_name::String, role_name::String, context)
    db = [db[1] for db in context.datatable]
    res = g.get_players(context[:transaction], g.Label(relation_name,role_name))
    res_array = Bool[]
    for i in 1:length(db)
        entity = g.get(ConceptManager(context[:transaction]),
                        ThingType,
                        db[i])
        push!(res_array, in(entity, res))
    end
    return res_array
end

function _get_playing_roles_contain(player::String, player_type::Type{<:g.AbstractThingType}, context)
    db = [string(split(x[1],':')[1])=>string(split(x[1],':')[2]) for x in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]),
                    player_type,
                    player)
    res_array = Bool[]
    play_roles = g.get_plays(g.as_remote(attr, context[:transaction]))
    for i in 1:length(db)
        role = RoleType(g.Label(db[i].first, db[i].second), false)
        push!(res_array, in(role, play_roles))
    end
    return res_array
end
