using Base: concatenate_setindex!, @nexprs

function _entity_instances(transaction)
    res = g.match(transaction, "match \$x isa entity;")
    erg = isempty(res) ? [] : collect(Iterators.flatten([values(rm.data) for rm in res]))
    return erg
end

@given("put attribute type: username, with value type: string") do context
    _put_attribute_to_db(context, "username", g.Proto.AttributeType_ValueType.STRING)
end

@given("entity(person) set owns key type: username") do context
    g.con.entity_set_owns("person", "username", context[:transaction], true)
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
    attr = get(ConceptManager(context[:transaction]), AttributeType, "username")
    inst_usernames = get_has(context[:transaction], context[:entity_res][1].data["x"], attr)
    @expect in(context[:alice], inst_usernames)
end

@then("entity \$a get keys contain: \$alice") do context
    inst_keys = get_has(context[:transaction], context[:entity_res][1].data["x"] , nothing, nothing, true)
    @expect in(context[:alice], inst_keys)
end

@then("attribute \$alice get owners contain: \$a") do context
    owners = get_owners(context[:transaction], context[:alice])
    @expect in(context[:entity_res][1].data["x"], owners)
end

@when("\$alice = attribute(username) as(string) get: alice") do context
    attr = get(ConceptManager(context[:transaction]), AttributeType, "username")
    res = g.get_instances(g.as_remote(attr, context[:transaction]))
    context[:alice] = res[1]
end

# Scenario: Entity can unset keys
@when("entity \$a unset has: \$alice") do context
    g.unset_has(context[:transaction], context[:entity_res][1].data["x"], context[:alice])
end

@then("entity \$a get attributes(username) as(string) do not contain: \$alice") do context
    attr = get(ConceptManager(context[:transaction]), AttributeType, "username")
    inst_usernames = get_has(context[:transaction], context[:entity_res][1].data["x"], attr)
    @expect !in(context[:alice], inst_usernames)
end

@then("entity \$a get keys do not contain: \$alice") do context
    inst_keys = get_has(context[:transaction], context[:entity_res][1].data["x"] , nothing, nothing, true)
    @expect !in(context[:alice], inst_keys)
end

@then("attribute \$alice get owners do not contain: \$a") do context
    owners = get_owners(context[:transaction], context[:alice])
    @expect !in(context[:entity_res][1].data["x"], owners)
end

# Scenario: Entity cannot have more than one key for a given key type
@when("\$bob = attribute(username) as(string) put: bob") do context
    ins_string = raw"""insert $x isa username; $x "bob";"""
    res = g.insert(context[:transaction], ins_string)
    context[:bob] = res[1].data["x"]
end

@then("entity \$a set has: \$bob; throws exception") do context
    try
        set_has(context[:transaction], context[:entity_res][1].data["x"], context[:bob])
    catch ex
        @expect ex !== nothing
    end
end

@when("\$bob = attribute(username) as(string) get: bob") do context
    attr = get(ConceptManager(context[:transaction]), AttributeType, "username")
    inst_usernames = get_has(context[:transaction], context[:entity_res][1].data["x"], attr)
    @expect !in(context[:bob], inst_usernames)
end

# Scenario: Entity cannot have a key that has been taken
@when("\$b = entity(person) create new instance") do context
    ins_string = raw"""insert $x isa person;"""
    res_ins = g.insert(context[:transaction], ins_string)
    context[:b] = res_ins[1].data["x"]
end

@then("entity \$b set has: \$alice; throws exception") do context
    try
        g.set_has(context[:transaction], context[:b], context[:alice])
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity can have attribute
@when("\$email = attribute(email) as(string) put: alice@email.com") do context
    ins_string = raw"""insert $x isa email; $x "alice@email.com";"""
    res_ins = g.insert(context[:transaction], ins_string)
    context[:email] = res_ins[1].data["x"]
end

@when("entity \$a set has: \$email") do context
    set_has(context[:transaction], context[:entity_res][1].data["x"], context[:email])
end

@then("entity \$a get attributes(email) as(string) contain: \$email") do context
    email_type = g.get(g.ConceptManager(context[:transaction]), AttributeType, "email")
    res_email = get_has(context[:transaction], context[:entity_res][1].data["x"], email_type)
    @expect in(context[:email], res_email) === true
end

@then("entity \$a get attributes contain: \$email") do context
    res_email = get_has(context[:transaction], context[:entity_res][1].data["x"])
    @expect in(context[:email], res_email) === true
end

@then("attribute \$email get owners contain: \$a") do context
    res_owns = get_owners(context[:transaction], context[:email])
    @expect in(context[:entity_res][1].data["x"], res_owns) === true
end

@when("\$email = attribute(email) as(string) get: alice@email.com") do context
    @expect context[:email].value == "alice@email.com"
end

# Scenario: Entity can unset attribute
@when("entity \$a unset has: \$email") do context
    g.unset_has(context[:transaction], context[:entity_res][1].data["x"], context[:email])
end

@then("entity \$a get attributes(email) as(string) do not contain: \$email") do context
    res_email = get_has(context[:transaction], context[:entity_res][1].data["x"])
    @expect in(context[:email], res_email) === false
end

@then("entity \$a get attributes do not contain: \$email") do context
    res_email = get_has(context[:transaction], context[:entity_res][1].data["x"])
    @expect in(context[:email], res_email) === false
end

@then("attribute \$email get owners do not contain: \$a") do context
    res_owns = get_owners(context[:transaction], context[:email])
    @expect in(context[:entity_res][1].data["x"], res_owns) === false
end

# Scenario: Entity cannot be given an attribute after deletion
@when("entity \$a set has: \$email; throws exception") do context
    try
        set_has(context[:transaction], context[:entity_res][1].data["x"], context[:email])
    catch ex
        @expect ex !== nothing
    end
end
