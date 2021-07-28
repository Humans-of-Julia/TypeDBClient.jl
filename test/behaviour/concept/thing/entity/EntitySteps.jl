using Base: concatenate_setindex!

function _entity_instances(transaction)
    res = g.match(transaction, "match \$x isa entity;")
    erg = isempty(res) ? [] : collect(Iterators.flatten([values(rm.data) for rm in res]))
    return erg
end

@given("put attribute type: username, with value type: string") do context
    _put_attribute_to_db(context, "username", g.Proto.AttributeType_ValueType.STRING)
end

@given("entity(person) set owns key type: username") do context
    _entity_set_owns("person", "username", context, true)
end

# Scenario: Entity can be created
@when("\$a = entity(person) create new instance with key(username): alice") do context
    ins_string = raw"""insert $a isa person, has username "alice";"""
    g.insert(context[:transaction], ins_string)
    context[:entity_res] = g.match(context[:transaction],raw"""match $x isa person, has username $y;""")
end

@then("entity \$a is null: false") do context
    erg = context[:entity_res]
    @expect erg[1] !== nothing
end

@then("entity \$a has type: person") do context
    erg = context[:entity_res]
    @expect erg[1]["x"].type == g.EntityType(g.Label("","person"), false)
end

@then("entity(person) get instances contain: \$a") do context
    erg = g.match(context[:transaction],raw"""match $x isa person;""")
    @expect erg[1]["x"].type == context[:entity_res][1]["x"].type
end

@when("\$a = entity(person) get instance with key(username): alice") do context
    context[:entity_res] = g.match(context[:transaction],raw"""match $x isa person, has username $y; $y="alice";""")
end

# Scenario: Entity cannot be created when it misses a key
@when("\$a = entity(person) create new instance") do context
    res = g.insert(context[:transaction], raw"""insert $x isa person;""")
    context[:entity_res] = g.match(context[:transaction], raw"""match $x isa person;""")
end

# Scenario: Entity can be deleted
@when("delete entity: \$a") do context
    del_string = raw"""match $x isa person, has username "alice"; delete $x isa person;"""
    g.delete(context[:transaction], del_string)
end

@then("entity \$a is deleted: true") do context
    match_string = raw"""match $x isa person, has username "alice";"""
    res = g.match(context[:transaction], match_string)
    @expect length(res) == 0
end

@then("entity(person) get instances is empty") do context
    match_string = raw"""match $x isa person;"""
    res = g.match(context[:transaction], match_string)
    @expect length(res) == 0
end

# Scenario: Entity can have keys
@when("\$alice = attribute(username) as(string) put: alice") do context
    ins_string = raw"""insert $x isa username; $x "alice";"""
    res = g.insert(context[:transaction], ins_string)
    context[:alice] = res[1].data["x"]
end

@when("entity \$a set has: \$alice") do context
    set_has(context[:transaction], context[:entity_res][1].data["x"], context[:alice])
end

@then("entity \$a get attributes(username) as(string) contain: \$alice") do context

end
