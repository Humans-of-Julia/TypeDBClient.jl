using Base: Bool
function thing_call(f::Function, session::Session, name::AbstractString)
    cm_call(session) do concept_manager
        thing_type_res = TypeDBClient.execute(
            concept_manager, TypeDBClient.ConceptManagerRequestBuilder.get_thing_type_req(name)
        )
        thing_type = TypeDBClient.instantiate(thing_type_res.get_thing_type_res.thing_type)
        remote_thing = TypeDBClient.as_remote(thing_type, concept_manager.transaction)
        f(remote_thing)
    end
end

function cm_call(f::Function, session::Session)
    transaction = Transaction(session, session.sessionID, g.Proto.Transaction_Type.READ, TypeDBOptions())
    concept_manager = ConceptManager(transaction)
    res = f(concept_manager)
    close(transaction)
    return res
end

function _entity_set_owns(entity, attribute_type, context, is_key = false)
    loc_entity = get(context[:concept_manager], g.EntityType, entity)
    rem_entitiy = g.as_remote(loc_entity, context[:transaction])
    loc_attribute = get(context[:concept_manager], g.AttributeType, attribute_type)
    g.set_owns(rem_entitiy, loc_attribute, is_key)
end

@given("put entity type: person") do context
    context[:concept_manager] = ConceptManager(context[:transaction])
    g.put(context[:concept_manager], EntityType, "person")
end

@given("entity(person) set owns attribute type: is-alive") do context
    _entity_set_owns("person", "is-alive", context)
end


@given("entity(person) set owns attribute type: age") do context
    _entity_set_owns("person", "age", context)
end


@given("entity(person) set owns attribute type: score") do context
    _entity_set_owns("person", "score", context)
end


@given("entity(person) set owns attribute type: name") do context
    _entity_set_owns("person", "name", context)
end


@given("entity(person) set owns attribute type: email") do context
    _entity_set_owns("person", "email", context)
end

@given("entity(person) set owns attribute type: birth-date") do context
    _entity_set_owns("person", "birth-date", context)
end

@given("connection close all sessions") do context
    g.close.(sessions(context))
end
