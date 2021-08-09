# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

# Scenario: Relation and role types can be created
@then("relation(marriage) is null: false") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    @expect res !== nothing
end

@then("relation(marriage) get supertype: relation") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    res_relat_super = g.get_supertype(g.as_remote(res, context[:transaction]))
    @expect res_relat_super.label.name == "relation"
end

@then("relation(marriage) get role(husband) is null: false") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "husband")
    @expect role_play !== nothing
end

@then("relation(marriage) get role(wife) is null: false") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "wife")
    @expect role_play !== nothing
end

@then("relation(marriage) get role(husband) get supertype: relation:role") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "husband")
    res_supertype = g.get_supertype(g.as_remote(role_play, context[:transaction]))
    @expect res_supertype == RoleType(g.Label("relation","role"),true)
end

@then("relation(marriage) get role(wife) get supertype: relation:role") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "wife")
    res_supertype = g.get_supertype(g.as_remote(role_play, context[:transaction]))
    @expect res_supertype == RoleType(g.Label("relation","role"),true)
end

@then("relation(marriage) get related roles contain:") do context
    result_contain = _get_related_roles_contain(context, "marriage")
    @expect all(result_contain) === true
end

#  Scenario: Relation and role types can be deleted
@when("relation(marriage) set relates role: spouse") do context
    g.set_relates(context[:transaction],
        g.Label("","marriage"),
                "spouse")
end

@when("relation(parentship) unset related role: parent") do context
   rel_res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "parentship")
    g.unset_relates(g.as_remote(rel_res, context[:transaction]), "parent")
end

@then("relation(parentship) get related roles do not contain:") do context
    result_contain = _get_related_roles_contain(context, "parentship")
    @expect all(result_contain) === false
end

@then("relation(relation) get role(role) get subtypes do not contain:") do context
    db_contain = [_split_role(db[1]) for db in context.datatable]
    rel = g.get(ConceptManager(context[:transaction]),
                    RelationType,
                    "relation")
    role = g.relation_type_get_relates_for_role_label(g.as_remote(rel, context[:transaction]), "role")
    subtypes_roles = g.get_subtypes(g.as_remote(role, context[:transaction]))
    for i in 1:length(db_contain)
        type = RoleType(g.Label(db_contain[i].first, db_contain[i].second), false)
        @expect !in(type, subtypes_roles)
    end
end

@when("delete relation type: parentship") do context
    rel = g.get(ConceptManager(context[:transaction]),
                    RelationType,
                    "parentship")
    g.delete(g.as_remote(rel, context[:transaction]))
end

@then("relation(parentship) is null: true") do context
    rel = g.get(ConceptManager(context[:transaction]),
                    RelationType,
                    "parentship")
    @expect rel === nothing
end

@then("relation(marriage) unset related role: spouse") do context
    rel = g.get(ConceptManager(context[:transaction]),
                    RelationType,
                    "marriage")
    g.unset_relates(g.as_remote(rel, context[:transaction]), "spouse")
end

@then("relation(marriage) get related roles do not contain:") do context
    result_contain = _get_related_roles_contain(context, "marriage")
    @expect all(result_contain) === false
end

@then("delete relation type: marriage") do context
    rel = g.get(ConceptManager(context[:transaction]),
                    RelationType,
                    "marriage")
    g.delete(g.as_remote(rel, context[:transaction]))
end

@then("relation(marriage) is null: true") do context
    rel = g.get(ConceptManager(context[:transaction]),
                    RelationType,
                    "marriage")
    @expect rel === nothing
end

# Scenario: Relation types that have instances cannot be deleted
@then("delete relation type: marriage; throws exception") do context
    rel = g.get(ConceptManager(context[:transaction]),
                    RelationType,
                    "marriage")
    try
        g.delete(g.as_remote(rel, context[:transaction]))
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Role types that have instances cannot be deleted
@then("relation(marriage) unset related role: wife; throws exception") do context
    rel = g.get(ConceptManager(context[:transaction]),
                    RelationType,
                    "marriage")
    try
        g.unset_relates(g.as_remote(rel, context[:transaction]), "wife")
    catch ex
        @expect ex !== nothing
    end
end

@then("relation(marriage) unset related role: husband") do context
    rel = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    g.unset_relates(g.as_remote(rel, context[:transaction]), "husband")
end

# Scenario: Relation and role types can change labels
@then("relation(parentship) get label: parentship") do context
    rel = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "parentship")
    @expect rel.label.name == "parentship"
end

@then("relation(parentship) get role(parent) get label: parent") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "parentship")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "parent")
    @expect role_play.label.name == "parent"
end

@then("relation(parentship) get role(child) get label: child") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "parentship")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "child")
    @expect role_play.label.name == "child"
end

@then("relation(parentship) set label: marriage") do context
    rel = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "parentship")
    g.set_label(g.as_remote(rel, context[:transaction]), "marriage")
end

@then("relation(marriage) get role(parent) set label: husband") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "parent")
    g.set_label(g.as_remote(role_play, context[:transaction]), "husband")
end

@then("relation(marriage) get role(child) set label: wife") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "child")
    g.set_label(g.as_remote(role_play, context[:transaction]), "wife")
end

@then("relation(marriage) get role(parent) is null: true") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "parent")
    @expect role_play === nothing
end

@then("relation(marriage) get role(child) is null: true") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "child")
    @expect role_play === nothing
end

@then("relation(marriage) get label: marriage") do context
    rel = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    @expect rel.label.name == "marriage"
end

@then("relation(marriage) get role(husband) get label: husband") do context
    res = g.get(ConceptManager(context[:transaction]),
                    RelationType,
                    "marriage")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "husband")
    @expect role_play.label.name == "husband"
end

@then("relation(marriage) get role(wife) get label: wife") do context
    res = g.get(ConceptManager(context[:transaction]),
                    RelationType,
                    "marriage")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "wife")
    @expect role_play.label.name == "wife"
end

@when("relation(marriage) set label: employment") do context
    rel = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    g.set_label(g.as_remote(rel, context[:transaction]), "employment")
end

@then("relation(employment) is null: false") do context
    rel = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "employment")
    @expect rel !== nothing
end

@when("relation(employment) get role(husband) set label: employee") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "employment")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "husband")
    g.set_label(g.as_remote(role_play, context[:transaction]), "employee")
end

@when("relation(employment) get role(wife) set label: employer") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "employment")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "wife")
    g.set_label(g.as_remote(role_play, context[:transaction]), "employer")
end

@then("relation(employment) get role(husband) is null: true") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "employment")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "husband")
    @expect role_play === nothing
end

@then("relation(employment) get role(wife) is null: true") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "employment")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "wife")
    @expect role_play === nothing
end

@then("relation(employment) get label: employment") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "employment")
    @expect res.label.name == "employment"
end

@then("relation(employment) get role(employee) get label: employee") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "employment")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "employee")
    @expect role_play.label.name == "employee"
end

@then("relation(employment) get role(employer) get label: employer") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "employment")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "employer")
    @expect role_play.label.name == "employer"
end

# Scenario: Relation and role types can be set to abstract
@when("relation(marriage) set abstract: true") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    g.set_abstract(g.as_remote(res, context[:transaction]))
end

@then("relation(marriage) is abstract: true") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    result = g.is_abstract(g.as_remote(res, context[:transaction]))
    @expect result === true
end

@then("relation(marriage) get role(husband) is abstract: true") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "husband")
    result = g.is_abstract(g.as_remote(role_play, context[:transaction]))
    @expect result === true
end

@then("relation(marriage) get role(wife) is abstract: true") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "wife")
    result = g.is_abstract(g.as_remote(role_play, context[:transaction]))
    @expect result === true
end

@then("relation(marriage) create new instance; throws exception") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    try
        g.create(g.as_remote(res, context[:transaction]))
    catch ex
        @expect ex !== nothing
    end
end

@then("relation(parentship) is abstract: false") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "parentship")
    result = g.is_abstract(g.as_remote(res, context[:transaction]))
    @expect result === false
end

@then("relation(parentship) get role(parent) is abstract: false") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "parentship")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "parent")
    result = g.is_abstract(g.as_remote(role_play, context[:transaction]))
    @expect result === false
end



@then("relation(parentship) set abstract: true") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "parentship")
    g.set_abstract(g.as_remote(res, context[:transaction]))
end

@then("relation(parentship) is abstract: true") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "parentship")
    result = g.is_abstract(g.as_remote(res, context[:transaction]))
    @expect result === true
end

@then("relation(parentship) get role(parent) is abstract: true") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "parentship")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "parent")
    result = g.is_abstract(g.as_remote(role_play, context[:transaction]))
    @expect result === true
end

@then("relation(parentship) get role(child) is abstract: false") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "parentship")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "child")
    result = g.is_abstract(g.as_remote(role_play, context[:transaction]))
    @expect result === false
end

@then("elation(parentship) get role(child) is abstract: true") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "parentship")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "child")
    result = g.is_abstract(g.as_remote(role_play, context[:transaction]))
    @expect result === true
end

@then("relation(parentship) get role(child) is abstract: true") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "parentship")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "child")
    result = g.is_abstract(g.as_remote(role_play, context[:transaction]))
    @expect result === true
end

@then("relation(parentship) create new instance; throws exception") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "parentship")
    try
        g.create(g.as_remote(res, context[:transaction]))
     catch ex
        @expect ex !== nothing
     end
end

# Scenario: Relation types must have at least one role in order to commit, unless they are abstract
@when("put relation type: connection") do context
    g.put(ConceptManager(context[:transaction]),
            RelationType,
            "connection")
end

@when("relation(connection) set abstract: true") do context
    rel = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "connection")
    g.set_abstract(g.as_remote(rel, context[:transaction]))
end

# Scenario: Relation and role types can be subtypes of other relation and role types
@then("relation(fathership) get supertype: parentship") do context
    rel = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "fathership")
    res = g.get_supertype(g.as_remote(rel, context[:transaction]))
    @expect res.label.name == "parentship"
end

@then("relation(fathership) get role(father) get supertype: parentship:parent") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "fathership")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "father")
    res_supertype = g.get_supertype(g.as_remote(role_play, context[:transaction]))
    @expect res_supertype == RoleType(g.Label("parentship","parent"),false)
end

@then("relation(fathership) get role(child) get supertype: relation:role") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "fathership")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "child")
    res_supertype = g.get_supertype(g.as_remote(role_play, context[:transaction]))
    @expect res_supertype == RoleType(g.Label("relation","role"),true)
end

@then("relation(fathership) get supertypes contain:") do context
    res_contain = _supertypes_contain(context, RelationType, "fathership")
    @expect all(res_contain) === true
end

@then("relation(fathership) get role(father) get supertypes contain:") do context
    res_contain = _supertypes_contain(context, RoleType, "fathership", "father")
    @expect all(res_contain) === true
end

@then("relation(fathership) get role(child) get supertypes contain:") do context
    res_contain = _supertypes_contain(context, RoleType, "fathership", "child")
    @expect all(res_contain) === true
end

@then("relation(parentship) get subtypes contain:") do context
    res_contain = _subtypes_contain(context, RelationType, "parentship")
    @expect all(res_contain) === true
end

@then("relation(parentship) get role(parent) get subtypes contain:") do context
    res_contain = _subtypes_contain(context, RoleType, "parentship", "parent")
    @expect all(res_contain) === true
end

@then("relation(parentship) get role(child) get subtypes contain:") do context
    res_contain = _subtypes_contain(context, RoleType, "parentship", "child")
    @expect all(res_contain) === true
end

@then("relation(relation) get subtypes contain:") do context
    res_contain = _subtypes_contain(context, RelationType, "relation")
    @expect all(res_contain) === true
end

@then("relation(relation) get role(role) get subtypes contain:") do context
    res_contain = _subtypes_contain(context, RoleType, "relation", "role")
    @expect all(res_contain) === true
end

@when("put relation type: father-son") do context
    g.put(ConceptManager(context[:transaction]),
            RelationType,
            "father-son")
end

@when("relation(father-son) set supertype: fathership") do context
    _set_supertype_for_type(context, RelationType, "father-son", "fathership")
end

@when("relation(father-son) set relates role: son as child") do context
    g.set_relates(context[:transaction],
        g.Label("","father-son"),
                "son",
                "child")
end

@when("relation(father-son) get supertype: fathership") do context
    rel = g.get(ConceptManager(context[:transaction]),
                    RelationType,
                    "father-son")
    res = g.get_supertype(g.as_remote(rel, context[:transaction]))
    @expect res.label.name == "fathership"
end

@then("relation(father-son) get role(father) get supertype: parentship:parent") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "father-son")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "father")
    res_supertype = g.get_supertype(g.as_remote(role_play, context[:transaction]))
    @expect res_supertype == RoleType(g.Label("parentship","parent"),true)
end

@then("relation(father-son) get role(son) get supertype: parentship:child") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "father-son")
    role_play = g.relation_type_get_relates_for_role_label(g.as_remote(res, context[:transaction]), "son")
    res_supertype = g.get_supertype(g.as_remote(role_play, context[:transaction]))
    @expect res_supertype == RoleType(g.Label("parentship","child"),true)
end

@then("relation(father-son) get supertypes contain:") do context
    res_contain = _supertypes_contain(context, RelationType, "father-son")
    @expect all(res_contain) === true
end

@then("relation(father-son) get role(father) get supertypes contain:") do context
    res_contain = _supertypes_contain(context, RoleType, "father-son", "father")
    @expect all(res_contain) === true
end

@then("relation(father-son) get role(son) get supertypes contain:") do context
    res_contain = _supertypes_contain(context, RoleType, "father-son", "son")
    @expect all(res_contain) === true
end

@then("relation(fathership) get subtypes contain:") do context
    res_contain = _subtypes_contain(context, RelationType, "fathership")
    @expect all(res_contain) === true
end

@then("relation(fathership) get role(father) get subtypes contain:") do context
    res_contain = _subtypes_contain(context, RoleType, "fathership", "father")
    @expect all(res_contain) === true
end

@then("relation(fathership) get role(child) get subtypes contain:") do context
    res_contain = _subtypes_contain(context, RoleType, "fathership", "child")
    @expect all(res_contain) === true
end

# Scenario: Relation types cannot subtype itself
@then("relation(marriage) set supertype: marriage; throws exception") do context
    res = g.get(ConceptManager(context[:transaction]),
                RelationType,
                "marriage")
    try
        g.set_supertype(g.as_remote(res, context[:transactino]), "marriage")
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Relation types can inherit related role types
@then("relation(fathership) get related roles contain:") do context
    result_contain = _get_related_roles_contain(context, "fathership")
    @expect all(result_contain) === true
end

@then("relation(mothership) get related roles contain:") do context
    result_contain = _get_related_roles_contain(context, "mothership")
    @expect all(result_contain) === true
end

# Scenario: Relation types can override inherited related role types
@then("relation(mothership) get related roles do not contain:") do context
    result_contain = _get_related_roles_contain(context, "mothership")
    @expect all(result_contain) === false
end

# Scenario: Relation types cannot redeclare inherited related role types
@then("relation(fathership) set relates role: parent; throws exception") do context
    try
        g.set_relates(context[:transaction],
            g.Label("","fathership"),
                    "parent")
     catch ex
        @expect ex !== nothing
     end
end

@then("relation(fathership) get related roles do not contain:") do context
    result_contain = _get_related_roles_contain(context, "fathership")
    @expect all(result_contain) === false
end

# Scenario: Relation types cannot override declared related role types
@then("relation(parentship) set relates role: father as parent; throws exception") do context
    try
        g.set_relates(context[:transaction],
            g.Label("","parentship"),
                    "father",
                    "parent")
     catch ex
        @expect ex !== nothing
     end
end

# Scenario: Relation types can have keys
@then("relation(marriage) get owns key types contain:") do context
    res = _get_owns_contain(context, RelationType, "marriage", true)
    @expect all(res) === true
end

# Scenario: Relation types can unset keys
@when("put attribute type: certificate, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "certificate",
            VALUE_TYPE.STRING)
end

@when("relation(marriage) set owns key type: certificate") do context
    g.con.entity_set_owns(g.RelationType ,"marriage", "certificate", context[:transaction], true)
end

@when("relation(marriage) unset owns key type: license") do context
    attr_country_name = g.get(ConceptManager(context[:transaction]), RelationType, "marriage")
    attr_country_code = g.get(ConceptManager(context[:transaction]), AttributeType, "license")
    g.unset_owns(g.as_remote(attr_country_name, context[:transaction]),
                    attr_country_code)
end

@then("relation(marriage) get owns key types do not contain:") do context
    res = _get_owns_contain(context, RelationType, "marriage", true)
    @expect all(res) === false
end

@when("relation(marriage) unset owns key type: certificate") do context
    attr_country_name = g.get(ConceptManager(context[:transaction]), RelationType, "marriage")
    attr_country_code = g.get(ConceptManager(context[:transaction]), AttributeType, "certificate")
    g.unset_owns(g.as_remote(attr_country_name, context[:transaction]),
                    attr_country_code)
end

# Scenario: Relation types can have keys of all keyable attributes
@when("put attribute type: is-permanent, with value type: boolean") do context
    g.put(context[:cm], AttributeType, "is-permanent", VALUE_TYPE.BOOLEAN)
end

@when("put attribute type: contract-years, with value type: long") do context
    g.put(context[:cm], AttributeType, "contract-years", VALUE_TYPE.LONG)
end

@when("put attribute type: salary, with value type: double") do context
    g.put(context[:cm], AttributeType, "salary", VALUE_TYPE.DOUBLE)
end

@when("put attribute type: start-date, with value type: datetime") do context
    g.put(context[:cm], AttributeType, "start-date", VALUE_TYPE.DATETIME)
end

@when("put relation type: employment") do context
    g.put(context[:cm], RelationType, "employment")
end

@when("relation(employment) set owns key type: contract-years") do context
    g.con.entity_set_owns(g.RelationType ,"employment", "contract-years", context[:transaction], true)
end

@when("relation(employment) set owns key type: reference") do context
    g.con.entity_set_owns(g.RelationType ,"employment", "reference", context[:transaction], true)
end

@when("relation(employment) set owns key type: start-date") do context
    g.con.entity_set_owns(g.RelationType ,"employment", "start-date", context[:transaction], true)
end

@then("relation(employment) set owns key type: is-permanent; throws exception") do context
    try
        g.con.entity_set_owns(g.RelationType ,"employment", "is-permanent", context[:transaction], true)
    catch ex
        @expect ex !== nothing
    end
end

@then("relation(employment) set owns key type: salary; throws exception") do context
    try
        g.con.entity_set_owns(g.RelationType ,"employment", "salary", context[:transaction], true)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Relation types can have attributes
@when("put attribute type: religion, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "religion",
            VALUE_TYPE.STRING)
end

@when("relation(marriage) set owns attribute type: religion") do context
    g.con.entity_set_owns(g.RelationType ,"marriage", "religion", context[:transaction], false)
end

@then("relation(marriage) get owns attribute types contain:") do context
    res = _get_owns_contain(context, RelationType, "marriage", false)
    @expect all(res) === true
end

# Scenario: Relation types can unset attributes
@when("relation(marriage) unset owns attribute type: religion") do context
    _thing_type_unset_type(context, RelationType, "marriage", AttributeType, "religion")
end

@then("relation(marriage) get owns attribute types do not contain:") do context
    res = _get_owns_contain(context, RelationType, "marriage", false)
    @expect all(res) === false
end

@when("relation(marriage) unset owns attribute type: date") do context
    _thing_type_unset_type(context, RelationType, "marriage", AttributeType, "date")
end

# Scenario: Relation types can inherit keys and attributes
@when("put attribute type: employment-reference, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "employment-reference",
            VALUE_TYPE.STRING)
end

@when("put attribute type: employment-hours, with value type: long") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "employment-hours",
            VALUE_TYPE.LONG)
end

@when("put attribute type: contractor-reference, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "contractor-reference",
            VALUE_TYPE.STRING)
end

@when("put attribute type: contractor-hours, with value type: long") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "contractor-hours",
            VALUE_TYPE.LONG)
end

@when("relation(employment) set relates role: employee") do context
    g.set_relates(context[:transaction],
        g.Label("","employment"),
                "employee")
end

@when("relation(employment) set relates role: employer") do context
    g.set_relates(context[:transaction],
        g.Label("","employment"),
                "employer")
end

@when("relation(employment) set owns key type: employment-reference") do context
    g.con.entity_set_owns(g.RelationType ,"employment", "employment-reference", context[:transaction], true)
end

@when("relation(employment) set owns attribute type: employment-hours") do context
    g.con.entity_set_owns(g.RelationType ,"employment", "employment-hours", context[:transaction], false)
end

@when("put relation type: contractor-employment") do context
    g.put(ConceptManager(context[:transaction]),
            RelationType,
            "contractor-employment")
end

@when("relation(contractor-employment) set supertype: employment") do context
    _set_supertype_for_type(context, RelationType, "contractor-employment", "employment")
end

@when("relation(contractor-employment) set owns key type: contractor-reference") do context
    g.con.entity_set_owns(g.RelationType ,"contractor-employment", "contractor-reference", context[:transaction], true)
end

@when("relation(contractor-employment) set owns attribute type: contractor-hours") do context
    g.con.entity_set_owns(g.RelationType ,"contractor-employment", "contractor-hours", context[:transaction], false)
end

@then("relation(contractor-employment) get owns key types contain:") do context
    res = _get_owns_contain(context, RelationType, "contractor-employment", true)
    @expect all(res) === true
end

@then("relation(contractor-employment) get owns attribute types contain:") do context
    res = _get_owns_contain(context, RelationType, "contractor-employment", false)
    @expect all(res) === true
end

@when("put attribute type: parttime-reference, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "parttime-reference",
            VALUE_TYPE.STRING)
end

@when("put attribute type: parttime-hours, with value type: long") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "parttime-hours",
            VALUE_TYPE.LONG)
end

@when("put relation type: parttime-employment") do context
    g.put(context[:cm], RelationType, "parttime-employment")
end

@when("relation(parttime-employment) set supertype: contractor-employment") do context
    _set_supertype_for_type(context, RelationType, "parttime-employment", "contractor-employment")
end

@when("relation(parttime-employment) set owns key type: parttime-reference") do context
    g.con.entity_set_owns(g.RelationType ,"parttime-employment", "parttime-reference", context[:transaction], true)
end

@when("relation(parttime-employment) set owns attribute type: parttime-hours") do context
    g.con.entity_set_owns(g.RelationType ,"parttime-employment", "parttime-hours", context[:transaction], false)
end

@then("relation(parttime-employment) get owns key types contain:") do context
    res = _get_owns_contain(context, RelationType, "parttime-employment", true)
    @expect all(res) === true
end

@then("relation(parttime-employment) get owns attribute types contain:") do context
    res = _get_owns_contain(context, RelationType, "parttime-employment", false)
    @expect all(res) === true
end

# Scenario: Relation types can inherit keys and attributes that are subtypes of each other
@when("attribute(employment-reference) set abstract: true") do context
    attr = g.get(context[:cm], AttributeType, "employment-reference")
    g.set_abstract(g.as_remote(attr, context[:transaction]))
end

@when("attribute(employment-hours) set abstract: true") do context
    attr = g.get(context[:cm], AttributeType, "employment-hours")
    g.set_abstract(g.as_remote(attr, context[:transaction]))
end

@when("attribute(contractor-reference) set abstract: true") do context
    attr = g.get(context[:cm], AttributeType, "contractor-reference")
    g.set_abstract(g.as_remote(attr, context[:transaction]))
end

@when("attribute(contractor-reference) set supertype: employment-reference") do context
    _set_supertype_for_type(context, AttributeType, "contractor-reference", "employment-reference")
end

@when("attribute(contractor-hours) set abstract: true") do context
    attr = g.get(context[:cm], AttributeType, "contractor-hours")
    g.set_abstract(g.as_remote(attr, context[:transaction]))
end

@when("attribute(contractor-hours) set supertype: employment-hours") do context
    _set_supertype_for_type(context, AttributeType, "contractor-hours", "employment-hours")
end

@when("relation(employment) set abstract: true") do context
    attr = g.get(context[:cm], RelationType, "employment")
    g.set_abstract(g.as_remote(attr, context[:transaction]))
end

@when("relation(contractor-employment) set abstract: true") do context
    attr = g.get(context[:cm], RelationType, "contractor-employment")
    g.set_abstract(g.as_remote(attr, context[:transaction]))
end

@when("attribute(parttime-reference) set supertype: contractor-reference") do context
    _set_supertype_for_type(context, AttributeType, "parttime-reference", "contractor-reference")
end

@when("attribute(parttime-hours) set supertype: contractor-hours") do context
    _set_supertype_for_type(context, AttributeType, "parttime-hours", "contractor-hours")
end

@when("relation(parttime-employment) set abstract: true") do context
    attr = g.get(context[:cm], RelationType, "parttime-employment")
    g.set_abstract(g.as_remote(attr, context[:transaction]))
end

# Scenario: Relation types can override inherited keys and attributes
@when("relation(contractor-employment) set owns key type: contractor-reference as employment-reference") do context
    g.con.entity_set_owns(g.RelationType ,
            "contractor-employment",
            "contractor-reference",
            context[:transaction],
            true,
            "employment-reference")
end

@when("relation(contractor-employment) set owns attribute type: contractor-hours as employment-hours") do context
    g.con.entity_set_owns(g.RelationType ,
            "contractor-employment",
            "contractor-hours",
            context[:transaction],
            false,
            "employment-hours")
end

@then("relation(contractor-employment) get owns key types do not contain:") do context
    res = _get_owns_contain(context, RelationType, "contractor-employment", true)
    @expect all(res) === false
end

@then("relation(contractor-employment) get owns attribute types do not contain:") do context
    res = _get_owns_contain(context, RelationType, "contractor-employment", false)
    @expect all(res) === false
end

@when("relation(parttime-employment) set relates role: parttime-employer as employer") do context
    g.set_relates(context[:transaction],
        g.Label("","parttime-employment"),
                "parttime-employer",
                "employer")
end

@when("relation(parttime-employment) set relates role: parttime-employee as employee") do context
    g.set_relates(context[:transaction],
        g.Label("","parttime-employment"),
                "parttime-employee",
                "employee")
end

@when("relation(parttime-employment) set owns key type: parttime-reference as contractor-reference") do context
    g.con.entity_set_owns(g.RelationType ,
            "parttime-employment",
            "parttime-reference",
            context[:transaction],
            true,
            "contractor-reference")
end

@when("relation(parttime-employment) set owns attribute type: parttime-hours as contractor-hours") do context
    g.con.entity_set_owns(g.RelationType ,
            "parttime-employment",
            "parttime-hours",
            context[:transaction],
            false,
            "contractor-hours")
end

@then("relation(parttime-employment) get owns key types do not contain:") do context
    res = _get_owns_contain(context, RelationType, "parttime-employment", true)
    @expect all(res) === false
end

# Scenario: Relation types can override inherited attributes as keys
@when("relation(employment) set owns attribute type: employment-reference") do context
    g.con.entity_set_owns(g.RelationType ,
            "employment",
            "employment-reference",
            context[:transaction],
            false)
end

@when("relation(contractor-employment) set relates role: contractor-employer as employer") do context
    g.set_relates(context[:transaction],
        g.Label("","contractor-employment"),
                "contractor-employer",
                "employer")
end

@when("relation(contractor-employment) set relates role: contractor-employee as employee") do context
    g.set_relates(context[:transaction],
        g.Label("","contractor-employment"),
                "contractor-employee",
                "employee")
end

# Scenario: Relation types can redeclare keys as attributes
@when("relation(marriage) set owns key type: date") do context
    g.con.entity_set_owns(g.RelationType , "marriage", "date", context[:transaction], true)
end

@then("relation(marriage) set owns attribute type: license") do context
    g.con.entity_set_owns(g.RelationType , "marriage", "license", context[:transaction], false)
end

# Scenario: Relation types cannot redeclare inherited keys and attributes
@then("relation(contractor-employment) set owns key type: employment-reference; throws exception") do context
    try
        g.con.entity_set_owns(g.RelationType ,
                "contractor-employment",
                "employment-reference",
                context[:transaction],
                true)
    catch ex
        @expect ex !== nothing
    end
end

@then("relation(contractor-employment) set owns attribute type: employment-hours; throws exception") do context
    try
        g.con.entity_set_owns(g.RelationType ,
                "contractor-employment",
                "employment-hours",
                context[:transaction],
                false)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Relation types cannot redeclare inherited key attribute types
@then("relation(parttime-employment) set owns key type: employment-reference; throws exception") do context
    try
        g.con.entity_set_owns(g.RelationType ,
                "parttime-employment",
                "employment-reference",
                context[:transaction],
                true)
    catch ex
        @expect ex !== nothing
    end
end

@then("relation(parttime-employment) set owns key type: contractor-reference; throws exception") do context
    try
        g.con.entity_set_owns(g.RelationType ,
                "parttime-employment",
                "contractor-reference",
                context[:transaction],
                true)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Relation types cannot redeclare inherited owns attribute types
@then("relation(parttime-employment) set owns attribute type: employment-hours; throws exception") do context
    try
        g.con.entity_set_owns(g.RelationType ,
                "parttime-employment",
                "employment-hours",
                context[:transaction],
                false)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Relation types cannot redeclare overridden owns attribute types
@then("relation(parttime-employment) set owns attribute type: contractor-hours; throws exception") do context
    try
        g.con.entity_set_owns(g.RelationType ,
                "parttime-employment",
                "contractor-hours",
                context[:transaction],
                false)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Relation types cannot override declared keys and attributes
@when("put attribute type: social-security-number, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "social-security-number",
            VALUE_TYPE.STRING)
end

@when("attribute(social-security-number) set supertype: reference") do context
    _set_supertype_for_type(context, AttributeType, "social-security-number", "reference")
end

@when("put attribute type: hours, with value type: long") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "hours",
            VALUE_TYPE.LONG)
end

@when("attribute(hours) set abstract: true") do context
    res = g.get(ConceptManager(context[:transaction]),
                AttributeType,
                "hours")
    g.set_abstract(g.as_remote(res, context[:transaction]))
end

@when("put attribute type: max-hours, with value type: long") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "max-hours",
            VALUE_TYPE.LONG)
end

@when("attribute(max-hours) set supertype: hours") do context
    _set_supertype_for_type(context, AttributeType, "max-hours", "hours")
end

@when("relation(employment) set owns attribute type: hours") do context
    g.con.entity_set_owns(g.RelationType ,"employment", "hours", context[:transaction], false)
end

@then("relation(employment) set owns key type: social-security-number as reference; throws exception") do context
    try
        g.con.entity_set_owns(g.RelationType ,
                "employment",
                "social-security-number",
                context[:transaction],
                false)
    catch ex
        @expect ex !== nothing
    end
end

@then("relation(employment) set owns attribute type: max-hours as hours; throws exception") do context
    try
        g.con.entity_set_owns(g.RelationType ,
                "employment",
                "max-hours",
                context[:transaction],
                false,
                "hours")
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Relation types cannot override inherited keys as attributes
@then("relation(contractor-employment) set owns attribute type: contractor-reference as employment-reference; throws exception") do context
    try
        g.con.entity_set_owns(g.RelationType ,
                "contractor-employment",
                "contractor-reference",
                context[:transaction],
                false,
                "employment-reference")
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Relation types cannot override inherited keys and attributes other than with their subtypes
@then("relation(contractor-employment) set owns key type: contractor-reference as employment-reference; throws exception") do context
    try
        g.con.entity_set_owns(g.RelationType ,
                "contractor-employment",
                "contractor-reference",
                context[:transaction],
                true,
                "employment-reference")
    catch ex
        @expect ex !== nothing
    end
end

@then("relation(contractor-employment) set owns attribute type: contractor-hours as employment-hours; throws exception") do context
    try
        g.con.entity_set_owns(g.RelationType ,
                "contractor-employment",
                "contractor-hours",
                context[:transaction],
                true,
                "employment-hours")
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Relation types can play role types
@when("put relation type: locates") do  context
    g.put(context[:cm], RelationType, "locates")
end

@when("relation(locates) set relates role: location") do context
    g.set_relates(context[:transaction],
        g.Label("","locates"),
                "location")
end

@when("relation(locates) set relates role: located") do context
    g.set_relates(context[:transaction],
        g.Label("","locates"),
                "located")
end

# Scenario: Relation types can unset playing role types
@then("relation(marriage) unset plays role: locates:located") do context
    role = RoleType(g.Label("locates","located"), false)
    attr = g.get(ConceptManager(context[:transaction]),
                    RelationType,
                    "marriage")

    g.unset_plays(g.as_remote(attr, context[:transaction]),role)
end

@then("relation(marriage) get playing roles do not contain:") do context
    res = _get_playing_roles_contain("marriage", RelationType, context)
    @expect all(res) === false
end

@when("relation(marriage) unset plays role: organises:organised") do context
    role = RoleType(g.Label("organises","organised"), false)
    attr = g.get(context[:cm], RelationType, "marriage")

    g.unset_plays(g.as_remote(attr, context[:transaction]),role)
end

# Scenario: Relation types can inherit playing role types
@when("relation(locates) set relates role: locating") do context
    g.set_relates(context[:transaction],
        g.Label("","locates"),
                "locating")
end

@when("put relation type: contractor-locates") do context
    g.put(ConceptManager(context[:transaction]),
            RelationType,
            "contractor-locates")
end

@when("relation(contractor-locates) set relates role: contractor-locating") do context
    g.set_relates(context[:transaction],
        g.Label("","contractor-locates"),
                "contractor-locating")
end

@when("relation(contractor-locates) set relates role: contractor-located") do context
    g.set_relates(context[:transaction],
        g.Label("","contractor-locates"),
                "contractor-located")
end

@when("relation(employment) set plays role: locates:located") do context
    ent_pers = g.get(context[:cm], RelationType, "employment")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]), g.RoleType(g.Label("locates", "located"),false))
end

@when("relation(contractor-employment) set plays role: contractor-locates:contractor-located") do context
    ent_pers = g.get(context[:cm], RelationType, "contractor-employment")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]),
                    g.RoleType(g.Label("contractor-locates",
                            "contractor-located"),
                            false))
end

@then("relation(contractor-employment) get playing roles contain:") do context
    res = _get_playing_roles_contain("contractor-employment", RelationType, context)
    @expect all(res) === true
end

@when("put relation type: parttime-locates") do context
    g.put(ConceptManager(context[:transaction]),
            RelationType,
            "parttime-locates")
end

@when("relation(parttime-locates) set relates role: parttime-locating") do context
    g.set_relates(context[:transaction],
        g.Label("","parttime-locates"),
                "parttime-locating")
end

@when("relation(parttime-locates) set relates role: parttime-located") do context
    g.set_relates(context[:transaction],
        g.Label("","parttime-locates"),
                "parttime-located")
end

@when("relation(parttime-employment) set relates role: parttime-employer") do context
    g.set_relates(context[:transaction],
        g.Label("","parttime-employment"),
                "parttime-employer")
end

@when("relation(parttime-employment) set relates role: parttime-employee") do context
    g.set_relates(context[:transaction],
        g.Label("","parttime-employment"),
                "parttime-employee")
end

@when("relation(parttime-employment) set plays role: parttime-locates:parttime-located") do context
    ent_pers = g.get(context[:cm], RelationType, "parttime-employment")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]),
                            g.RoleType(g.Label("parttime-locates"
                                    , "parttime-located"),false))
end

@then("relation(parttime-employment) get playing roles contain:") do context
    res = _get_playing_roles_contain("parttime-employment", RelationType, context)
    @expect all(res) === true
end

@when("relation(contractor-locates) set supertype: locates") do context
    _set_supertype_for_type(context, RelationType, "contractor-locates", "locates")
end

@when("relation(contractor-locates) set relates role: contractor-locating as locating") do context
    g.set_relates(context[:transaction],
        g.Label("","contractor-locates"),
                "contractor-locating")
end

@when("relation(contractor-locates) set relates role: contractor-located as located") do context
    g.set_relates(context[:transaction],
        g.Label("","contractor-locates"),
                "contractor-located",
                "located")
end

@when("relation(parttime-locates) set supertype: contractor-locates") do context
    _set_supertype_for_type(context, RelationType, "parttime-locates", "contractor-locates")
end

@when("relation(parttime-locates) set relates role: parttime-locating as contractor-locating") do context
    g.set_relates(context[:transaction],
        g.Label("","parttime-locates"),
                "parttime-locating",
                "contractor-locating")
end

@when("relation(parttime-locates) set relates role: parttime-located as contractor-located") do context
    g.set_relates(context[:transaction],
        g.Label("","parttime-locates"),
                "parttime-located",
                "contractor-located")
end

# Scenario: Relation types can override inherited playing role types
@when("relation(contractor-employment) set plays role: contractor-locates:contractor-located as locates:located") do context
    ent_pers = g.get(context[:cm], RelationType, "contractor-employment")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]),
                    g.RoleType(g.Label("contractor-locates",
                            "contractor-located"),
                            false),
                    g.RoleType(g.Label("locates",
                            "located")
                            ,false))
end

@then("relation(contractor-employment) get playing roles do not contain:") do context
    res = _get_playing_roles_contain("contractor-employment", RelationType, context)
    @expect all(res) === false
end

@when("relation(parttime-employment) set plays role: parttime-locates:parttime-located as contractor-locates:contractor-located") do context
    ent_pers = g.get(context[:cm], RelationType, "parttime-employment")
    g.set_plays(g.as_remote(ent_pers, context[:transaction]),
                    g.RoleType(g.Label("parttime-locates",
                            "parttime-located"),
                            false),
                    g.RoleType(g.Label("contractor-locates",
                            "contractor-located")
                            ,false))
end

@then("relation(parttime-employment) get playing roles do not contain:") do context
    res = _get_playing_roles_contain("parttime-employment", RelationType, context)
    @expect all(res) === false
end

@when("relation(parttime-employment) set plays role: locates:located; throws exception") do context
    ent_pers = g.get(context[:cm], RelationType, "parttime-employment")
    try
        g.set_plays(g.as_remote(ent_pers, context[:transaction]),
                        g.RoleType(g.Label("locates",
                                "located"),
                                false))
    catch ex
        @expect ex !== nothing
    end
end

@when("relation(parttime-employment) set plays role: contractor-locates:contractor-located; throws exception") do context
    ent_pers = g.get(context[:cm], RelationType, "parttime-employment")
    try
        g.set_plays(g.as_remote(ent_pers, context[:transaction]),
                        g.RoleType(g.Label("contractor-locates",
                                "contractor-located"),
                                false))
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Relation types cannot override declared playing role types
@when("put relation type: employment-locates") do context
    g.put(context[:cm], RelationType, "employment-locates")
end

@when("relation(employment-locates) set supertype: locates") do context
    _set_supertype_for_type(context, RelationType, "employment-locates", "locates")
end

@when("relation(employment-locates) set relates role: employment-locating as locating") do context
    g.set_relates(context[:transaction],
        g.Label("","employment-locates"),
                "employment-locating",
                "locating")
end

@when("relation(employment-locates) set relates role: employment-located as located") do context
    g.set_relates(context[:transaction],
        g.Label("","employment-locates"),
                "employment-located",
                "located")
end

@when("relation(employment) set plays role: employment-locates:employment-located as locates:located; throws exception") do context
    ent_pers = g.get(context[:cm], RelationType, "employment")
    try
        g.set_plays(g.as_remote(ent_pers, context[:transaction]),
                        g.RoleType(g.Label("employment-locates",
                                "employment-located"),
                                false),
                        g.RoleType(g.Label("locates",
                                "located"),
                                false))
    catch ex
        @expect ex !== nothing
    end
end

@when("relation(contractor-employment) set plays role: contractor-locates:contractor-located as locates:located; throws exception") do context
    ent_pers = g.get(context[:cm], RelationType, "contractor-employment")
    try
        g.set_plays(g.as_remote(ent_pers, context[:transaction]),
                        g.RoleType(g.Label("contractor-locates",
                                "contractor-located"),
                                false),
                        g.RoleType(g.Label("locates",
                                "located"),
                                false))
    catch ex
        @expect ex !== nothing
    end
end
