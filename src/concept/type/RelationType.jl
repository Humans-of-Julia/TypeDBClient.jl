struct RelationType <: AbstractRelationType
    label::Label
    is_root::Bool
end

# Remote functions

function create(x::Remote{RelationType})
    result = execute(RelationTypeRequestBuilder.create_req(x.concept.label))
    return Relation(result.relation_type_create_res.relation)
end
