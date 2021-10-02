# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

# @when("transaction commits") do context
#     g.commit(context[:transaction])
# end
g = TypeDBClient

@when("session opens transaction of type: read") do context
    transaction = g.transaction(context[:session], trans_read)
    @expect transaction !== nothing
    context[:transaction] = transaction
    context[:cm] = ConceptManager(context[:transaction])
end

# When session opens transaction of type: write
@when("session opens transaction of type: write") do context

    if haskey(context, :transaction)
        context[:transaction] !== nothing && g.close(context[:transaction])
    end

    transaction = g.transaction(context[:session], g.Proto.Transaction_Type.WRITE)
    @expect transaction !== nothing
    context[:transaction] = transaction
    # only a convinience method to prevent paperwork
    context[:cm] = ConceptManager(context[:transaction])
end

@then("session transaction is null: false") do context
    trans_isempty = isempty(transactions(context))
    @expect trans_isempty === false
end

@then("session transaction is open: true") do context
    sess_trans = transactions(context)
    is_open = map(item->g.is_open(item),sess_trans)
    all_open = all(is_open)
    @expect all_open
end

@then("session transaction has type: read") do context
    is_open = g.is_open(context[:transaction])
    @expect is_open
end

@then("session transaction has type: write") do context
    transaction_write = context[:transaction].type
    @expect transaction_write == trans_write
end

@then("session transaction commits") do context
    g.commit(context[:transaction])
end

@then("session transaction commits; throws exception") do context
    commit_req = g.TransactionRequestBuilder.commit_req()
    try
        g.execute(context[:transaction], commit_req)
    catch ex
        @expect ex !== nothing
    end
end

# Scenario: one database, one session, re-committing transaction throws
@when("for each session, open transaction of type: write") do context
    for session in sessions(context)
        g.transaction(session, trans_write)
    end
end

@then("for each session, transaction commits") do context
    for session in sessions(context)
        for trans in transactions(session)
            commit_trans = g.TransactionRequestBuilder.commit_req()
            g.execute(trans, commit_trans)
        end
    end
end

@then("for each session, transaction commits; throws exception") do context
    for session in sessions(context)
        for trans in transactions(session)
            commit_trans = g.TransactionRequestBuilder.commit_req()
            try
                g.execute(trans, commit_trans)
            catch ex
                @expect ex !== nothing
            end
        end
    end
end

# Scenario: one database, one session, transaction close is idempotent
@then("for each session, transaction closes") do context
    for session in sessions(context)
        close.(collect(values(session.transactions)))
    end
end

@then("for each session, transaction is open: false") do context
    for session in sessions(context)
        @expect isempty(values(session.transactions))
    end
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
    for session in sessions(context)
        transactions = collect(values(session.transactions))
        @expect isempty(transactions) === false
    end
end

@then("for each session, transactions are open: true") do context
    for session in sessions(context)
        transactions = collect(values(session.transactions))
        for transaction in transactions
            @expect g.is_open(transaction)
        end
    end
end

@then("for each session, transactions have type:") do context
    types_of_read = [row[1] for row in context.datatable]
    transactions = collect(values(context[:session].transactions))
    for nr in 1:length(types_of_read)
        type_transaction = types_of_read[nr] == "read" ? trans_read : trans_write
        @expect transactions[nr].type == type_transaction
    end
end

@when("for each session, open transactions in parallel of type:") do context
    trans_types = [row[1] for row in context.datatable]
    for session in sessions(context)
        for nr in 1:length(trans_types)
            trans = trans_types[nr] == "read" ? g.transaction(session, trans_read) : g.transaction(session, trans_write)
            result = trans !== nothing
            @expect result
        end
        expectation = length(session.transactions) == length(trans_types)
        @expect expectation
    end
end

@then("for each session, transactions in parallel are null: false") do context
    for session in sessions(context)
        @expect isempty(transactions(session)) === false
    end
end


@then("for each session, transactions in parallel are open: true") do context
    for session in sessions(context)
        for trans in transactions(session)
            @expect g.is_open(trans)
        end
    end
end

@then("for each session, transactions in parallel have type:") do context
    trans_types = [row[1] for row in context.datatable]
    changed_trans_types = map(x-> x=="read" ? trans_read : trans_write, trans_types)
    res_trans_types = group_count_items(changed_trans_types)
    for session in sessions(context)
        sess_trans_type = [item.type for item in transactions(session)]
        res_trans_sess = group_count_items(sess_trans_type)
        @expect res_trans_types == res_trans_sess
    end
end


@given("connection open sessions for database:") do context
    dbs = [row[1] for row in context.datatable]
    for db in dbs
        g.CoreSession(context[:client], db , g.Proto.Session_Type.DATA, request_timeout=Inf)
    end
    count_result = length(context[:client].sessions) == length(dbs)
    @expect count_result
end

@when("for each session, open transaction of type: read") do context
    for session in sessions(context)
        g.transaction(session, trans_read)
        test_trans = length(session.transactions) == 1
        @expect test_trans
    end
end

@then("for each session, transaction is null: false") do context
    result_empty = map(x->!isempty(x.transactions) ,sessions(context))
    result_expect = all(result_empty)
    @expect result_expect
end

@then("for each session, transaction is open: true") do context
    trans = transactions.(sessions(context))
    sess_trans = reduce(vcat, trans)
    result_expect = all(g.is_open.(sess_trans))
    @expect result_expect
end

@then("for each session, transaction has type: read") do context
    trans = transactions.(sessions(context))
    sess_trans = reduce(vcat, trans)
    result_expect = all([trans.type == trans_read for trans in sess_trans])
    @expect result_expect
end

@then("for each session, transaction has type: write") do context
    trans = transactions.(sessions(context))
    sess_trans = reduce(vcat, trans)
    result_expect = all([trans.type == trans_write for trans in sess_trans])
    @expect result_expect
end

# Scenario: write in a read transaction throws
@then("graql define; throws exception containing \"schema writes when transaction type does not allow\"") do context
    define_string =   "define person sub entity;"
    try
        g.define(context[:transaction], define_string)
    catch ex
        res_comparisson = occursin("schema writes when transaction type does not allow", string(ex.error_message))
        @expect res_comparisson
    end
end

@then("transaction commits; throws exception") do context
    try
        g.commit(context[:transaction])
    catch ex
        @expect typeof(ex) == g.TypeDBClientException
    end
end
