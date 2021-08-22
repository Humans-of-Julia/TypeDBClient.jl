struct RelationType <: AbstractRelationType
    label::Label
    is_root::Bool
end

# Remote functions

function create(x::RemoteConcept{RelationType})
    result = execute(x.transaction, RelationTypeRequestBuilder.create_req(x.concept.label))
    return Relation(result.type_res.relation_type_create_res.relation)
end

function set_relates(transaction::AbstractCoreTransaction,
                    label::Label,
                    role_label::String,
                    overridden_label::Optional{String} = nothing)

    relates_req = RelationTypeRequestBuilder.set_relates_req(label,
                                    role_label,
                                    overridden_label)

    execute(transaction, relates_req)
    return nothing
end

function get_relates(r::RemoteConcept{RelationType})
    relates_req = RelationTypeRequestBuilder.get_relates_req(r.concept.label)
    res = stream(r.transaction, relates_req)
    return instantiate.(collect(Iterators.flatten(
        r.type_res_part.relation_type_get_relates_res_part.roles for r in res)))
end

function relation_type_get_relates_for_role_label(r::RemoteConcept{RelationType}, for_role::String)
    role_req = RelationTypeRequestBuilder.relation_type_get_relates_for_role_label_req(r.concept.label,for_role)
    res = execute(r.transaction, role_req)

    if !hasproperty(res.type_res.relation_type_get_relates_for_role_label_res, :role_type)
        return nothing
    end
    return instantiate(res.type_res.relation_type_get_relates_for_role_label_res.role_type)
end

function unset_relates(r::RemoteConcept{RelationType}, role_label::Optional{String})
    unset_req = RelationTypeRequestBuilder.unset_relates_req(r.concept.label, role_label)
    execute(r.transaction, unset_req)
    return nothing
end
