

@given("connection open schema session for database: typedb") do context
    typedb_session = TypeDBClient.CoreSession(client, "typedb" , TypeDBClient.typedb.protocol.Session_Type[:SCHEMA] , TypeDBClient.TypeDBOptions())
    context[:session] = typedb_session
    @expect context[:session] !== nothing
end


