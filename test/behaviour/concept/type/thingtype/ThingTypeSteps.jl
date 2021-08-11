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

function _supertypes_contain(context, ::Type{g.RoleType}, relation_name::String, role_name::String)
    db_roles = [_split_role(db[1])[1]=>_split_role(db[1])[2] for db in context.datatable]
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                relation_name)
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), role_name)
    res_supertypes = g.get_supertypes(g.as_remote(role_play, context[:transaction]))
    res_array = Bool[]
    for i in 1:length(db_roles)
        super_role = RoleType(g.Label(db_roles[i].first, db_roles[i].second), false)
        push!(res_array, in(super_role, res_supertypes))
    end
    return res_array
end

function _subtypes_contain(context, abstract_type::Type{<:g.AbstractThingType}, attr_name::String)
    sub_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), abstract_type, attr_name)
    res_types = g.get_subtypes(g.as_remote(attr, context[:transaction]))
    res_array = Bool[]
    for i in 1:length(sub_types)
        sub_type = g.get(context[:cm], abstract_type, sub_types[i])
        push!(res_array, in(sub_type, res_types))
    end
    return res_array
end

function _subtypes_contain(context, ::Type{g.RoleType}, relation_name::String, role_name::String)
    db_roles = [_split_role(db[1])[1]=>_split_role(db[1])[2] for db in context.datatable]
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                relation_name)
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), role_name)
    res_subtypes = g.get_subtypes(g.as_remote(role_play, context[:transaction]))
    res_array = Bool[]
    for i in 1:length(db_roles)
        sub_role = RoleType(g.Label(db_roles[i].first, db_roles[i].second), false)
        push!(res_array, in(sub_role, res_subtypes))
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

function _get_related_roles_contain(context, relation_name::String)
    inp_roles = filter(x->x !== nothing,[_split_role(db[1]) for db in context.datatable])

    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                relation_name)

    relates = g.get_relates(g.as_remote(res, context[:transaction]))
    res_array = Bool[]
    for i in 1:length(inp_roles)
        inp_role = RoleType(g.Label(inp_roles[i].first, inp_roles[i].second),false)
        push!(res_array, in(inp_role, relates))
    end
    return res_array
end

function _thing_type_unset_type(context,
            type::Type{<:g.AbstractThingType},
            thing_name::String,
            unset_type::Type{<:g.AbstractType},
            unset_name::String)
    thing_type = g.get(context[:cm], type, thing_name)
    type_to_unset = g.get(context[:cm], unset_type, unset_name)
    g.unset_owns(g.as_remote(thing_type, context[:transaction]), type_to_unset)
end

function _split_role(role::String)
    res = split(role,":")
    return (string(res[1])=>string(res[2]))
end


# Scenario: Root thing type can retrieve all types
@then("thing type root get supertypes contain:") do context
    super_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), ThingType, "thing")
    res_types = g.get_supertypes(g.as_remote(attr, context[:transaction]))
    for attr in res_types
        @expect in(attr.label.name, super_types)
    end
end

@then("thing type root get supertypes do not contain:") do context
    super_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), ThingType, "thing")
    res_types = g.get_supertypes(g.as_remote(attr, context[:transaction]))
    for attr in res_types
        @expect !in(attr.label.name, super_types)
    end
end

@then("thing type root get subtypes contain:") do context
    res_contain = _subtypes_contain(context, ThingType, "thing")
    @expect all(res_contain) === true
end

@then("thing type root get subtypes do not contain:") do context
    res_contain = _subtypes_contain(context, ThingType, "thing")
    @expect all(res_contain) === false
end

# Scenario: Root thing type can retrieve all instances
@when("\$att1 = attribute(is-alive) as(boolean) put: true") do context
    attr = g.get(context[:cm], AttributeType, "is-alive")
    res = g.put(g.as_remote(attr, context[:transaction]), true)
    context[:att1] = res
end

@when("\$att2 = attribute(age) as(long) put: 21") do context
    attr = g.get(context[:cm], AttributeType, "age")
    res = g.put(g.as_remote(attr, context[:transaction]), 21)
    context[:att2] = res
end

@when("\$att3 = attribute(score) as(double) put: 123.456") do context
    attr = g.get(context[:cm], AttributeType, "score")
    res = g.put(g.as_remote(attr, context[:transaction]), 123.456)
    context[:att3] = res
end

@when("\$att4 = attribute(username) as(string) put: alice") do context
    attr = g.get(context[:cm], AttributeType, "username")
    res = g.put(g.as_remote(attr, context[:transaction]), "alice")
    context[:att4] = res
end

@when("\$att5 = attribute(license) as(string) put: abc") do context
    attr = g.get(context[:cm], AttributeType, "license")
    res = g.put(g.as_remote(attr, context[:transaction]), "abc")
    context[:att5] = res
end

@when("\$att6 = attribute(birth-date) as(datetime) put: 1990-01-01 11:22:33") do context
    attr = g.get(context[:cm], AttributeType, "birth-date")
    res = g.put(g.as_remote(attr, context[:transaction]), parse(DateTime, "1990-01-01T11:22:33"))
    context[:att6] = res
end

@when("\$ent1 = entity(person) create new instance with key(username): alice") do context
    ent_type = g.get(context[:cm], EntityType, "person")
    attr_type = g.get(context[:cm], AttributeType, "username")
    user_name = g.get(g.as_remote(attr_type, context[:transaction]), "alice")
    res = g.create(g.as_remote(ent_type, context[:transaction]))
    context[:ent1] = res
    set_has(context[:transaction], context[:ent1], user_name)
end

@when("\$rel1 = relation(marriage) create new instance with key(license): abc") do context
    ent_type = g.get(context[:cm], RelationType, "marriage")
    attr_type = g.get(context[:cm], AttributeType, "license")
    user_name = g.get(g.as_remote(attr_type, context[:transaction]), "abc")
    res = g.create(g.as_remote(ent_type, context[:transaction]))
    context[:rel1] = res
    set_has(context[:transaction], context[:rel1], user_name)
end

@then("root(thing) get instances count: 8") do context
    type = g.get(context[:cm], ThingType, "thing")
    res = g.get_instances(g.as_remote(type, context[:transaction]))
    @expect length(res) == 8
end

@then("root(thing) get instances contain: \$att1") do context
    type = g.get(context[:cm], ThingType, "thing")
    res = g.get_instances(g.as_remote(type, context[:transaction]))

    @expect in(context[:att1], res)
end

@then("root(thing) get instances contain: \$att2") do context
    type = g.get(context[:cm], ThingType, "thing")
    res = g.get_instances(g.as_remote(type, context[:transaction]))

    @expect in(context[:att2], res)
end

@then("root(thing) get instances contain: \$att3") do context
    type = g.get(context[:cm], ThingType, "thing")
    res = g.get_instances(g.as_remote(type, context[:transaction]))

    @expect in(context[:att3], res)
end

@then("root(thing) get instances contain: \$att4") do context
    type = g.get(context[:cm], ThingType, "thing")
    res = g.get_instances(g.as_remote(type, context[:transaction]))

    @expect in(context[:att4], res)
end

@then("root(thing) get instances contain: \$att5") do context
    type = g.get(context[:cm], ThingType, "thing")
    res = g.get_instances(g.as_remote(type, context[:transaction]))

    @expect in(context[:att5], res)
end

@then("root(thing) get instances contain: \$att6") do context
    type = g.get(context[:cm], ThingType, "thing")
    res = g.get_instances(g.as_remote(type, context[:transaction]))

    @expect in(context[:att6], res)
end

@then("root(thing) get instances contain: \$ent1") do context
    type = g.get(context[:cm], ThingType, "thing")
    res = g.get_instances(g.as_remote(type, context[:transaction]))

    @expect in(context[:ent1], res)
end

@then("root(thing) get instances contain: \$rel1") do context
    type = g.get(context[:cm], ThingType, "thing")
    res = g.get_instances(g.as_remote(type, context[:transaction]))

    @expect in(context[:rel1], res)
end
