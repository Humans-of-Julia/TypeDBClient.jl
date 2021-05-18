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

transactions(context::Behavior.StepDefinitionContext) = ordered_transaction_result(context[:session])
transactions(session::g.CoreSession) = ordered_transaction_result(session)
function ordered_transaction_result(session::g.CoreSession)
    result = g.CoreTransaction[]
    for (_, transaction) in session.transactions
        push!(result, transaction)
    end
    return result
end

trans_read = g.Proto.Transaction_Type.READ
trans_write = g.Proto.Transaction_Type.WRITE

################# Utility functions #######################

function group_count_items(items::Vector)
    unique_vector = unique(items)
    result = Dict{Any, Number}()
    for search in unique_vector
        count = 0
        for item in items
            search == item && (count +=1)
        end
        result[search] = count
    end
    return result
end
