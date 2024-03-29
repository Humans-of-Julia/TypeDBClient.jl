# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

# Porting note:
# There is no need for a `Thing` type because it's an abstract thing that could just be
# an entity, relation, of attribute. See `instantiate` function below.

function instantiate(t::Proto.Thing)
    if t._type.encoding == Proto.Type_Encoding.ENTITY_TYPE
        return Entity(t)
    elseif t._type.encoding == Proto.Type_Encoding.RELATION_TYPE
        return Relation(t)
    elseif t._type.encoding == Proto.Type_Encoding.ATTRIBUTE_TYPE
        return Attribute(t)
    else
        throw(TypeDBClientException(CONCEPT_BAD_ENCODING))
    end
end

"""
    set_has(transaction::AbstractCoreTransaction, thing::AbstractThing, attribute::Attribute)

For a given Thing the attribute will set as associated.
"""
function set_has(transaction::AbstractCoreTransaction, thing::AbstractThing, attribute::Attribute)
    res_proto_attribute = get_proto_thing(ConceptManager(transaction), attribute.iid)
    has_req = ThingRequestBuilder.set_has_req(thing.iid, res_proto_attribute)
    execute(transaction, has_req)

    return nothing
end

"""
    unset_has(transaction::AbstractCoreTransaction, thing::AbstractThing, attribute::Attribute)

Here an given attribute will be detached from a given thing
"""
function unset_has(transaction::AbstractCoreTransaction, thing::AbstractThing, attribute::Attribute)
    res_proto_attribute = get_proto_thing(ConceptManager(transaction), attribute.iid)
    unset_has_req = ThingRequestBuilder.unset_has_req(thing.iid, res_proto_attribute)
    execute(transaction, unset_has_req)

    return nothing
end

"""
    get_has(transaction::AbstractCoreTransaction,
        thing::AbstractThing,
        attribute_type::Optional{AttributeType} = nothing,
        attribute_types::Optional{Vector{<:AbstractAttributeType}} = nothing,
        keys_only = false)

With this function it is possible to get attributes of an entity or a relation.
Optional it is possible to restrict the type(s) of attributes which will retrieved from
the database. You can decide between only one ore more than one type.
"""
function get_has(transaction::AbstractCoreTransaction,
                thing::AbstractThing,
                attribute_type::Optional{AttributeType} = nothing,
                attribute_types::Optional{Vector{<:AbstractAttributeType}} = nothing,
                keys_only = false)

    if count([attribute_type !== nothing, attribute_types !== nothing, keys_only]) > 1
        throw(TypeDBClientException(GET_HAS_WITH_MULTIPLE_FILTERS))
    end

    attribute_types_intern = attribute_type !== nothing ? [attribute_type] : []
    attribute_types_intern = attribute_types !== nothing ? attribute_types : attribute_types_intern

    all_attribute_types = get_owns(as_remote(thing.type, transaction))

    res_attr_types = !isempty(intersect(attribute_types_intern, all_attribute_types)) ?
                        intersect(attribute_types_intern, all_attribute_types) :
                        all_attribute_types

    attribute_types_proto = proto.(res_attr_types)
    has_req = keys_only ?
                ThingRequestBuilder.get_has_req(thing.iid, keys_only) :
                ThingRequestBuilder.get_has_req(thing.iid, attribute_types_proto)
    res_has = stream(transaction, has_req)

    return instantiate.(collect(Iterators.flatten(
        r.thing_res_part.thing_get_has_res_part.attributes for r in res_has)))
end

"""
    delete(r::RemoteConcept{<:AbstractThing})
To delete an Entity, Relation or Attribute this have to be packed with the transaction
to a RemoteConcept. To accomplish this see the function as_remote.
"""
function delete(r::RemoteConcept{<:AbstractThing})
    del_req = ThingRequestBuilder.delete_req(r.concept.iid)
    execute(r.transaction, del_req)

    return nothing
end

function is_deleted(r::RemoteConcept{<:AbstractThing})
    res_thing = get(ConceptManager(r.transaction), r.concept.iid)
    return res_thing === nothing
end
