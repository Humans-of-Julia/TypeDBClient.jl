@given("connection open schema session for database: typedb") do context
    typedb_session = TypeDBClient.CoreSession(client, "typedb" , TypeDBClient.typedb.protocol.Session_Type[:SCHEMA] , TypeDBClient.TypeDBOptions())
    context[:session] = typedb_session
    # Menat to proof open sessions. During tests it shows sometimes that sessions wasn't closed properly
    haskey(context, :sessions) ? push!(context[:sessions], typedb_session) : context[:sessions] = [typedb_session]
end

@given("connection open data session for database: typedb") do context
    sess = g.CoreSession(context[:client], "typedb", g.Proto.Session_Type.DATA, request_timout=Inf)
    context[:session] = sess
    # Menat to proof open sessions. During tests it shows sometimes that sessions wasn't closed properly
    haskey(context, :sessions) ? push!(context[:sessions], sess) : context[:sessions] = [sess]
    @expect context[:session] !== nothing
end

@given("transaction commits") do context
    g.commit(context[:transction])
end

@given("connection close all sessions") do context
    g.safe_close.(collect(values(context[:client].sessions)))
end


@afterscenario() do context, scenario
    delete_all_databases(context[:client])
end

@beforeall() do
    client = g.CoreClient("127.0.0.1",1729)
    dbs = g.get_all_databases(client)
    for item in dbs
        g.delete_database(client, item.name)
    end
end

##############  utility functions ########################
function delete_all_databases(client::g.CoreClient)
    for (_, session) in client.sessions
        safe_close(session)
    end
    all_db = g.get_all_databases(client)
    for db in all_db
        g.delete_database(client, db.name)
    end
end
