# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE
using Behavior

using TypeDBClient

include(joinpath(@__DIR__,"test/behaviour/config/ConfigEnvironment.jl"))

g = TypeDBClient

@given("connection has been opened") do context
    client = g.CoreClient("127.0.0.1",1729)
    context[:client] = client
end

@given("connection does not have any database") do context
    all_dbs = g.get_all_databases(context[:client])
    @expect length(all_dbs) == 0
end

sessions(context) = collect(values(context[:client].sessions))
transactions(context::Behavior.StepDefinitionContext) = collect(values(context[:session].transactions))
transactions(session::g.CoreSession) = collect(values(session.transactions))

trans_read = g.Proto.Transaction_Type.READ
trans_write = g.Proto.Transaction_Type.WRITE
