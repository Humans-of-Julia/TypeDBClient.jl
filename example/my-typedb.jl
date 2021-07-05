# Sample usage

using Revise
using TypeDBClient: dbconnect, open, read, write, match, insert, commit

dbconnect("127.0.0.1") do client
    open(client, "my-typedb") do session
        write(session) do transaction
            insert(transaction, raw"insert $_ isa person;")
            commit(transaction)
        end
        read(session) do transaction
            answers = match(transaction, raw"match $p isa person;")
        end
    end
end



