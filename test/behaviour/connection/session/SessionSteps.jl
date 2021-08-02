# Scenario: for one database, open one session
@then("session is null: false") do context
    @expect context[:session] !== nothing
    @expect context[:session] isa g.CoreSession
end

@then("session is open: true") do context
    @expect g.is_open(context[:session]) == true
end

@then("session has database: typedb") do context
    @expect context[:session].database.name == "typedb"
end

@when("connection open sessions for databases:") do context
    dbnames = [item[1] for item in context.datatable]
    sessions = g.CoreSession[]
    for name in dbnames
        push!(sessions, g.CoreSession(context[:client], name, g.Proto.Session_Type.DATA, request_timout=Inf))
    end
    context[:sessions] = sessions
    @expect length(dbnames) == length(sessions)
end

@then("sessions are null: false") do context
    @expect context[:sessions] !== nothing
end

@then("sessions are open: true") do context
    res_open = map(x->g.is_open(x), context[:sessions])
    @expect length(res_open) > 0
    @expect all(res_open) === true
end

@then("sessions have databases:") do context
    dbs = [item.database for item in context[:sessions]]
    @expect dbs !== nothing
    @expect first(unique(typeof.(dbs))) == TypeDBClient.CoreDatabase
end

@when("connection open sessions in parallel for databases:") do context
    dbnames = [item[1] for item in context.datatable]
    sessions = g.CoreSession[]
    lock_add = ReentrantLock()
    @sync @async for db in dbnames
        sess = g.CoreSession(context[:client], db, g.Proto.Session_Type.DATA, request_timout=Inf)
        try
            lock(lock_add)
            push!(sessions, sess)
        finally
            unlock(lock_add)
        end
    end
    context[:sessions] = sessions
    @expect length(dbnames) == length(sessions)
end

@then("sessions in parallel are null: false") do context
    @expect (context[:sessions] !== nothing && !isempty(context[:sessions])) === true
end

@then("sessions in parallel are open: true") do context
    res_open = map(x->g.is_open(x), context[:sessions])
    @expect length(res_open) > 0
    @expect all(res_open) === true
end

@then("sessions in parallel have databases:") do context
    dbnames = [item[1] for item in context.datatable]
    sessions = context[:sessions]
    for i in 1:length(dbnames)
        @expect sessions[i].database.name == dbnames[i]
    end
end

# Scenario: write schema in a data session throws
@then("graql define; throws exception containing \"session type does not allow\"") do context
    define_string = "define person sub entity;"
    try
        g.define(context[:transaction], define_string)
    catch ex
        res_comparisson = occursin("session type does not allow", string(ex.error_message))
        @expect res_comparisson === true
    end
end

@then("graql define") do context
    define_string = "define person sub entity;"
    g.define(context[:transaction], define_string)
end

@then("graql insert; throws exception containing \"session type does not allow\"") do context
    ins_string = "insert \$x isa person;"
    try
        g.insert(context[:transaction], ins_string)
    catch ex
        res_comparisson = occursin("session type does not allow", string(ex.error_message))
        @expect res_comparisson === true
    end
end
