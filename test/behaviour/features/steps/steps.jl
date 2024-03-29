@given("connection open schema session for database: typedb") do context
    typedb_session = TypeDBClient.CoreSession(client, "typedb" , g.Proto.Session_Type.SCHEMA , request_timeout = Inf)
    context[:session] = typedb_session
    @expect context[:session] !== nothing
end

@given("connection open data session for database: typedb") do context
    sess = g.CoreSession(context[:client], context[:db_name], g.Proto.Session_Type.DATA, request_timeout=Inf)
    context[:session] = sess
    @expect context[:session] !== nothing
end

@given("transaction commits") do context
    if g.is_open(context[:session]) === true
        g.is_open(context[:transaction]) && g.commit(context[:transaction])
    end
end

@given("connection close all sessions") do context
    g.safe_close(context[:session])
    g.safe_close.(collect(values(context[:client].sessions)))
end

@beforescenario() do context, scenario
    client = g.CoreClient("127.0.0.1",1729)
    delete_all_databases(client)
end

@afterscenario() do context, scenario
  if haskey(context, :session)
    close(context[:session])
    context[:session] = nothing
  end

  if haskey(context, :transaction)
    context[:transaction] = nothing
  end

  delete_all_databases(context[:client])
  close(context[:client])
  context[:client] = nothing
end

@afterall() do
    client = g.CoreClient("127.0.0.1",1729)
    delete_all_databases(client)
    close(client)
end

@beforeall() do
    client = g.CoreClient("127.0.0.1",1729)
    delete_all_databases(client)
end

##############  utility functions ########################
function delete_all_databases(client::g.CoreClient)
    for (_, session) in client.sessions
        g.safe_close(session)
    end
    all_db = g.get_all_databases(client)
    for db in all_db
        g.delete_database(client, db.name)
    end
end
