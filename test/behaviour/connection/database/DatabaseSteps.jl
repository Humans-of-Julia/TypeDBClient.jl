# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE
using TypeDBClient: CoreSession, Proto, TypeDBClientException
using TypeDBClient: contains_database, create_database, define, delete_database, get_all_databases


# Scenario: create one database
@when("connection create database: alice") do context
    client = context[:client]
    db = create_database(client, "alice")
    @expect db
end

@then("connection has database: alice") do context
    result = contains_database(context[:client], "alice")
    @expect result
end

# Scenario: create many databases
@when("connection create databases:") do context
    db_names = context.datatable
    all_db = Bool[]
    for db in db_names
        push!(all_db, create_database(context[:client], db[1]))
    end
    @expect all(all_db)
end

@then("connection has databases:") do context
    db_names = [db[1] for db in context.datatable]
    server_dbs = [item.name for item in get_all_databases(context[:client])]

    @expect (Set(db_names) == Set(server_dbs))
end

# Scenario: create many databases in parallel
@when("connection create databases in parallel:") do context
    db_names = context.datatable
    @sync @async for db in db_names
        create_database(context[:client], db[1])
    end
end

# Scenario: delete one database
@when("connection delete database: alice") do context
    delete_database(context[:client],"alice")
end

@then("connection does not have database: alice") do context
    @expect contains_database(context[:client], "alice") == false
end

# Scenario: connection can delete many databases
@when("connection delete databases:") do context
    db_names = [db[1] for db in context.datatable]
    for db in db_names
        delete_database(context[:client], db)
    end
end

@then("connection does not have databases:") do context
    db_names = [db[1] for db in context.datatable]
    db_there = Bool[]
    for db in db_names
        push!(db_there, contains_database(context[:client], db))
    end
    @expect all(db_there) !== true
end

# Scenario: delete many databases in parallel
@when("connection delete databases in parallel:") do context
    db_names = [db[1] for db in context.datatable]
    @sync @async for db in db_names
        delete_database(context[:client], db)
    end
    @expect isempty(get_all_databases(context[:client]))
end

# Scenario: delete a database causes open sessions to fail
@when("connection create database: typedb") do context
    create_database(context[:client], "typedb")
    context[:db_name] = "typedb"
end

@when("connection open session for database: typedb") do context
    context[:session] = CoreSession(context[:client], context[:db_name] , Proto.Session_Type.DATA, request_timeout=Inf)
end

@when("connection delete database: typedb") do context
    delete_database(context[:client], context[:db_name])
end

@then("connection does not have database: typedb") do context
    @expect contains_database(context[:client], context[:db_name]) === false
end

@then("session open transaction of type; throws exception: write") do context
    try
        transaction(context[:session], Proto.Transaction_Type.WRITE)
    catch ex
        @expect ex !== nothing
    end
end

@then("graql define; throws exception containing \"transaction has been closed\"") do context
    define_string = "define person sub entity;"
    try
        define(context[:transaction], define_string)
    catch ex
        @expect ex !== nothing
    end
end

@then("connection delete database; throws exception: typedb") do context
    try
        delete_database(context[:client], "typedb")
    catch ex
        @expect (typeof(ex) == TypeDBClientException)
        @expect occursin("The database typedb does not exist", string(ex))
    end
end
