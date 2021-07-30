# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE


@given("put attribute type: license, with value type: string") do context
    _put_attribute_to_db(context, "license", VALUE_TYPE.STRING)
end

@given("put attribute type: date, with value type: datetime") do context
    _put_attribute_to_db(context, "date", VALUE_TYPE.DATETIME)
end

@given("put relation type: marriage") do context
    res = g.put(ConceptManager(context[:transaction]), RelationType, "marriage")
    @info res
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
                        true)
end

@given("entity(person) set plays role: marriage:wife") do context
    ent_pers = g.get(ConceptManager(context[:transaction]), EntityType, "person")


    # g.set_plays(g.as_remote(context[:transaction], ent_pers),
    #     g.RoleType(Label("marriage", "wife"),false))
    @info ent_pers
end
