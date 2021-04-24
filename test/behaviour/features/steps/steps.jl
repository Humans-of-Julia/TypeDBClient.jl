

@given("connection open schema session for database: grakn") do context
    grakn_session = GraknClient.CoreSession(client, "grakn" , GraknClient.grakn.protocol.Session_Type[:SCHEMA] , GraknClient.GraknOptions())
    context[:session] = grakn_session
    @expect context[:session] !== nothing
end


