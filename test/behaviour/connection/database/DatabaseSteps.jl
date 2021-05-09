# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE
g = TypeDBClient


# Scenario: create one database
@when("connection create database: alice") do context
    client = context[:client]
    db = g.create_database(client, "alice")
    @expect db === true
end

@then("connection has database: alice") do context
    result = g.contains_database(context[:client], "alice")
    @expect result === true
    #until beforescenario works for me :-) the following
    delete_all_databases(context[:client])
end

# Scenario: create many databases
@when("connection create databases:") do context
    db_names = context.datatable
    all_db = Bool[]
    for db in db_names
        push!(all_db, g.create_database(context[:client], db[1]))
    end
    @expect all(all_db) === true
end

@then("connection has databases:") do context
    db_names = [db[1] for db in context.datatable]
    server_dbs = [item.name for item in g.get_all_databases(context[:client])]

    @expect (Set(db_names) == Set(server_dbs))

    delete_all_databases(context[:client])
end

# Scenario: create many databases in parallel
@when("connection create databases in parallel:") do context
    db_names = context.datatable
    @sync @async for db in db_names
        g.create_database(context[:client], db[1])
    end
end

# Scenario: delete one database
@when("connection delete database: alice") do context
    g.delete_database(context[:client],"alice")
end

@then("connection does not have database: alice") do context
    @expect g.contains_database(context[:client], "alice") == false
end

# Scenario: connection can delete many databases
@when("connection delete databases:") do context
    db_names = [db[1] for db in context.datatable]
    for db in db_names
        g.delete_database(context[:client], db)
    end
end

@then("connection does not have databases:") do context
    db_names = [db[1] for db in context.datatable]
    db_there = Bool[]
    for db in db_names
        push!(db_there, g.contains_database(context[:client], db))
    end
    @expect all(db_there) !== true
end

# Scenario: delete many databases in parallel
@when("connection delete databases in parallel:") do context
    db_names = [db[1] for db in context.datatable]
    @sync @async for db in db_names
        g.delete_database(context[:client], db)
    end
    @expect isempty(g.get_all_databases(context[:client])) === true
end

# Scenario: delete a database causes open sessions to fail
@when("connection create database: typedb") do context
    g.create_database(context[:client], "typedb")
end

@when("connection open session for database: typedb") do context
    context[:session] = g.CoreSession(context[:client], "typedb" , g.Proto.Session_Type.SCHEMA, request_timout=Inf)
end

@when("connection delete database: typedb") do context
    g.delete_database(context[:client], "typedb")
end

@then("connection does not have database: typedb") do context
    @expect g.contains_database(context[:client], "typedb") === false
end

@then("session open transaction of type; throws exception: write") do context
    try
        transaction(context[:session], g.Proto.Transaction_Type[:READ])
    catch ex
        @info "if a database isn't there a transaction can't be open"
    end
end

@then("graql define; throws exception containing \"transaction has been closed\"") do context
    define_string = "define person sub entity;"
    try
        g.define(context[:transaction], define_string)
    catch ex
        @expect occursin("transaction has been closed", ex.message) === true
    end
end

@then("connection delete database; throws exception: typedb") do context
    try
        g.delete_database(context[:client], "typedb")
    catch ex
        @expect (typeof(ex) == g.TypeDBClientException)
        @expect occursin("The database typedb does not exist", string(ex))
    end
end

##############  utility functions ########################
function delete_all_databases(client::g.CoreClient)
    all_db = g.get_all_databases(client)
    for db in all_db
        g.delete_database(client, db.name)
    end
end
