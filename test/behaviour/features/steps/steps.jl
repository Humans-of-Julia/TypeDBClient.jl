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
    dbs_not_to_be = [ "alice",
                    "bob",
                    "charlie",
                    "dylan",
                    "eve",
                    "frank",
                    "typedb"]

    all_dbs = g.get_all_databases(client)
    dbs_not_allowed = []
    if !isempty(all_dbs)
        db_in_system = [x.name for x in all_dbs]
        dbs_to_delete = intersect(dbs_not_to_be, db_in_system)
        for db in dbs_to_delete
            delete_database(client, db)
        end
        all_dbs = g.get_all_databases(client)
        dbs_not_allowed = intersect([x.name for x in all_dbs], dbs_not_to_be)
    end
    all_dbs_gone = length(dbs_not_allowed) == 0

    return all_dbs_gone
end
