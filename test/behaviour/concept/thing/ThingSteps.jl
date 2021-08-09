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

function _put_attribute_to_db(context, attr_name, type)
    attr_req = g.ConceptManagerRequestBuilder.put_attribute_type_req(attr_name, type)
    return g.execute(context[:transaction], attr_req)
end

function _attribute_instances(transaction)
    res = g.match(transaction, raw"""match $x isa attribute;""")
    erg = isempty(res) ? [] : collect(Iterators.flatten([values(rm.data) for rm in res]))
    return erg
end

@given("put entity type: person") do context
    context[:concept_manager] = ConceptManager(context[:transaction])
    g.put(context[:concept_manager], EntityType, "person")
end

@given("entity(person) set owns attribute type: is-alive") do context
    g.con.entity_set_owns("person", "is-alive", context[:transaction])
end


@given("entity(person) set owns attribute type: age") do context
    g.con.entity_set_owns("person", "age", context[:transaction])
end


@given("entity(person) set owns attribute type: score") do context
    g.con.entity_set_owns("person", "score", context[:transaction])
end


@given("entity(person) set owns attribute type: name") do context
    g.con.entity_set_owns("person", "name", context[:transaction])
end


@given("entity(person) set owns attribute type: email") do context
    g.con.entity_set_owns("person", "email", context[:transaction])
end

@given("entity(person) set owns attribute type: birth-date") do context
    g.con.entity_set_owns("person", "birth-date", context[:transaction])
end
