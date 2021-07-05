using TypeDBClient
g = TypeDBClient

client = g.CoreClient("127.0.0.1",1729)
g.create_database(client, "typedb")
sess = g.CoreSession(client, "typedb", g.Proto.Session_Type.SCHEMA, request_timout = Inf)
trans = g.transaction(sess, g.Proto.Transaction_Type.WRITE)

g.put(g.ConceptManager(trans), AttributeType, "is-alive", VALUE_TYPE.BOOLEAN )
g.put(g.ConceptManager(trans), EntityType, "person")

function _entity_set_owns(entity, attribute_type, context)
    loc_entity = get(g.ConceptManager(trans), g.EntityType, entity)
    rem_entitiy = g.as_remote(loc_entity, trans)
    loc_attribute = get(g.ConceptManager(trans), g.AttributeType, attribute_type)
    set_owns(rem_entitiy, loc_attribute)
end

@enter _entity_set_owns("person", "is-alive", "")

function cm_call(f::Function, session::Session)
    transaction = Transaction(session, session.sessionID, g.Proto.Transaction_Type.READ, TypeDBOptions())
    concept_manager = ConceptManager(transaction)
    res = f(concept_manager)
    close(transaction)
    return res
end

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

res = thing_call(thing -> get_owns(thing), sess, "person")
