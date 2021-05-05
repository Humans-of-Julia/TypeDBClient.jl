# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE
using Behavior

using TypeDBClient

g = TypeDBClient

@given("connection has been opened") do context
    client = g.CoreClient("127.0.0.1",1729)
    context[:client] = client
end

@given("connection does not have any database") do context
    all_dbs = g.get_all_databases(context[:client])
    @expect length(all_dbs) == 0
end
