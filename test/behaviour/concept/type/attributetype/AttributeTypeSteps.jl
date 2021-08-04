# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE
using Dates: length
using Base: func_for_method_checked
# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

using Behavior
using TypeDBClient
using Dates

g = TypeDBClient

# Utility functions
function _attribute_subtypes(context, attribute_label_name, value_type::g.EnumType, contain::Bool)
    types_inp = [db[1] for db in context.datatable]
    result_bools = Bool[]

    attr = g.get(ConceptManager(context[:transaction]), AttributeType, attribute_label_name)
    sub_types = g.get_subtypes(g.as_remote(attr, context[:transaction]))
    res = filter(x->g.proto_value_type(x) == value_type ||
                    g.proto_value_type(x) == VALUE_TYPE.OBJECT, sub_types)

    for i in 1:length(types_inp)
        inp_type = g.get(ConceptManager(context[:transaction]), AttributeType, types_inp[i])
        in_types = contain ? in(inp_type, res) : !in(inp_type, res)
        push!(result_bools, in_types)
    end
    return result_bools
end

# Scenario: Attribute types can be created
@then("attribute(name) is null: false") do context
    context[:attr_name] = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    @expect context[:attr_name] !== nothing
end

@then("put attribute type: is-open, with value type: boolean") do context
    g.put(ConceptManager(context[:transaction]), AttributeType, "is-open", VALUE_TYPE.BOOLEAN)
end

@then("attribute(is-open) get value type: boolean") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "is-open")
    @expect attr.label.name == "is-open"
end

# Scenario: Attribute types can be created with value class long
@then("attribute(age) get value type: long") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "age")
    comparison = typeof(attr) == AttributeType{VALUE_TYPE.LONG}
    @expect comparison === true
end

# Scenario: Attribute types can be created with value class double
@when("put attribute type: rating, with value type: double") do context
    g.put(ConceptManager(context[:transaction]), AttributeType, "rating", VALUE_TYPE.DOUBLE)
end

@then("attribute(rating) get value type: double") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "rating")
    comparison = typeof(attr) == AttributeType{VALUE_TYPE.DOUBLE}
    @expect comparison === true
end

# Scenario: Attribute types can be created with value class string
@then("attribute(name) get value type: string") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    comparison = typeof(attr) == AttributeType{VALUE_TYPE.STRING}
    @expect comparison === true
end

# Scenario: Attribute types with value type string and regular expression can be created
@then("attribute(email) as(string) get regex: \\S+@\\S+\\.\\S+") do context
    attr_email = g.get(ConceptManager(context[:transaction]), AttributeType, "email")
    regex = g.get_regex(g.as_remote(attr_email, context[:transaction]))
    @expect regex == "\\S+@\\S+\\.\\S+"
end

# Scenario: Attribute types can be created with value class datetime
@then("put attribute type: timestamp, with value type: datetime") do context
    g.put(ConceptManager(context[:transaction]), AttributeType, "timestamp", VALUE_TYPE.DATETIME)
end

@then("attribute(timestamp) get value type: datetime") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "timestamp")
    comparison = typeof(attr) == AttributeType{VALUE_TYPE.DATETIME}
    @expect comparison === true
end

# Scenario: Attribute types can be deleted
@then("attribute(age) is null: false") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "age")
    @expect attr !== nothing
end

@when("delete attribute type: age") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "age")
    g.delete(g.as_remote(attr, context[:transaction]))
end

@then("attribute(age) is null: true") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "age")
    @expect attr === nothing
end

@then("attribute(attribute) get subtypes do not contain:") do context
    types_inp = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "attribute")
    sub_types = g.get_subtypes(g.as_remote(attr, context[:transaction]))
    for i in 1:length(types_inp)
        inp_type = attr = g.get(ConceptManager(context[:transaction]), AttributeType, types_inp[i])
        @expect !in(inp_type, sub_types)
    end
end

@when("delete attribute type: name") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    g.delete(g.as_remote(attr, context[:transaction]))
end

@then("attribute(name) is null: true") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    @expect attr === nothing
end

# Scenario: Attribute types that have instances cannot be deleted
@then("delete attribute type: name; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    try
        g.delete(g.as_remote(attr, context[:transaction]))
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Attribute types can change labels
@then("attribute(name) get label: name") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    @expect attr.label.name == "name"
end

@when("attribute(name) set label: username") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    g.set_label(g.as_remote(attr_name, context[:transaction]), "username")
end

@then("attribute(username) is null: false") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "username")
    @expect attr_name !== nothing
end

@then("attribute(username) get label: username") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "username")
    @expect attr_name.label.name == "username"
end

@then("attribute(username) set label: email") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "username")
    g.set_label(g.as_remote(attr_name, context[:transaction]), "email")
end

@then("attribute(username) is null: true") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "username")
    @expect attr_name === nothing
end

@then("attribute(email) is null: false") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "email")
    @expect attr_name !== nothing
end

@then("attribute(email) get label: email") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "email")
    @expect attr_name.label.name == "email"
end

# Scenario: Attribute types can be set to abstract
@then("attribute(name) set abstract: true") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    g.set_abstract(g.as_remote(attr_name, context[:transaction]))
end

@then("attribute(name) is abstract: true") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    res_abstract = g.is_abstract(g.as_remote(attr_name, context[:transaction]))
    @expect res_abstract === true
end

@then("attribute(name) as(string) put: alice; throws exception") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    try
        g.put(g.as_remote(attr_name, context[:transaction]), "alice")
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(email) is abstract: false") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "email")
    res_abstract = g.is_abstract(g.as_remote(attr_name, context[:transaction]))
    @expect res_abstract === false
end

@when("attribute(email) set abstract: true") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "email")
    res_abstract = g.set_abstract(g.as_remote(attr_name, context[:transaction]))
end

@then("attribute(email) is abstract: true") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "email")
    res_abstract = g.is_abstract(g.as_remote(attr_name, context[:transaction]))
    @expect res_abstract === true
end

@then("attribute(email) as(string) put: alice@email.com; throws exception") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "email")
    try
        g.put(g.as_remote(attr_name, context[:transaction]), "alice@email.com")
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Attribute types can be subtypes of other attribute types
@when("put attribute type: first-name, with value type: string") do context
    g.put(ConceptManager(context[:transaction]), AttributeType, "first-name", VALUE_TYPE.STRING)
end

@when("put attribute type: last-name, with value type: string") do context
    g.put(ConceptManager(context[:transaction]), AttributeType, "last-name", VALUE_TYPE.STRING)
end

@when("put attribute type: real-name, with value type: string") do context
    g.put(ConceptManager(context[:transaction]), AttributeType, "real-name", VALUE_TYPE.STRING)
end

@when("attribute(real-name) set abstract: true") do context
    attr_name = g.get(ConceptManager(context[:transaction]), AttributeType, "real-name")
    res_abstract = g.set_abstract(g.as_remote(attr_name, context[:transaction]))
end

@when("attribute(first-name) set supertype: real-name") do context
    attr_first_name = g.get(ConceptManager(context[:transaction]), AttributeType, "first-name")
    attr_real_name = g.get(ConceptManager(context[:transaction]), AttributeType, "real-name")
    g.set_supertype(g.as_remote(attr_first_name, context[:transaction]),
                    attr_real_name)
end

@when("attribute(last-name) set supertype: real-name") do context
    attr_first_name = g.get(ConceptManager(context[:transaction]), AttributeType, "last-name")
    attr_real_name = g.get(ConceptManager(context[:transaction]), AttributeType, "real-name")
    g.set_supertype(g.as_remote(attr_first_name, context[:transaction]),
                    attr_real_name)
end

@when("attribute(real-name) set supertype: name") do context
    attr_first_name = g.get(ConceptManager(context[:transaction]), AttributeType, "real-name")
    attr_real_name = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    g.set_supertype(g.as_remote(attr_first_name, context[:transaction]),
                    attr_real_name)
end

@when("attribute(username) set supertype: name") do context
    attr_first_name = g.get(ConceptManager(context[:transaction]), AttributeType, "username")
    attr_real_name = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    g.set_supertype(g.as_remote(attr_first_name, context[:transaction]),
                    attr_real_name)
end

@then("attribute(first-name) get supertype: real-name") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "first-name")
    super_type = g.get_supertype(g.as_remote(attr, context[:transaction]))
    @expect super_type.label.name == "real-name"
end

@then("attribute(last-name) get supertype: real-name") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "last-name")
    super_type = g.get_supertype(g.as_remote(attr, context[:transaction]))
    @expect super_type.label.name == "real-name"
end

@then("attribute(real-name) get supertype: name") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "real-name")
    super_type = g.get_supertype(g.as_remote(attr, context[:transaction]))
    @expect super_type.label.name == "name"
end

@then("attribute(username) get supertype: name") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "username")
    super_type = g.get_supertype(g.as_remote(attr, context[:transaction]))
    @expect super_type.label.name == "name"
end

@then("attribute(first-name) get supertypes contain:") do context
    super_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "first-name")
    res_types = g.get_supertypes(g.as_remote(attr, context[:transaction]))
    for attr in res_types
        @expect in(attr.label.name, super_types)
    end
end

@then("attribute(last-name) get supertypes contain:") do context
    super_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "last-name")
    res_types = g.get_supertypes(g.as_remote(attr, context[:transaction]))
    for attr in res_types
        @expect in(attr.label.name, super_types)
    end
end

@then("attribute(real-name) get supertypes contain:") do context
    super_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "real-name")
    res_types = g.get_supertypes(g.as_remote(attr, context[:transaction]))
    for attr in res_types
        @expect in(attr.label.name, super_types)
    end
end

@then("attribute(username) get supertypes contain:") do context
    super_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "username")
    res_types = g.get_supertypes(g.as_remote(attr, context[:transaction]))
    for attr in res_types
        @expect in(attr.label.name, super_types)
    end
end

@then("attribute(first-name) get subtypes contain:") do context
    super_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "first-name")
    res_types = g.get_subtypes(g.as_remote(attr, context[:transaction]))
    for attr in res_types
        @expect in(attr.label.name, super_types)
    end
end

@then("attribute(last-name) get subtypes contain:") do context
    super_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "last-name")
    res_types = g.get_subtypes(g.as_remote(attr, context[:transaction]))
    for attr in res_types
        @expect in(attr.label.name, super_types)
    end
end

@then("attribute(real-name) get subtypes contain:") do context
    super_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "real-name")
    res_types = g.get_subtypes(g.as_remote(attr, context[:transaction]))
    for attr in res_types
        @expect in(attr.label.name, super_types)
    end
end

@then("attribute(username) get subtypes contain:") do context
    super_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "username")
    res_types = g.get_subtypes(g.as_remote(attr, context[:transaction]))
    for attr in res_types
        @expect in(attr.label.name, super_types)
    end
end

@then("attribute(name) get subtypes contain:") do context
    super_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    res_types = g.get_subtypes(g.as_remote(attr, context[:transaction]))
    for attr in res_types
        @expect in(attr.label.name, super_types)
    end
end

@then("attribute(attribute) get subtypes contain:") do context
    super_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "attribute")
    res_types = g.get_subtypes(g.as_remote(attr, context[:transaction]))
    for attr in res_types
        @expect in(attr.label.name, super_types)
    end
end

@then("attribute(is-open) set supertype: is-open; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "is-open")
    try
        g.set_supertype(g.as_remote(attr, trans), attr)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(age) set supertype: age; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "age")
    try
        g.set_supertype(g.as_remote(attr, trans), attr)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(rating) set supertype: rating; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "rating")
    try
        g.set_supertype(g.as_remote(attr, trans), attr)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(name) set supertype: name; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    try
        g.set_supertype(g.as_remote(attr, trans), attr)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(timestamp) set supertype: timestamp; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "time-stamp")
    try
        g.set_supertype(g.as_remote(attr, trans), attr)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Attribute types cannot subtype non abstract attribute types
@then("attribute(first-name) set supertype: name; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "first-name")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(last-name) set supertype: name; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "last-name")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(is-open) set supertype: age; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "is-open")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "age")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(is-open) set supertype: rating; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "is-open")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "rating")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(is-open) set supertype: name; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "is-open")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(is-open) set supertype: timestamp; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "last-name")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "timestamp")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(age) set supertype: is-open; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "age")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "is-open")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(age) set supertype: rating; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "age")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "rating")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(age) set supertype: name; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "age")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(age) set supertype: timestamp; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "age")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "timestamp")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(rating) set supertype: is-open; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "rating")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "is.open")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(rating) set supertype: age; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "rating")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "age")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(rating) set supertype: name; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "rating")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(rating) set supertype: timestamp; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "rating")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "timestamp")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(name) set supertype: is-open; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "is-open")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(name) set supertype: age; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "age")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(name) set supertype: rating; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "rating")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(name) set supertype: timestamp; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "timestamp")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(timestamp) set supertype: is-open; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "timestamp")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "is-open")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(timestamp) set supertype: age; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "timestamp")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "age")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(timestamp) set supertype: rating; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "timestamp")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "rating")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

@then("attribute(timestamp) set supertype: name; throws exception") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "timestamp")
    attr_super = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    try
        g.set_supertype(g.as_remote(attr, trans), attr_super)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: Attribute types can get the root type
@then("attribute(is-open) get supertype: attribute") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "timestamp")
    attr_super = g.get_supertype(g.as_remote(attr, context[:transaction]))
    @expect attr_super.label.name == "attribute"
end

@then("attribute(age) get supertype: attribute") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "age")
    attr_super = g.get_supertype(g.as_remote(attr, context[:transaction]))
    @expect attr_super.label.name == "attribute"
end

@then("attribute(rating) get supertype: attribute") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "rating")
    attr_super = g.get_supertype(g.as_remote(attr, context[:transaction]))
    @expect attr_super.label.name == "attribute"
end

@then("attribute(timestamp) get supertype: attribute") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "timestamp")
    attr_super = g.get_supertype(g.as_remote(attr, context[:transaction]))
    @expect attr_super.label.name == "attribute"
end

@then("attribute(name) get supertype: attribute") do context
    attr = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    attr_super = g.get_supertype(g.as_remote(attr, context[:transaction]))
    @expect attr_super.label.name == "attribute"
end

# Scenario: Attribute type root can get attribute types of a specific value class
@then("attribute(attribute) as(boolean) get subtypes contain:") do context
    res = _attribute_subtypes(context, "attribute", VALUE_TYPE.BOOLEAN, true)
    @expect length(context.datatable) == length(res)
    @expect all(res) === true
end

@then("attribute(attribute) as(boolean) get subtypes do not contain:") do context
    res = _attribute_subtypes(context, "attribute", VALUE_TYPE.BOOLEAN, false)
    @expect length(context.datatable) == length(res)
    @expect all(res) === true
end

@then("attribute(attribute) as(long) get subtypes contain:") do context
    res = _attribute_subtypes(context, "attribute", VALUE_TYPE.LONG, true)
    @expect length(context.datatable) == length(res)
    @expect all(res) === true
end

@then("attribute(attribute) as(long) get subtypes do not contain:") do context
    res = _attribute_subtypes(context, "attribute", VALUE_TYPE.LONG, false)
    @expect length(context.datatable) == length(res)
    @expect all(res) === true
end

@then("attribute(attribute) as(double) get subtypes contain:") do context
    res = _attribute_subtypes(context, "attribute", VALUE_TYPE.DOUBLE, true)
    @expect length(context.datatable) == length(res)
    @expect all(res) === true
end

@then("attribute(attribute) as(double) get subtypes do not contain:") do context
    res = _attribute_subtypes(context, "attribute", VALUE_TYPE.DOUBLE, false)
    @expect length(context.datatable) == length(res)
    @expect all(res) === true
end

@then("attribute(attribute) as(string) get subtypes contain:") do context
    res = _attribute_subtypes(context, "attribute", VALUE_TYPE.STRING, true)
    @expect length(context.datatable) == length(res)
    @expect all(res) === true
end

@then("attribute(attribute) as(string) get subtypes do not contain:") do context
    res = _attribute_subtypes(context, "attribute", VALUE_TYPE.STRING, false)
    @expect length(context.datatable) == length(res)
    @expect all(res) === true
end

@then("attribute(attribute) as(datetime) get subtypes contain:") do context
    res = _attribute_subtypes(context, "attribute", VALUE_TYPE.DATETIME, true)
    @expect length(context.datatable) == length(res)
    @expect all(res) === true
end

@then("attribute(attribute) as(datetime) get subtypes do not contain:") do context
    res = _attribute_subtypes(context, "attribute", VALUE_TYPE.DATETIME, false)
    @expect length(context.datatable) == length(res)
    @expect all(res) === true
end

# Scenario: Attribute types can have keys
@when("put attribute type: country-code, with value type: string") do context
    g.put(ConceptManager(context[:transaction]), AttributeType, "country-code", VALUE_TYPE.STRING)
end

@when("put attribute type: country-name, with value type: string") do context
    g.put(ConceptManager(context[:transaction]), AttributeType, "country-name", VALUE_TYPE.STRING)
end

@when("attribute(country-name) set owns key type: country-code") do context
    attr_country = g.get(ConceptManager(context[:transaction]), AttributeType, "country-name")
    attr_country_name = g.get(ConceptManager(context[:transaction]), AttributeType, "country-code")
    g.set_owns(g.as_remote(attr_country, context[:transaction]),
                attr_country_name,
                true)
end

@then("attribute(country-name) get owns key types contain:") do context
    key_types = [db[1] for db in context.datatable]
    attr_country_name = g.get(ConceptManager(context[:transaction]), AttributeType, "country-name")
    types_owns = g.get_owns(g.as_remote(attr_country_name, context[:transaction]),
                                nothing,
                                true)
    for i in 1:length(key_types)
        key_type = g.get(ConceptManager(context[:transaction]),
                          AttributeType,
                          key_types[i])
        @expect in(key_type, types_owns) === true
    end
end

# Scenario: Attribute types can unset keys
@when("put attribute type: country-code-1, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "country-code-1",
            VALUE_TYPE.STRING)
end

@when("put attribute type: country-code-2, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "country-code-2",
            VALUE_TYPE.STRING)
end

@when("attribute(country-name) set owns key type: country-code-1") do context
    attr_country = g.get(ConceptManager(context[:transaction]), AttributeType, "country-name")
    attr_country_name = g.get(ConceptManager(context[:transaction]), AttributeType, "country-code-1")
    g.set_owns(g.as_remote(attr_country, context[:transaction]),
                attr_country_name,
                true)
end

@when("attribute(country-name) set owns key type: country-code-2") do context
    attr_country = g.get(ConceptManager(context[:transaction]), AttributeType, "country-name")
    attr_country_name = g.get(ConceptManager(context[:transaction]), AttributeType, "country-code-2")
    g.set_owns(g.as_remote(attr_country, context[:transaction]),
                attr_country_name,
                true)
end

@when("attribute(country-name) unset owns key type: country-code-1") do context
    attr_country_name = g.get(ConceptManager(context[:transaction]), AttributeType, "country-name")
    attr_country_code = g.get(ConceptManager(context[:transaction]), AttributeType, "country-code-1")
    g.unset_owns(g.as_remote(attr_country_name, context[:transaction]),
                    attr_country_code)
end

@then("attribute(country-name) get owns key types do not contain:") do context
    key_types = [db[1] for db in context.datatable]
    attr_country_name = g.get(ConceptManager(context[:transaction]), AttributeType, "country-name")
    types_owns = g.get_owns(g.as_remote(attr_country_name, context[:transaction]),
                                nothing,
                                true)
    for i in 1:length(key_types)
        key_type = g.get(ConceptManager(context[:transaction]),
                          AttributeType,
                          key_types[i])
        @expect !in(key_type, types_owns) === true
    end
end

@when("attribute(country-name) unset owns key type: country-code-2") do context
    attr_country_name = g.get(ConceptManager(context[:transaction]), AttributeType, "country-name")
    attr_country_code = g.get(ConceptManager(context[:transaction]), AttributeType, "country-code-2")
    g.unset_owns(g.as_remote(attr_country_name, context[:transaction]),
                    attr_country_code)
end

# Scenario: Attribute types can have attributes
@when("put attribute type: utc-zone-code, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "utc-zone-code",
            VALUE_TYPE.STRING)
end

@when("put attribute type: utc-zone-hour, with value type: double") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "utc-zone-hour",
            VALUE_TYPE.DOUBLE)
end

@when("attribute(timestamp) set owns attribute type: utc-zone-code") do context
    attr_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "timestamp")
    attr_is_owned = g.get(ConceptManager(context[:transaction]), AttributeType, "utc-zone-code")
    g.set_owns(g.as_remote(attr_owns, context[:transaction]),
                attr_is_owned,
                false)
end

@when("attribute(timestamp) set owns attribute type: utc-zone-hour") do context
    attr_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "timestamp")
    attr_is_owned = g.get(ConceptManager(context[:transaction]), AttributeType, "utc-zone-hour")
    g.set_owns(g.as_remote(attr_owns, context[:transaction]),
                attr_is_owned,
                false)
end

@then("attribute(timestamp) get owns attribute types contain:") do context
    key_types = [db[1] for db in context.datatable]
    attr_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "timestamp")
    types_owns = g.get_owns(g.as_remote(attr_owns, context[:transaction]),
                                nothing,
                                false)
    for i in 1:length(key_types)
        key_type = g.get(ConceptManager(context[:transaction]),
                          AttributeType,
                          key_types[i])
        @expect in(key_type, types_owns) === true
    end
end

# Scenario: Attribute types can unset attributes
@when("attribute(timestamp) unset owns attribute type: utc-zone-hour") do context
    attr_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "timestamp")
    attr_owned = g.get(ConceptManager(context[:transaction]), AttributeType, "utc-zone-hour")
    g.unset_owns(g.as_remote(attr_owns, context[:transaction]),
                    attr_owned)
end

@then("attribute(timestamp) get owns attribute types do not contain:") do context
    key_types = [db[1] for db in context.datatable]
    attr_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "timestamp")
    types_owns = g.get_owns(g.as_remote(attr_owns, context[:transaction]),
                                nothing,
                                true)
    for i in 1:length(key_types)
        key_type = g.get(ConceptManager(context[:transaction]),
                          AttributeType,
                          key_types[i])
        @expect !in(key_type, types_owns) === true
    end
end

@when("attribute(timestamp) unset owns attribute type: utc-zone-code") do context
    attr_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "timestamp")
    attr_owned = g.get(ConceptManager(context[:transaction]), AttributeType, "utc-zone-code")
    g.unset_owns(g.as_remote(attr_owns, context[:transaction]),
                    attr_owned)
end

# Scenario: Attribute types can have keys and attributes
@when("put attribute type: country-abbreviation, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "country-abbreviation",
            VALUE_TYPE.STRING)
end

@when("attribute(country-name) set owns attribute type: country-abbreviation") do context
    attr_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "country-name")
    attr_is_owned = g.get(ConceptManager(context[:transaction]), AttributeType, "country-abbreviation")
    g.set_owns(g.as_remote(attr_owns, context[:transaction]),
                attr_is_owned,
                false)
end

@then("attribute(country-name) get owns attribute types contain:") do context
    key_types = [db[1] for db in context.datatable]
    attr_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "country-name")
    types_owns = g.get_owns(g.as_remote(attr_owns, context[:transaction]),
                                nothing,
                                false)
    for i in 1:length(key_types)
        key_type = g.get(ConceptManager(context[:transaction]),
                          AttributeType,
                          key_types[i])
        @expect in(key_type, types_owns) === true
    end
end

# Scenario: Attribute types can inherit keys and attributes
@when("put attribute type: hash, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "hash",
            VALUE_TYPE.STRING)
end

@when("put attribute type: abbreviation, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "abbreviation",
            VALUE_TYPE.STRING)
end

@when("attribute(name) set owns key type: hash") do context
    attr_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    attr_is_owned = g.get(ConceptManager(context[:transaction]), AttributeType, "hash")
    g.set_owns(g.as_remote(attr_owns, context[:transaction]),
                attr_is_owned,
                true)
end

@when("attribute(name) set owns attribute type: abbreviation") do context
    attr_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    attr_is_owned = g.get(ConceptManager(context[:transaction]), AttributeType, "abbreviation")
    g.set_owns(g.as_remote(attr_owns, context[:transaction]),
                attr_is_owned,
                false)
end

@then("attribute(real-name) get owns key types contain:") do context
    key_types = [db[1] for db in context.datatable]
    attr_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "real-name")
    types_owns = g.get_owns(g.as_remote(attr_owns, context[:transaction]),
                                nothing,
                                true)
    for i in 1:length(key_types)
        key_type = g.get(ConceptManager(context[:transaction]),
                          AttributeType,
                          key_types[i])
        @expect in(key_type, types_owns) === true
    end
end

@then("attribute(real-name) get owns attribute types contain:") do context
    key_types = [db[1] for db in context.datatable]
    attr_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "real-name")
    types_owns = g.get_owns(g.as_remote(attr_owns, context[:transaction]),
                                nothing,
                                false)
    for i in 1:length(key_types)
        key_type = g.get(ConceptManager(context[:transaction]),
                          AttributeType,
                          key_types[i])
        @expect in(key_type, types_owns) === true
    end
end

@then("attribute(last-name) get owns key types contain:") do context
    key_types = [db[1] for db in context.datatable]
    attr_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "last-name")
    types_owns = g.get_owns(g.as_remote(attr_owns, context[:transaction]),
                                nothing,
                                true)
    for i in 1:length(key_types)
        key_type = g.get(ConceptManager(context[:transaction]),
                          AttributeType,
                          key_types[i])
        @expect in(key_type, types_owns) === true
    end
end

@then("attribute(last-name) get owns attribute types contain:") do context
    key_types = [db[1] for db in context.datatable]
    attr_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "last-name")
    types_owns = g.get_owns(g.as_remote(attr_owns, context[:transaction]),
                                nothing,
                                false)
    for i in 1:length(key_types)
        key_type = g.get(ConceptManager(context[:transaction]),
                          AttributeType,
                          key_types[i])
        @expect in(key_type, types_owns) === true
    end
end

# Scenario: Attribute types can be owned as attributes
@when("put attribute type: boy-name, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "boy-name",
            VALUE_TYPE.STRING)
end

@when("attribute(boy-name) set supertype: name") do context
    type = g.get(ConceptManager(context[:transaction]),
                    AttributeType,
                    "boy-name")
    super_type = g.get(ConceptManager(context[:transaction]),
                        AttributeType,
                        "name")
    g.set_supertype(g.as_remote(type, context[:transaction]),
                    super_type)
end

@when("put attribute type: girl-name, with value type: string") do context
    g.put(ConceptManager(context[:transaction]),
            AttributeType,
            "girl-name",
            VALUE_TYPE.STRING)
end

@when("attribute(girl-name) set supertype: name") do context
    type = g.get(ConceptManager(context[:transaction]),
                    AttributeType,
                    "girl-name")
    super_type = g.get(ConceptManager(context[:transaction]),
                        AttributeType,
                        "name")
    g.set_supertype(g.as_remote(type, context[:transaction]),
                    super_type)
end

@when("entity(person) set abstract: true") do context
    entity_to_abstract = g.get(ConceptManager(context[:transaction]),
                                                EntityType,
                                                "person")
    g.set_abstract(g.as_remote(entity_to_abstract, context[:transaction]))
end

@when("put entity type: boy") do context
    g.put(ConceptManager(context[:transaction]),
            EntityType,
            "boy")
end

@when("entity(boy) set supertype: person") do context
    type = g.get(ConceptManager(context[:transaction]),
                    EntityType,
                    "boy")
    super_type = g.get(ConceptManager(context[:transaction]),
                        EntityType,
                        "person")
    g.set_supertype(g.as_remote(type, context[:transaction]),
                    super_type)
end

@when("entity(boy) set owns attribute type: boy-name as name") do context
    entity_owns = g.get(ConceptManager(context[:transaction]), EntityType, "boy")
    attr_set_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "boy-name")
    attr_overriden = g.get(ConceptManager(context[:transaction]), AttributeType, "name")

    g.set_owns(g.as_remote(entity_owns, context[:transaction]),
                attr_set_owns,
                false,
                attr_overriden)
end

@when("put entity type: girl") do context
    g.put(ConceptManager(context[:transaction]),
            EntityType,
            "girl")
end

@when("entity(girl) set supertype: person") do context
    type = g.get(ConceptManager(context[:transaction]),
                    EntityType,
                    "girl")
    super_type = g.get(ConceptManager(context[:transaction]),
                        EntityType,
                        "person")
    g.set_supertype(g.as_remote(type, context[:transaction]),
                    super_type)
end

@when("entity(girl) set owns attribute type: girl-name as name") do context
    entity_owns = g.get(ConceptManager(context[:transaction]), EntityType, "girl")
    attr_set_owns = g.get(ConceptManager(context[:transaction]), AttributeType, "girl-name")
    attr_overriden = g.get(ConceptManager(context[:transaction]), AttributeType, "name")

    g.set_owns(g.as_remote(entity_owns, context[:transaction]),
                attr_set_owns,
                false,
                attr_overriden)
end

@then("attribute(age) get attribute owners contain:") do context
    contain_owners = [db[1] for db in context.datatable]
    attr_owner = g.get(ConceptManager(context[:transaction]),
                        AttributeType,
                        "age")
    owners = g.get_owners(g.as_remote(attr_owner, context[:transaction]))

    for i in length(contain_owners)
        owner = g.get(ConceptManager(context[:transaction]),
                        EntityType,
                        contain_owners[i])
        @expect in(owner, owners)
    end
end

@then("attribute(name) get attribute owners contain:") do context
    contain_owners = [db[1] for db in context.datatable]
    attr_owner = g.get(ConceptManager(context[:transaction]),
                        AttributeType,
                        "name")
    owners = g.get_owners(g.as_remote(attr_owner, context[:transaction]))
    for i in length(contain_owners)
        owner = g.get(ConceptManager(context[:transaction]),
                        ThingType,
                        contain_owners[i])
        @expect in(owner, owners)
    end
end

@then("attribute(name) get attribute owners do not contain:") do context
    contain_owners = [db[1] for db in context.datatable]
    attr_owner = g.get(ConceptManager(context[:transaction]),
                        AttributeType,
                        "name")
    owners = g.get_owners(g.as_remote(attr_owner, context[:transaction]))
    for i in length(contain_owners)
        owner = g.get(ConceptManager(context[:transaction]),
                        AttributeType,
                        contain_owners[i])
        @expect !in(owner, owners)
    end
end

# Scenario: Attribute types can be owned as keys
@when("put entity type: company") do context
    g.put(ConceptManager(context[:transaction]), EntityType, "company")
end

@when("entity(company) set owns attribute type: email") do context
    attr_owns = g.get(ConceptManager(context[:transaction]),
                            EntityType,
                            "company")
    attr_set_owns = g.get(ConceptManager(context[:transaction]),
                        AttributeType,
                        "email")
    g.set_owns(g.as_remote(attr_owns, context[:transaction]), attr_set_owns, false)
end

@when("entity(person) set owns key type: email") do context
    attr_owns = g.get(ConceptManager(context[:transaction]),
                            EntityType,
                            "person")
    attr_set_owns = g.get(ConceptManager(context[:transaction]),
                        AttributeType,
                        "email")
    g.set_owns(g.as_remote(attr_owns, context[:transaction]), attr_set_owns, true)
end

@then("attribute(email) get attribute owners contain:") do context
    contain_owners = [db[1] for db in context.datatable]
    attr_owner = g.get(ConceptManager(context[:transaction]),
                        AttributeType,
                        "email")
    owners = g.get_owners(g.as_remote(attr_owner, context[:transaction]))

    for i in length(contain_owners)
        owner = g.get(ConceptManager(context[:transaction]),
                        EntityType,
                        contain_owners[i])
        @expect in(owner, owners)
    end
end

@then("attribute(email) get key owners contain:") do context
    contain_owners = [db[1] for db in context.datatable]
    attr_owner = g.get(ConceptManager(context[:transaction]),
                        AttributeType,
                        "email")
    owners = g.get_owners(g.as_remote(attr_owner, context[:transaction]), true)

    for i in length(contain_owners)
        owner = g.get(ConceptManager(context[:transaction]),
                        EntityType,
                        contain_owners[i])
        @expect in(owner, owners)
    end
end

@then("attribute(email) get key owners do not contain:") do context
    contain_owners = [db[1] for db in context.datatable]
    attr_owner = g.get(ConceptManager(context[:transaction]),
                        AttributeType,
                        "email")
    owners = g.get_owners(g.as_remote(attr_owner, context[:transaction]), true)

    for i in length(contain_owners)
        owner = g.get(ConceptManager(context[:transaction]),
                        EntityType,
                        contain_owners[i])
        @expect !in(owner, owners)
    end
end


# Scenario: Attribute types with value type string can unset their regular expression
@then("attribute(email) as(string) unset regex") do context
    attr_owns_regex = g.get(ConceptManager(context[:transaction]), AttributeType, "email")
    g.set_regex(g.as_remote(attr_owns_regex, context[:transaction]), nothing)
end

@then("attribute(email) as(string) does not have any regex") do context
    attr_owns_regex = g.get(ConceptManager(context[:transaction]), AttributeType, "email")
    result_regex = g.get_regex(g.as_remote(attr_owns_regex, context[:transaction]))
    @expect result_regex === nothing
end
