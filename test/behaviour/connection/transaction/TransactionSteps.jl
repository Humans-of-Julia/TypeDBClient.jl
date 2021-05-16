# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

@when("transaction commits") do context
    commit_req = g.commit_req()
    g.execute(context[:transaction], commit_req)
end


@when("session opens transaction of type: read") do context
    transaction = g.transaction(context[:session], g.Proto.Transaction_Type.READ)
    @expect transaction !== nothing
    context[:transaction] = transaction
end

@when("session opens transaction of type: write") do context
    transaction = g.transaction(context[:session], g.Proto.Transaction_Type.WRITE)
    @expect transaction !== nothing
    context[:transaction] = transaction
end

@then("session transaction is null: false") do context
    trans_isempty = isempty(context[:session].transactions)
    @expect trans_isempty === false
end

@then("session transaction is open: true") do context
    transactions = collect(values(context[:session].transactions))
    is_open = map(item->g.is_open(item),transactions)
    all_open = all(is_open)
    @expect all_open === true
end

@then("session transaction has type: read") do context
    is_open = g.is_open(context[:transaction])
    @expect is_open === true
    delete_all_databases(context[:client])
end

@then("session transaction has type: write") do context
    trans_write = context[:transaction].type
    @expect trans_write == g.Proto.Transaction_Type.WRITE
    delete_all_databases(context[:client])
end

@then("session transaction commits") do context
    commit_req = g.TransactionRequestBuilder.commit_req()
    g.execute(context[:transaction], commit_req)
end

@then("session transaction commits; throws exception") do context
    commit_req = g.TransactionRequestBuilder.commit_req()
    try
        g.execute(context[:transaction], commit_req)
    catch ex
        @expect ex !== nothing
    end
    delete_all_databases(context[:client])
end

# Scenario: one database, one session, re-committing transaction throws
@when("for each session, open transaction of type: write") do context
    sessions = collect(values(context[:client].sessions))
    for session in sessions
        g.transaction(session, g.Proto.Transaction_Type.WRITE)
    end
end

@then("for each session, transaction commits") do context
    sessions = collect(values(context[:client].sessions))
    for session in sessions
        for trans in collect(values(session.transactions))
            commit_trans = g.TransactionRequestBuilder.commit_req()
            g.execute(trans, commit_trans)
        end
    end
end

@then("for each session, transaction commits; throws exception") do context
    sessions = collect(values(context[:client].sessions))
    for session in sessions
        for trans in collect(values(session.transactions))
            commit_trans = g.TransactionRequestBuilder.commit_req()
            try
                g.execute(trans, commit_trans)
            catch ex
                @expect ex !== nothing
            end
        end
    end
    delete_all_databases(context[:client])
end

# Scenario: one database, one session, transaction close is idempotent
@then("for each session, transaction closes") do context
    sessions = collect(values(context[:client].sessions))
    for session in sessions
        close.(collect(values(session.transactions)))
    end
end

@then("for each session, transaction is open: false") do context
    sessions = collect(values(context[:client].sessions))
    for session in sessions
        @expect isempty(values(session.transactions))
    end
    delete_all_databases(context[:client])
end

@when("for each session, open transactions of type:") do context
    read = g.Proto.Transaction_Type.READ
    types_of_read = [row[1] for row in context.datatable]
    sessions = collect(values(context[:client].sessions))
    for session in sessions
        for type_of_read in types_of_read
            type_of_read == "read" && g.transaction(session,read)
        end
    end
end

@then("for each session, transactions are null: false") do context
    client_sessions = collect(values(context[:client].sessions))
    for session in client_sessions
        transactions = collect(values(session.transactions))
        @expect isempty(transactions) === false
    end
end

@then("for each session, transactions are open: true") do context
    client_sessions = collect(values(context[:client].sessions))
    for session in client_sessions
        transactions = collect(values(session.transactions))
        for transaction in transactions
            @expect g.is_open(transaction) === true
        end
    end
end

@then("for each session, transactions have type:") do context
    read = g.Proto.Transaction_Type.READ
    write = g.Proto.Transaction_Type.WRITE
    types_of_read = [row[1] for row in context.datatable]
    transactions = collect(values(context[:session].transactions))
    for nr in 1:length(types_of_read)
        type_transaction = types_of_read[nr] == "read" ? read : write
        @expect transactions[nr].type == type_transaction
    end
    delete_all_databases(context[:client])
end

#  Scenario: one database, one session, many transactions to write

@when("for each session, open transactions of type: write") do context
    write = g.Proto.Transaction_Type.WRITE
    types_of_write = [row[1] for row in context.datatable]
    types_trans = map(x->x == "write" ? write : nothing, types_of_write)
    for type_trans in types_trans
        g.transaction(context[:session], type_trans)
    end
    @info length(context[:session].transactions)
end
