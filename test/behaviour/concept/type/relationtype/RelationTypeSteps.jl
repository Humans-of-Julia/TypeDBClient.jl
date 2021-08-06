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
    @info role_play
    res_supertype = g.get_supertype(g.as_remote(role_play, context[:transaction]))
    @info res_supertype
end
