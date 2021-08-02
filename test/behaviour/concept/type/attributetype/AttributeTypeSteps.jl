# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE
using Dates: length
using Base: func_for_method_checked
# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

using Behavior
using TypeDBClient
using Dates

g = TypeDBClient

# Scenario: Attribute types can be created
@then("attribute(name) is null: false") do context
    context[:attr_name] = g.get(ConceptManager(context[:transaction]), AttributeType, "name")
    @expect context[:attr_name] !== nothing
end

@then("attribute(name) get supertype: attribute") do context
    super_t = g.get_supertype(g.as_remote(context[:attr_name], context[:transaction]))

    eval_attr = AttributeType(g.Label("","attribute"), true, VALUE_TYPE.OBJECT)
    @expect super_t == eval_attr
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
