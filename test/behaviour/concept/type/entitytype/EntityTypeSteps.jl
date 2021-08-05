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
