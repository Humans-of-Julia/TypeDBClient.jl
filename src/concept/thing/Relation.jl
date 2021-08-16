# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

struct Relation <: AbstractRelation
    iid::String
    type::RelationType
end

function Relation(t::Proto.Thing)
    iid = bytes2hex(t.iid)
    isempty(iid) && throw(TypeDBClientException(CONCEPT_MISSING_IID))
    return Relation(iid, instantiate(t._type))
end

# TODO seems unnecessary?
as_relation(r::Relation) = r

function add_player(trans::AbstractCoreTransaction,
                    relation::AbstractRelation,
                    role::AbstractRoleType,
                    player_thing::AbstractThing)

    proto_thing = get_proto_thing(ConceptManager(trans), player_thing.iid)
    player_req = RelationRequestBuilder.add_player_req(relation.iid, proto(role), proto_thing)

    execute(trans, player_req)

    return nothing
end

function remove_player(transaction::AbstractCoreTransaction,
                            relation::AbstractRelation,
                            role_type::AbstractRoleType,
                            player_thing::AbstractThing)

    proto_player = get_proto_thing(ConceptManager(transaction), player_thing.iid)
    rem_player_req = RelationRequestBuilder.remove_player_req(relation.iid, proto(role_type), proto_player)
    execute(transaction, rem_player_req)

    return nothing
end

function get_players(transaction::AbstractCoreTransaction,
                        relation::AbstractRelation,
                        roles::Optional{Vector{<:AbstractRoleType}}= nothing)

    role_types = roles !== nothing ? proto.(roles) : nothing

    play_req = RelationRequestBuilder.get_players_req(relation.iid, role_types)
    player_res = stream(transaction, play_req)

    return instantiate.(collect(Iterators.flatten(
        r.thing_res_part.relation_get_players_res_part.things for r in player_res)))
end

function get_relations(
    transaction::AbstractCoreTransaction,
    thing::AbstractThing,
    role_types::Optional{AbstractVector{<:AbstractRoleType}}=nothing)

    proto_role_types = role_types !== nothing ? proto.(role_types) : nothing

    rel_req = ThingRequestBuilder.get_relations_req(thing.iid, proto_role_types)
    res_rel = stream(transaction, rel_req)
    return return instantiate.(collect(Iterators.flatten(
        r.thing_res_part.thing_get_relations_res_part.relations for r in res_rel)))
end
