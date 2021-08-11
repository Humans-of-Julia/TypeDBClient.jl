# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE


@given("put attribute type: license, with value type: string") do context
    _put_attribute_to_db(context, "license", VALUE_TYPE.STRING)
end

@given("put attribute type: date, with value type: datetime") do context
    _put_attribute_to_db(context, "date", VALUE_TYPE.DATETIME)
end

@given("put relation type: marriage") do context
    res = g.put(ConceptManager(context[:transaction]), RelationType, "marriage")
end

@given("relation(marriage) set relates role: wife") do context
    res = g.set_relates(context[:transaction],
                    g.Label("","marriage"),
                    "wife")
end

@given("relation(marriage) set relates role: husband") do context
    g.set_relates(context[:transaction],
                    g.Label("","marriage"),
                    "husband")
end

@given("relation(marriage) set owns key type: license") do context
    rel_type = g.get(ConceptManager(context[:transaction]), RelationType, "marriage")
    lic_typ = g.get(ConceptManager(context[:transaction]), AttributeType, "license")
    set_owns(g.as_remote(rel_type, context[:transaction]),
                        lic_typ,
                        true)
end

@given("relation(marriage) set owns attribute type: date") do context
    rel_type = g.get(ConceptManager(context[:transaction]), RelationType, "marriage")
    lic_typ = g.get(ConceptManager(context[:transaction]), AttributeType, "date")
    set_owns(g.as_remote(rel_type, context[:transaction]),
                        lic_typ,
                        false)
end

@given("entity(person) set plays role: marriage:wife") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]), g.RoleType(g.Label("marriage", "wife"),false))
end

@given("entity(person) set plays role: marriage:husband") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]), g.RoleType(g.Label("marriage", "husband"),false))
end

@when("\$m = relation(marriage) create new instance with key(license): m") do context
    ins_string = raw"""insert $x isa license; $x "m";"""
    res_raw_license = g.insert(context[:transaction], ins_string)
    res_license = res_raw_license[1].data["x"]

    mar_type = g.get(ConceptManager(context[:transaction]), RelationType, "marriage")
    context[:m] = g.create(g.as_remote(mar_type, context[:transaction]))
    g.set_has(context[:transaction], context[:m], res_license)
end

@then("relation \$m is null: false") do context
    @expect context[:m] !== nothing
end

@then("relation \$m has type: marriage") do context
    @expect context[:m].type.label.name == "marriage"
end

@then("relation(marriage) get instances contain: \$m") do context
    rel_type = g.get(ConceptManager(context[:transaction]), RelationType, "marriage")
    res_inst = g.get_instances(g.as_remote(rel_type, context[:transaction]))

    @expect in(context[:m], res_inst)
end

@when("\$b = entity(person) create new instance with key(username): bob") do context
    ins_string = raw"""insert $x isa person, has username = "bob";"""
    res = g.insert(context[:transaction], ins_string)
    context[:b] = res[1].data["x"]
end

@when("relation \$m add player for role(wife): \$a") do context
    g.add_player(context[:transaction],
                context[:m],
                g.RoleType(g.Label("marriage","wife"),false),
                context[:a])
end

@when("relation \$m add player for role(husband): \$b") do context
    g.add_player(context[:transaction],
                context[:m],
                g.RoleType(g.Label(context[:m].type.label.name,"husband"),false),
                context[:b])
end

@then("relation \$m get players for role(wife) contain: \$a") do context
    roles = [g.RoleType(g.Label(context[:m].type.label.name, "wife"),false)]
    res = g.get_players(context[:transaction],
                context[:m],
                roles)
    @expect in(context[:a], res)
end

@then("relation \$m get players for role(husband) contain: \$b") do context
    roles = [g.RoleType(g.Label("marriage","husband"),false)]
    res = g.get_players(context[:transaction],
                context[:m],
                roles)
    @expect in(context[:b], res)
end

@then("relation \$m get players contain: \$a") do context
    res = g.get_players(context[:transaction], context[:m])
    @expect in(context[:a], res)
end

@then("relation \$m get players contain: \$b") do context
    res = g.get_players(context[:transaction], context[:m])
    @expect in(context[:b], res)
end

@then("relation \$m get players contain:") do context
    roles_inp = [db[1] for db in context.datatable]
    entities = [db[2] for db in context.datatable]

    context[Symbol("a")] = context[:a]

    for i in 1:length(roles_inp)
        roles = [g.RoleType(g.Label("marriage", roles_inp[i]),false)]
        res = g.get_players(context[:transaction],
                    context[:m],
                    roles)
        @expect in(context[Symbol(string(SubString(entities[i],2,2)))], res)
    end
end

@when("\$m = relation(marriage) get instance with key(license): m") do context
    match_string = raw"""match $x isa marriage, has license="m";"""
    res_match = g.match(context[:transaction], match_string)
    context[:m] = !isempty(res_match) ? res_match[1].data["x"] : nothing
end

@when("\$b = entity(person) get instance with key(username): bob") do context
    match_string = raw"""match $x isa person, has username="bob";"""
    context[:b] = g.match(context[:transaction], match_string)[1].data["x"]
end

# Scenario: Role players can get relations
@then("entity \$a get relations(marriage:wife) do not contain: \$m") do context
    rel_alice = g.get_relations(context[:transaction], context[:a])
    @expect !in(context[:m], rel_alice)
end

@then("entity \$b get relations(marriage:husband) do not contain: \$m") do context
    rel_bob= g.get_relations(context[:transaction], context[:b])
    @expect !in(context[:m], rel_bob)
end

@then("entity \$a get relations(marriage:wife) contain: \$m") do context
    rel_alice = g.get_relations(context[:transaction],
                                context[:a],
                                [g.RoleType(g.Label("marriage","wife"),false)])
    @expect in(context[:m], rel_alice)
end

@then("entity \$b get relations(marriage:husband) contain: \$m") do context
    rel_bob = g.get_relations(context[:transaction],
                                context[:b],
                                [g.RoleType(g.Label("marriage","husband"),false)])
    @expect in(context[:m], rel_bob)
end

# Scenario: Role player can be unassigned from relation
@when("relation \$m remove player for role(wife): \$a") do context
    rem_req = g.remove_player(context[:transaction],
                        context[:m],
                        RoleType(g.Label("marriage","wife"),false),
                        context[:a])
end


@then("relation \$m get players for role(wife) do not contain: \$a") do context
    res = g.get_players(context[:transaction], context[:m])
    @expect !in(context[:a], res)
end

@then("relation \$m get players do not contain:") do context
    roles_inp = [db[1] for db in context.datatable]
    entities = [db[2] for db in context.datatable]

    context[Symbol("a")] = context[:a]

    for i in 1:length(roles_inp)
        roles = [g.RoleType(g.Label("marriage", roles_inp[i]),false)]
        res = g.get_players(context[:transaction],
                    context[:m],
                    roles)
        @expect !in(context[Symbol(string(SubString(entities[i],2,2)))], res)
    end
end

# Scenario: Relation without role players get deleted
@then("relation \$m is deleted: true") do context
    res = g.is_deleted(g.as_remote(context[:m], context[:transaction]))
    @expect res === true
end

@then("entity \$a get relations do not contain: \$m") do  context
    rel_alice = g.get_relations(context[:transaction],
                                context[:a])
    @expect !in(context[:m], rel_alice)
end

@then("relation(marriage) get instances do not contain: \$m") do context
    type_marriage = g.get(g.ConceptManager(context[:transaction]),
                            g.RelationType,
                            "marriage")

    res_marriage = g.get_instances(g.as_remote(type_marriage, context[:transaction]))
    @expect !in(context[:m], res_marriage)
end

@then("relation \$m is null: true") do context
    @expect context[:m] === nothing
end

@then("relation(marriage) get instances is empty") do context
    type_marriage = g.get(g.ConceptManager(context[:transaction]),
    g.RelationType,
    "marriage")
    res_marriage = g.get_instances(g.as_remote(type_marriage, context[:transaction]))

    @expect isempty(res_marriage) === true
end

# Scenario: Relation with role players can be deleted
@when("delete relation: \$m") do context
    g.delete(g.as_remote(context[:m], context[:transaction]))
end

@then("entity \$b get relations do not contain: \$m") do context
   relations = g.get_relations(context[:transaction], context[:b])
   @expect !in(context[:m], relations)
end

# Scenario: Relation cannot have roleplayers inserted after deletion
@then("relation \$m add player for role(wife): \$a; throws exception") do context
    try
        g.add_player(context[:transaction],
                context[:m],
                g.RoleType(g.Label("marriage","wife"),false),
                context[:res_entity][1].data["x"])
    catch ex
        @expect ex !== nothing
    end
end
