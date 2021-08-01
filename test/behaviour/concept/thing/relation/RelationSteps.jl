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
    g.set_relates(context[:transaction],
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
    context[:marriage] = g.create(g.as_remote(mar_type, context[:transaction]))
    g.set_has(context[:transaction], context[:marriage], res_license)
end

@then("relation \$m is null: false") do context
    @expect context[:marriage] !== nothing
end

@then("relation \$m has type: marriage") do context
    @expect context[:marriage].type.label.name == "marriage"
end

@then("relation(marriage) get instances contain: \$m") do context
    rel_type = g.get(ConceptManager(context[:transaction]), RelationType, "marriage")
    res_inst = g.get_instances(g.as_remote(rel_type, context[:transaction]))

    @expect in(context[:marriage], res_inst)
end

@when("\$b = entity(person) create new instance with key(username): bob") do context
    ins_string = raw"""insert $x isa person, has username = "bob";"""
    res = g.insert(context[:transaction], ins_string)
    context[:bob] = res[1].data["x"]
end

@when("relation \$m add player for role(wife): \$a") do context
    g.add_player(context[:transaction],
                context[:marriage],
                g.RoleType(g.Label("marriage","wife"),false),
                context[:entity_res][1].data["x"])
end

@when("relation \$m add player for role(husband): \$b") do context
    g.add_player(context[:transaction],
                context[:marriage],
                g.RoleType(g.Label("marriage","husband"),false),
                context[:bob])
end

@then("relation \$m get players for role(wife) contain: \$a") do context
    roles = [g.RoleType(g.Label("marriage","wife"),false)]
    res = g.get_players(context[:transaction],
                context[:marriage],
                roles)
    @expect in(context[:entity_res][1].data["x"], res)
end

@then("relation \$m get players for role(husband) contain: \$b") do context
    roles = [g.RoleType(g.Label("marriage","husband"),false)]
    res = g.get_players(context[:transaction],
                context[:marriage],
                roles)
    @expect in(context[:bob], res)
end

@then("relation \$m get players contain: \$a") do context
    res = g.get_players(context[:transaction], context[:marriage])
    @expect in(context[:entity_res][1].data["x"], res)
end

@then("relation \$m get players contain: \$b") do context
    res = g.get_players(context[:transaction], context[:marriage])
    @expect in(context[:bob], res)
end

@then("relation \$m get players contain:") do context
    roles_inp = [db[1] for db in context.datatable]
    entities = [db[2] for db in context.datatable]

    context[Symbol("a")] = context[:entity_res][1].data["x"]
    context[Symbol("b")] = context[:bob]

    for i in 1:length(roles_inp)
        roles = [g.RoleType(g.Label("marriage", roles_inp[i]),false)]
        res = g.get_players(context[:transaction],
                    context[:marriage],
                    roles)
        @expect in(context[Symbol(string(SubString(entities[i],2,2)))], res)
    end
end

@when("\$m = relation(marriage) get instance with key(license): m") do context
    match_string = raw"""match $x isa marriage, has license="m";"""
    context[:marriage] = g.match(context[:transaction], match_string)[1].data["x"]
end

@when("\$b = entity(person) get instance with key(username): bob") do context
    match_string = raw"""match $x isa person, has username="bob";"""
    context[:bob] = g.match(context[:transaction], match_string)[1].data["x"]
end

# Scenario: Role players can get relations
@then("entity \$a get relations(marriage:wife) do not contain: \$m") do context
    rel_alice = g.get_relations(context[:transaction], context[:entity_res][1].data["x"])
    @expect !in(context[:marriage], rel_alice)
end

@then("entity \$b get relations(marriage:husband) do not contain: \$m") do context
    rel_bob= g.get_relations(context[:transaction], context[:bob])
    @expect !in(context[:marriage], rel_bob)
end

@then("entity \$a get relations(marriage:wife) contain: \$m") do context
    rel_alice = g.get_relations(context[:transaction],
                                context[:entity_res][1].data["x"],
                                [g.RoleType(g.Label("marriage","wife"),false)])
    @expect in(context[:marriage], rel_alice)
end

@then("entity \$b get relations(marriage:husband) contain: \$m") do context
    rel_bob = g.get_relations(context[:transaction],
                                context[:bob],
                                [g.RoleType(g.Label("marriage","husband"),false)])
    @expect in(context[:marriage], rel_bob)
end

# Scenario: Role player can be unassigned from relation
@when("relation \$m remove player for role(wife): \$a") do context
    g.remove_player_req(context[:transaction],
                        context[:marriage],
                        RoleType(g.Label("marriage","wife"),false),
                        context[:entity_res][1].data["x"])
end


@then("relation \$m get players for role(wife) do not contain: \$a") do context
    res = g.get_players(context[:transaction], context[:marriage])
    @expect !in(context[:entity_res][1].data["x"], res)
end

@then("relation \$m get players do not contain:") do context
    roles_inp = [db[1] for db in context.datatable]
    entities = [db[2] for db in context.datatable]

    context[Symbol("a")] = context[:entity_res][1].data["x"]
    context[Symbol("b")] = context[:bob]

    for i in 1:length(roles_inp)
        roles = [g.RoleType(g.Label("marriage", roles_inp[i]),false)]
        res = g.get_players(context[:transaction],
                    context[:marriage],
                    roles)
        @expect !in(context[Symbol(string(SubString(entities[i],2,2)))], res)
    end
end

# Scenario: Relation without role players get deleted
@then("relation \$m is deleted: true") do context

end
