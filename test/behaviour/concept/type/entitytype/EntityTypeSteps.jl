# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

#
# package typedb.client.test.behaviour.concept.type.entitytype;
#
# public class EntityTypeSteps {}

# Scenario: Entity types can be created
@then("entity(person) is null: false") do context
    attr_person = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    @expect attr_person !== nothing
end

@then("entity(person) get supertype: entity") do context
    attr_person = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    attr_super = g.get_supertype(g.as_remote(attr_person, context[:transaction]))
    @expect attr_super.label.name == "entity"
end

# Scenario: Entity types can be deleted
@then("entity(company) is null: false") do context
    attr_comp = g.get(ConceptManager(context[:transaction]), EntityType, "company")
    @expect attr_comp !== nothing
end

@when("delete entity type: company") do context
    attr_comp = g.get(ConceptManager(context[:transaction]), EntityType, "company")
    g.delete(g.as_remote(attr_comp, context[:transaction]))
end

@then("entity(company) is null: true") do context
    attr_comp = g.get(ConceptManager(context[:transaction]), EntityType, "company")
    @expect attr_comp === nothing
end

@then("entity(entity) get subtypes do not contain:") do context
    types_inp = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), EntityType, "entity")
    sub_types = g.get_subtypes(g.as_remote(attr, context[:transaction]))
    for i in 1:length(types_inp)
        inp_type = attr = g.get(ConceptManager(context[:transaction]), EntityType, types_inp[i])
        @expect !in(inp_type, sub_types)
    end
end

@when("delete entity type: person") do context
    attr = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    g.delete(g.as_remote(attr, context[:transaction]))
end

@then("entity(person) is null: true") do context
    attr = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    @expect attr === nothing
end

# Scenario: Entity types that have instances cannot be deleted
@when("\$x = entity(person) create new instance") do context
    res = g.insert(context[:transaction], raw"""insert $x isa person;""")
    context[:x] = g.match(context[:transaction], raw"""match $x isa person;""")[1].data["x"]
end

@then("delete entity type: person; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    try
        g.delete(g.as_remote(attr_comp, context[:transaction]))
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity types can change labels
@then("entity(person) get label: person") do context
    attr = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    @expect attr.label.name == "person"
end

@when("entity(person) set label: horse") do context
    attr = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    g.set_label(g.as_remote(attr, context[:transaction]), "horse")
end

@then("entity(horse) is null: false") do context
    attr = g.get(ConceptManager(context[:transaction]), EntityType, "horse")
    @expect attr !== nothing
end

@then("entity(horse) get label: horse") do context
    attr = g.get(ConceptManager(context[:transaction]), EntityType, "horse")
    @expect attr.label.name == "horse"
end

@when("entity(horse) set label: animal") do context
    attr = g.get(ConceptManager(context[:transaction]), EntityType, "horse")
    g.set_label(g.as_remote(attr, context[:transaction]), "animal")
end

@then("entity(horse) is null: true") do context
    attr = g.get(ConceptManager(context[:transaction]), EntityType, "horse")
    @expect attr === nothing
end

@then("entity(animal) is null: false") do context
    attr = g.get(ConceptManager(context[:transaction]), EntityType, "animal")
    @expect attr !== nothing
end

@then("entity(animal) get label: animal") do context
    attr = g.get(ConceptManager(context[:transaction]), EntityType, "animal")
    @expect attr.label.name == "animal"
end

# Scenario: Entity types can be set to abstract
@then("entity(person) is abstract: true") do context
    attr = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    res_abstract = g.is_abstract(g.as_remote(attr, context[:transaction]))
    @expect res_abstract === true
end

@then("entity(person) create new instance; throws exception") do context
    try
        res = g.insert(context[:transaction], raw"""insert $x isa person;""")
    catch ex
        @expect ex !== nothing
    end
end

@then("entity(company) is abstract: false") do context
    attr = g.get(ConceptManager(context[:transaction]), EntityType, "company")
    res_abstract = g.is_abstract(g.as_remote(attr, context[:transaction]))
    @expect res_abstract === false
end

@when("entity(company) set abstract: true") do context
    attr_name = g.get(ConceptManager(context[:transaction]), EntityType, "company")
    g.set_abstract(g.as_remote(attr_name, context[:transaction]))
end

@then("entity(company) is abstract: true") do context
    attr = g.get(ConceptManager(context[:transaction]), EntityType, "company")
    res_abstract = g.is_abstract(g.as_remote(attr, context[:transaction]))
    @expect res_abstract === true
end

@then("entity(company) create new instance; throws exception") do context
    try
        res = g.insert(context[:transaction], raw"""insert $x isa company;""")
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity types can be subtypes of other entity types
@when("put entity type: man") do context
    g.put(ConceptManager(context[:transaction]),
                            EntityType,
                            "man")
end

@when("put entity type: woman") do context
    g.put(ConceptManager(context[:transaction]),
                            EntityType,
                            "woman")
end

@when("put entity type: cat") do context
    g.put(ConceptManager(context[:transaction]),
                            EntityType,
                            "cat")
end

@when("put entity type: animal") do context
    g.put(ConceptManager(context[:transaction]),
                            EntityType,
                            "animal")
end

@when("entity(man) set supertype: person") do context
    _set_supertype_for_type(context, EntityType, "man", "person")
end

@when("entity(woman) set supertype: person") do context
    _set_supertype_for_type(context, EntityType, "woman", "person")
end

@when("entity(person) set supertype: animal") do context
    _set_supertype_for_type(context, EntityType, "person", "animal")
end

@when("entity(cat) set supertype: animal") do context
    _set_supertype_for_type(context, EntityType, "cat", "animal")
end

@then("entity(man) get supertype: person") do context
    res = _is_supertype_for_type(context, EntityType, "man", "person")
    @expect res === true
end

@then("entity(woman) get supertype: person") do context
    res = _is_supertype_for_type(context, EntityType, "woman", "person")
    @expect res === true
end

@then("entity(person) get supertype: animal") do context
    res = _is_supertype_for_type(context, EntityType, "person", "animal")
    @expect res === true
end

@then("entity(cat) get supertype: animal") do context
    res = _is_supertype_for_type(context, EntityType, "cat", "animal")
    @expect res === true
end

@then("entity(man) get supertypes contain:") do context
    res_contain = _supertypes_contain(context, EntityType, "man")
    @expect all(res_contain) === true
end

@then("entity(woman) get supertypes contain:") do context
    res_contain = _supertypes_contain(context, EntityType, "woman")
    @expect all(res_contain) === true
end

@then("entity(person) get supertypes contain:") do context
    res_contain = _supertypes_contain(context, EntityType, "person")
    @expect all(res_contain) === true
end

@then("entity(cat) get supertypes contain:") do context
    res_contain = _supertypes_contain(context, EntityType, "cat")
    @expect all(res_contain) === true
end

@then("entity(man) get subtypes contain:") do context
    res_contain = _subtypes_contain(context, EntityType, "man")
    @expect all(res_contain) === true
end

@then("entity(woman) get subtypes contain:") do context
    res_contain = _subtypes_contain(context, EntityType, "woman")
    @expect all(res_contain) === true
end

@then("entity(person) get subtypes contain:") do context
    res_contain = _subtypes_contain(context, EntityType, "person")
    @expect all(res_contain) === true
end

@then("entity(cat) get subtypes contain:") do context
    res_contain = _subtypes_contain(context, EntityType, "cat")
    @expect all(res_contain) === true
end

@then("entity(animal) get subtypes contain:") do context
    res_contain = _subtypes_contain(context, EntityType, "animal")
    @expect all(res_contain) === true
end

@then("entity(entity) get subtypes contain:") do context
    res_contain = _subtypes_contain(context, EntityType, "entity")
    @expect all(res_contain) === true
end

# Scenario: Entity types cannot subtype itself
@when("entity(person) set supertype: person; throws exception") do context
    try
        _set_supertype_for_type(context, EntityType, "person", "person")
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity types can have keys
@then("entity(person) get owns key types contain:") do context
    res = _get_owns_contain(context, EntityType, "person", true)
    @expect all(res) === true
end

# Scenario: Entity types can only commit keys if every instance owns a distinct key
@when("entity(person) set owns key type: email; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    owns_attr = g.get(ConceptManager(context[:transaction]), AttributeType, "email")
    try
        g.set_owns(g.as_remote(attr, context[:transaction]),
                owns_attr,
                true)
    catch ex
        @expect ex !== nothing
    end
end

@when("\$alice = attribute(email) as(string) put: alice@typedb.ai") do context
    ins_string = raw"""insert $x isa email; $x "alice@typedb.ai";"""
    context[:alice] = g.insert(context[:transaction], ins_string)[1].data["x"]
end

@when("\$bob = attribute(email) as(string) put: bob@typedb.ai") do context
    ins_string = raw"""insert $x isa email; $x "bob@typedb.ai";"""
    context[:bob] = g.insert(context[:transaction], ins_string)[1].data["x"]
end

@when("entity \$b set has: \$bob") do context
    set_has(context[:transaction], context[:b], context[:bob])
end

# Scenario: Entity types can unset keys
@when("entity(person) unset owns key type: email") do context
    attr_owns = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    attr_owned = g.get(ConceptManager(context[:transaction]), AttributeType, "email")
    g.unset_owns(g.as_remote(attr_owns, context[:transaction]),
                    attr_owned)
end

@when("entity(person) unset owns key type: username") do context
    attr_owns = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    attr_owned = g.get(ConceptManager(context[:transaction]), AttributeType, "username")
    g.unset_owns(g.as_remote(attr_owns, context[:transaction]),
                    attr_owned)
end

@then("entity(person) get owns key types do not contain:") do context
    res = _get_owns_contain(context, EntityType, "person", true)
    @expect !all(res)
end





# Scenario: Entity types cannot have keys of attributes that are not keyable
@given("entity(person) set owns key type: age") do context
    g.con.entity_set_owns("person", "age", context[:transaction], true)
end

@given("entity(person) set owns key type: name") do context
    g.con.entity_set_owns("person", "name", context[:transaction], true)
end

@given("entity(person) set owns key type: timestamp") do context
    g.con.entity_set_owns("person", "timestamp", context[:transaction], true)
end

@given("entity(person) set owns key type: is-open; throws exception") do context
    try
        g.con.entity_set_owns("person", "timestamp", context[:transaction])
    catch ex
        @expect ex !== nothing
    end
end

@given("entity(person) set owns key type: rating; throws exception") do context
    try
        g.con.entity_set_owns("person", "rating", context[:transaction], true)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity types can have attributes
@then("entity(person) get owns attribute types contain:") do context
    res = _get_owns_contain(context, EntityType, "person", false)
    @expect all(res) === true
end

# Scenario: Entity types can unset owning attributes
@when("entity(person) unset owns attribute type: age") do context
    attr_owns = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    attr_owned = g.get(ConceptManager(context[:transaction]), AttributeType, "age")
    g.unset_owns(g.as_remote(attr_owns, context[:transaction]),
                    attr_owned)
end

@then("entity(person) get owns attribute types do not contain:") do context
    res = _get_owns_contain(context, EntityType, "person", false)
    @expect all(res) === false
end

@when("entity(person) unset owns attribute type: name") do context
    attr_owns = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    attr_owned = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    g.unset_owns(g.as_remote(attr_owns, context[:transaction]),
                    attr_owned)
end

# Scenario: Entity types cannot unset owning attributes that are owned by existing instances
@when("\$alice = attribute(name) as(string) put: alice") do context
    res = g.insert(context[:transaction], raw"""insert $x isa name; $x "alice";""")
    context[:alice] = g.match(context[:transaction], raw"""match $x isa name; $x="alice";""")[1].data["x"]
end

@when("entity(person) unset owns attribute type: name; throws exception") do context
    attr_owns = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    attr_owned = g.get(ConceptManager(context[:transaction]), AttributeType, "name")

    try
        g.unset_owns(g.as_remote(attr_owns, context[:transaction]),
                        attr_owned)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity types can inherit keys and attributes
@when("put attribute type: reference, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "reference",
            VALUE_TYPE.STRING)
end

@when("put entity type: customer") do context
    g.put(ConceptManager(context[:transaction]),
            EntityType,
            "customer")
end

@when("entity(customer) set supertype: person") do context
    _set_supertype_for_type(context, EntityType, "customer", "person")
end

@given("entity(customer) set owns key type: reference") do context
    g.con.entity_set_owns("customer", "reference", context[:transaction], true)
end

@given("entity(customer) set owns attribute type: rating") do context
    g.con.entity_set_owns("customer", "rating", context[:transaction], false)
end

@then("entity(customer) get owns key types contain:") do context
    res = _get_owns_contain(context, EntityType, "customer", true)
    @expect all(res) === true
end



@when("put attribute type: points, with value type: double") do context
    g.put(ConceptManager(context[:transaction]),
                            AttributeType,
                            "points",
                            VALUE_TYPE.DOUBLE)
end

@when("put entity type: subscriber") do context
    g.put(ConceptManager(context[:transaction]),
                            EntityType,
                            "subscriber")
end

@when("entity(subscriber) set supertype: customer") do context
    _set_supertype_for_type(context, EntityType, "subscriber", "customer")
end

@when("entity(subscriber) set owns key type: license") do context
    g.con.entity_set_owns("subscriber", "license", context[:transaction], true)
end

@when("entity(subscriber) set owns attribute type: points") do context
    g.con.entity_set_owns("subscriber", "points", context[:transaction], false)
end

@then("entity(subscriber) get owns key types contain:") do context
    res = _get_owns_contain(context, EntityType, "subscriber", true)
    @expect all(res) === true
end

@then("entity(customer) get owns attribute types contain:") do context
    res = _get_owns_contain(context, EntityType, "customer", false)
    @expect all(res) === true
end

@then("entity(subscriber) get owns attribute types contain:") do context
    res = _get_owns_contain(context, EntityType, "subscriber", false)
    @expect all(res) === true
end

# Scenario: Entity types can inherit keys and attributes that are subtypes of each other
@when("attribute(username) set abstract: true") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "username")
    g.set_abstract(g.as_remote(attr_name, context[:transaction]))
end

@when("attribute(score) set abstract: true") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "score")
    g.set_abstract(g.as_remote(attr_name, context[:transaction]))
end

@when("attribute(reference) set abstract: true") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "reference")
    g.set_abstract(g.as_remote(attr_name, context[:transaction]))
end

@when("attribute(reference) set supertype: username") do context
    _set_supertype_for_type(context, AttributeType, "reference", "username")
end

@when("attribute(rating) set abstract: true") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "rating")
    g.set_abstract(g.as_remote(attr_name, context[:transaction]))
end

@when("attribute(rating) set supertype: score") do context
    _set_supertype_for_type(context, AttributeType, "rating", "score")
end

@when("entity(customer) set abstract: true") do context
    attr_name = g.get(ConceptManager(context[:transaction]), EntityType, "customer")
    g.set_abstract(g.as_remote(attr_name, context[:transaction]))
end

@when("attribute(license) set supertype: reference") do context
    _set_supertype_for_type(context, AttributeType, "license", "reference")
end

@when("attribute(points) set supertype: rating") do context
    _set_supertype_for_type(context, AttributeType, "points", "rating")
end

@when("entity(subscriber) set abstract: true") do context
    attr_name = g.get(ConceptManager(context[:transaction]), EntityType, "subscriber")
    g.set_abstract(g.as_remote(attr_name, context[:transaction]))
end

# Scenario: Entity types can override inherited keys and attributes

@when("put attribute type: work-email, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
                            AttributeType,
                            "work-email",
                            VALUE_TYPE.STRING)
end

@when("attribute(work-email) set supertype: email") do context
    _set_supertype_for_type(context, AttributeType, "work-email", "email")
end

@when("put attribute type: nick-name, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
                            AttributeType,
                            "nick-name",
                            VALUE_TYPE.STRING)
end

@when("attribute(nick-name) set supertype: name") do context
    _set_supertype_for_type(context, AttributeType, "nick-name", "name")
end

@when("entity(customer) set owns key type: work-email as email") do context
    entity_owns = g.get(ConceptManager(context[:transaction]), EntityType, "customer")
    attr_set_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "work-email")
    attr_overriden = g.get(ConceptManager(context[:transaction]), AttributeType, "email")

    g.set_owns(g.as_remote(entity_owns, context[:transaction]),
                attr_set_owns,
                true,
                attr_overriden)
end

@when("entity(customer) set owns attribute type: nick-name as name") do context
    entity_owns = g.get(ConceptManager(context[:transaction]), EntityType, "customer")
    attr_set_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "nick-name")
    attr_overriden = g.get(ConceptManager(context[:transaction]), AttributeType, "name")

    g.set_owns(g.as_remote(entity_owns, context[:transaction]),
                attr_set_owns,
                false,
                attr_overriden)
end

@then("entity(customer) get owns key types do not contain:") do context
    res = _get_owns_contain(context, EntityType, "customer", true)
    @expect all(res) === false
end

@then("entity(customer) get owns attribute types do not contain:") do context
    res = _get_owns_contain(context, EntityType, "customer", false)
    @expect all(res) === false
end

@when("entity(subscriber) set owns key type: license as reference") do context
    entity_owns = g.get(ConceptManager(context[:transaction]), EntityType, "subscriber")
    attr_set_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "license")
    attr_overriden = g.get(ConceptManager(context[:transaction]), AttributeType, "reference")

    g.set_owns(g.as_remote(entity_owns, context[:transaction]),
                attr_set_owns,
                true,
                attr_overriden)
end

@when("entity(subscriber) set owns attribute type: points as rating") do context
    entity_owns = g.get(ConceptManager(context[:transaction]), EntityType, "subscriber")
    attr_set_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "points")
    attr_overriden = g.get(ConceptManager(context[:transaction]), AttributeType, "rating")

    g.set_owns(g.as_remote(entity_owns, context[:transaction]),
                attr_set_owns,
                false,
                attr_overriden)
end

@then("entity(subscriber) get owns key types do not contain:") do context
    res = _get_owns_contain(context, EntityType, "subscriber", true)
    @expect all(res) === false
end

@then("entity(subscriber) get owns attribute types do not contain:") do context
    res = _get_owns_contain(context, EntityType, "subscriber", false)
    @expect all(res) === false
end

# Scenario: Entity types can override inherited attributes as keys
@when("entity(customer) set owns key type: username as name") do context
    entity_owns = g.get(ConceptManager(context[:transaction]), EntityType, "customer")
    attr_set_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "username")
    attr_overriden = g.get(ConceptManager(context[:transaction]), AttributeType, "name")

    g.set_owns(g.as_remote(entity_owns, context[:transaction]),
                attr_set_owns,
                true,
                attr_overriden)
end

# Scenario: Entity types can redeclare inherited attributes as keys (which will override)
@when("entity(customer) set owns key type: email") do context
    entity_owns = g.get(ConceptManager(context[:transaction]), EntityType, "customer")
    attr_set_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "email")

    g.set_owns(g.as_remote(entity_owns, context[:transaction]),
                attr_set_owns,
                true)
end

@when("entity(subscriber) set supertype: person") do context
    _set_supertype_for_type(context, EntityType, "subscriber", "person")
end

@when("entity(subscriber) set owns key type: email") do context
    entity_owns = g.get(ConceptManager(context[:transaction]), EntityType, "subscriber")
    attr_set_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "email")

    g.set_owns(g.as_remote(entity_owns, context[:transaction]),
                attr_set_owns,
                true)
end

# Scenario: Entity types cannot redeclare inherited attributes as attributes
@when("entity(customer) set owns attribute type: name; throws exception") do context
    entity_owns = g.get(ConceptManager(context[:transaction]), EntityType, "customer")
    attr_set_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "name")

    try
        g.set_owns(g.as_remote(entity_owns, context[:transaction]),
                    attr_set_owns,
                    false)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity types cannot redeclare inherited keys as keys or attributes
@when("entity(customer) set owns key type: email; throws exception") do context
    entity_owns = g.get(ConceptManager(context[:transaction]), EntityType, "customer")
    attr_set_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "email")

    try
        g.set_owns(g.as_remote(entity_owns, context[:transaction]),
                    attr_set_owns,
                    true)
    catch ex
        @expect ex !== nothing
    end
end

@when("entity(customer) set owns attribute type: email; throws exception") do context
    try
        g.con.entity_set_owns("customer", "email", context[:transaction], true)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity types cannot redeclare inherited key attribute types
@when("put attribute type: customer-email, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "customer-email",
            VALUE_TYPE.STRING)
end

@when("attribute(customer-email) set supertype: email") do context
    _set_supertype_for_type(context, AttributeType, "customer-email", "email")
end

@when("entity(customer) set owns key type: customer-email") do context
    g.con.entity_set_owns("customer", "customer-email", context[:transaction], true)
end

@given("entity(subscriber) set owns key type: email; throws exception") do context
    try
        g.con.entity_set_owns("subscriber", "email", context[:transaction], true)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity types cannot redeclare overridden key attribute types
@given("entity(subscriber) set owns key type: customer-email; throws exception") do context
    try
        g.con.entity_set_owns("subscriber", "customer-email", context[:transaction], true)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity types cannot redeclare inherited owns attribute types
@when("put attribute type: customer-name, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "customer-name",
            VALUE_TYPE.STRING)
end

@when("attribute(customer-name) set supertype: name") do context
    _set_supertype_for_type(context, AttributeType, "customer-name", "name")
end

@when("entity(customer) set owns attribute type: customer-name") do context
    g.con.entity_set_owns("customer", "customer-name", context[:transaction], false)
end

@given("entity(subscriber) set owns attribute type: name; throws exception") do context
    try
        g.con.entity_set_owns("subscriber", "name", context[:transaction], true)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity types cannot redeclare overridden owns attribute types
@given("entity(subscriber) set owns attribute type: customer-name; throws exception") do context
    try
        g.con.entity_set_owns("subscriber", "customer-name", context[:transaction], false)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity types cannot redeclare overridden owns attribute types
@when("attribute(email) set supertype: username") do context
    _set_supertype_for_type(context, AttributeType, "email", "username")
end

@when("attribute(first-name) set supertype: name") do context
    _set_supertype_for_type(context, AttributeType, "first-name", "name")
end

@when("entity(person) set owns key type: email as username; throws exception") do context
    try
        g.con.entity_set_owns("person", "email", context[:transaction], false, "username")
    catch ex
        @expect ex !== nothing
    end
end

@when("entity(person) set owns attribute type: first-name as name; throws exception") do context
    try
        g.con.entity_set_owns("person", "first-name", context[:transaction], false, "name")
    catch ex
        @expect ex !== nothing
    end
end

# entity(customer) set owns attribute type: email as username; throws exception
@when("entity(customer) set owns attribute type: email as username; throws exception") do context
    try
        g.con.entity_set_owns("customer", "email", context[:transaction], false, "username")
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity types cannot override inherited keys and attributes other than with their subtypes
@when("entity(customer) set owns key type: reference as username; throws exception") do context
    try
        g.con.entity_set_owns("customer", "reference", context[:transaction], true, "username")
    catch ex
        @expect ex !== nothing
    end
end

@then("entity(customer) set owns attribute type: rating as name; throws exception") do context
    try
        g.con.entity_set_owns("customer", "rating", context[:transaction], false, "name")
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity types can play role types
@then("entity(person) get playing roles contain:") do context
    res = _get_playing_roles_contain("person", EntityType, context)
    @expect all(res) === true
end

@then("relation(marriage) get role(husband) get players contain:") do context
    res = _get_players_contain("marriage","husband", context)
    @expect all(res) === true
end

@then("relation(marriage) get role(wife) get players contain:") do context
    res = _get_players_contain("marriage","wife", context)
    @expect all(res) === true
end

# Scenario: Entity types can unset playing role types
@then("entity(person) unset plays role: marriage:husband") do context
    role = RoleType(g.Label("marriage","husband"), false)
    attr = g.get(ConceptManager(context[:transaction]),
                    EntityType,
                    "person")

    g.unset_plays(g.as_remote(attr, context[:transaction]),role)
end

@then("entity(person) get playing roles do not contain:") do context
    res = _get_playing_roles_contain("person", EntityType, context)
    @expect all(res) === false
end

@then("relation(marriage) get role(husband) get players do not contain:") do context
    res = _get_players_contain("marriage","husband", context)
    @expect all(res) === false
end

@then("entity(person) unset plays role: marriage:wife") do context
    role = RoleType(g.Label("marriage","wife"), false)
    attr = g.get(ConceptManager(context[:transaction]),
                    EntityType,
                    "person")

    g.unset_plays(g.as_remote(attr, context[:transaction]),role)
end

@then("relation(marriage) get role(wife) get players do not contain:") do context
    res = _get_players_contain("marriage","wife", context)
    @expect all(res) === false
end

# Scenario: Attempting to unset playing a role type that an entity type cannot actually play throws
@then("entity(person) unset plays role: marriage:husband; throws exception") do context
    role = RoleType(g.Label("marriage","husband"), false)
    attr = g.get(ConceptManager(context[:transaction]),
                    EntityType,
                    "person")
    try
        g.unset_plays(g.as_remote(attr, context[:transaction]),role)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity types cannot unset playing role types that are currently played by existing instances
@when("\$m = relation(marriage) create new instance") do context
    mar_type = g.get(ConceptManager(context[:transaction]), RelationType, "marriage")
    context[:marriage] = g.create(g.as_remote(mar_type, context[:transaction]))
end

@then("entity(person) unset plays role: marriage:wife; throws exception") do context
    role = RoleType(g.Label("marriage","wife"), false)
    attr = g.get(ConceptManager(context[:transaction]),
                    EntityType,
                    "person")
    try
        g.unset_plays(g.as_remote(attr, context[:transaction]),role)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity types can inherit playing role types
@when("put relation type: parentship") do context
    g.put(ConceptManager(context[:transaction]),
        RelationType,
        "parentship")
end

@when("relation(parentship) set relates role: parent") do context
    g.set_relates(context[:transaction],
        g.Label("","parentship"),
                "parent")
end

@when("relation(parentship) set relates role: child") do context
    g.set_relates(context[:transaction],
        g.Label("","parentship"),
                "child")
end

@when("entity(animal) set plays role: parentship:parent") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), EntityType, "animal")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]), g.RoleType(g.Label("parentship", "parent"),false))
end

@when("entity(animal) set plays role: parentship:child") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), EntityType, "animal")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]), g.RoleType(g.Label("parentship", "child"),false))
end

@when("put relation type: sales") do context
    g.put(ConceptManager(context[:transaction]),
        RelationType,
        "sales")
end

@when("relation(sales) set relates role: buyer") do context
    g.set_relates(context[:transaction],
        g.Label("","sales"),
                "buyer")
end

@when("entity(customer) set plays role: sales:buyer") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), EntityType, "customer")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]), g.RoleType(g.Label("sales", "buyer"),false))
end

@then("entity(customer) get playing roles contain:") do context
    res = _get_playing_roles_contain("customer", EntityType, context)
    @expect all(res) === true
end

@then("entity(animal) get playing roles contain:") do context
    res = _get_playing_roles_contain("animal", EntityType, context)
    @expect all(res) === true
end

# Scenario: Entity types can inherit playing role types that are subtypes of each other
@when("put relation type: fathership") do context
    g.put(ConceptManager(context[:transaction]),
        RelationType,
        "fathership")
end

@when("relation(fathership) set supertype: parentship") do context
    _set_supertype_for_type(context, RelationType, "fathership", "parentship")
end

@when("relation(fathership) set relates role: father as parent") do context
    g.set_relates(context[:transaction],
        g.Label("","fathership"),
                "father",
                "parent")
end

@when("entity(person) set plays role: parentship:parent") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]), g.RoleType(g.Label("parentship", "parent"),false))
end

@when("entity(person) set plays role: parentship:child") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]), g.RoleType(g.Label("parentship", "child"),false))
end

@when("entity(man) set plays role: fathership:father") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), EntityType, "man")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]), g.RoleType(g.Label("fathership", "father"),false))
end

@then("entity(man) get playing roles contain:") do context
    res = _get_playing_roles_contain("man", EntityType, context)
    @expect all(res) === true
end

@when("put relation type: mothership") do context
    g.put(ConceptManager(context[:transaction]),
        RelationType,
        "mothership")
end

@when("relation(mothership) set supertype: parentship") do context
    _set_supertype_for_type(context, RelationType, "mothership", "parentship")
end

@when("relation(mothership) set relates role: mother as parent") do context
    g.set_relates(context[:transaction],
        g.Label("","mothership"),
                "mother",
                "parent")
end

@when("entity(woman) set plays role: mothership:mother") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), EntityType, "woman")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]), g.RoleType(g.Label("mothership", "mother"),false))
end

@then("entity(woman) get playing roles contain:") do context
    res = _get_playing_roles_contain("woman", EntityType, context)
    @expect all(res) === true
end

# Scenario: Entity types can override inherited playing role types

@when("entity(man) set plays role: fathership:father as parentship:parent") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), EntityType, "man")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]),
        g.RoleType(g.Label("fathership", "father"),false),
        g.RoleType(g.Label("parentship", "parent"),false))
end

@then("entity(man) get playing roles do not contain:") do context
    res = _get_playing_roles_contain("man", EntityType, context)
    @expect all(res) === false
end

@when("entity(woman) set plays role: mothership:mother as parentship:parent") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), EntityType, "woman")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]),
        g.RoleType(g.Label("mothership", "mother"),false),
        g.RoleType(g.Label("parentship", "parent"),false))
end

@then("entity(woman) get playing roles do not contain:") do context
    res = _get_playing_roles_contain("woman", EntityType, context)
    @expect all(res) === false
end

# Scenario: Entity types cannot redeclare inherited/overridden playing role types
@when("entity(boy) set supertype: man") do context
    _set_supertype_for_type(context, EntityType, "boy", "man")
end

@when("entity(boy) set plays role: parentship:parent; throws exception") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), EntityType, "boy")
    try
        g.set_plays(g.as_remote(ent_pers, context[:transaction]), g.RoleType(g.Label("parentship", "parent"),false))
    catch ex
        @expect ex !== nothing
    end
end

@then("entity(boy) set plays role: fathership:father; throws exception") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), EntityType, "boy")
    try
        g.set_plays(g.as_remote(ent_pers, context[:transaction]), g.RoleType(g.Label("parentship", "parent"),false))
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity types cannot override declared playing role types
@then("entity(person) set plays role: fathership:father as parentship:parent; throws exception") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), EntityType, "person")
    try
        g.set_plays(g.as_remote(ent_pers,
            context[:transaction]),
            g.RoleType(g.Label("fathership", "father"),false),
            g.RoleType(g.Label("parentship", "parent"),false))
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Entity types cannot override inherited playing role types other than with their subtypes
@when("relation(fathership) set relates role: father") do context
    g.set_relates(context[:transaction],
        g.Label("","fathership"),
                "father")
end

@then("entity(man) set plays role: fathership:father as parentship:parent; throws exception") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), EntityType, "man")
    try
        g.set_plays(g.as_remote(ent_pers,
            context[:transaction]),
            g.RoleType(g.Label("fathership", "father"),false),
            g.RoleType(g.Label("parentship", "parent"),false))
    catch ex
        @expect ex !== nothing
    end
end

@when("relation(marriage) set plays role: locates:located") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), RelationType, "marriage")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]), g.RoleType(g.Label("locates", "located"),false))
end

@then("relation(marriage) get playing roles contain:") do context
    res = _get_playing_roles_contain("marriage", RelationType, context)
    @expect all(res) === true
end

@when("put relation type: organises") do context
    g.put(context[:cm], RelationType, "organises")
end

@when("relation(organises) set relates role: organiser") do context
    g.set_relates(context[:transaction],
        g.Label("","organises"),
                "organiser")
end

@when("relation(organises) set relates role: organised") do context
    g.set_relates(context[:transaction],
        g.Label("","organises"),
                "organised")
end

@when("relation(marriage) set plays role: organises:organised") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), RelationType, "marriage")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]), g.RoleType(g.Label("organises", "organised"),false))
end
