# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE
using Behavior

using TypeDBClient
using TypeDBClient: delete_database

# include(joinpath(@__DIR__,"test/behaviour/config/ConfigEnvironment.jl"))

g = TypeDBClient

@given("connection has been opened") do context
    client = g.CoreClient("127.0.0.1",1729)
    context[:client] = client
end

@given("connection does not have any database") do context
    dbs_not_to_be = [ "alice",
                        "bob",
                        "charlie",
                        "dylan",
                        "eve",
                        "frank",
                        "typedb"]

    all_dbs = g.get_all_databases(context[:client])
    dbs_not_allowed = []
    if !isempty(all_dbs)
        db_in_system = [x.name for x in all_dbs]
        dbs_to_delete = intersect(dbs_not_to_be, db_in_system)
        for db in dbs_to_delete
            delete_database(context[:client], db)
        end
        all_dbs = g.get_all_databases(context[:client])
        dbs_not_allowed = intersect([x.name for x in all_dbs], dbs_not_to_be)
    end
    @expect length(dbs_not_allowed) == 0
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
        count_nr = 0
        for item in items
            search == item && (count_nr +=1)
        end
        result[search] = count_nr
    end
    return result
end
