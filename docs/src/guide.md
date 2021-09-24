```@meta
CurrentModule = TypeDBClient
```

# User Guide

**This is just a preview yet**

## Installation

To use this client, you need a compatible TypeDB Server running. Visit the Compatibility Table

This pkg is not yet registered on the JuliaHub. As of now you would need to install it directly from the GitHub repo.

Inside the Julia REPL, type ] to enter the Pkg REPL mode then run

`pkg> dev https://github.com/Humans-of-Julia/TypeDBClient.jl`

## Quickstart

First make sure, the TypeDB server is running. It is described here in the [TypeDB Documentation](https://docs.vaticle.com/docs/running-typedb/install-and-run).

In the Julia REPL or in your source run

` using TypeDBCLient`

You have two choices:

* If you are only interested on working interactivly on wrangling some data interactivly you can use the more simplified API. An example for this is:
```julia
using TypeDBClient: dbconnect, open, read, write, match, insert, commit, create_database

dbconnect("127.0.0.1") do client
# The client section where all commands  with the client
# are possible

    # Here the creation of a database
    create_database(client, "my-typedb")
    # Open the session
    open(client, "my-typedb") do session
        # Open a write transaction
        write(session) do transaction
            # make a insert with a TypeQL string
            insert(transaction, raw"insert $_ isa person;")
            #committing the transaction.
            commit(transaction)
        end
        # Open a read session
        read(session) do transaction
            # make a match request with a TypeQL string
            answers = match(transaction, raw"match $p isa person;")
        end
    end
end
```

For working with data using TypeQL please refer to the syntax on [TypeQL Documentation](https://docs.vaticle.com/docs/query/overview)

* You want the full stack at your fingertips. Then you can use the following commands:
```julia
using TypeDBClient

# only for convencience reasons, you can write the full name if you want
g = TypeDBClient
#create a client
client = g.CoreClient("127.0.0.1",1729)

# create a database called typedb if the database isn't on the server
g.create_database(client, "typedb")

# Open a session to write in the schema section of the database.
# Be careful if you work with a schema session. No more session are allowed
# until you close this session. Closing a session is essentially. Don't forget this
# at the end of your work
session = g.CoreSession(client, "typedb" , g.Proto.Session_Type.SCHEMA, request_timout=Inf)

# open a write transaction
transaction = g.transaction(session, g.Proto.Transaction_Type.WRITE)

# make a query in the database
# The result of this query will be a vector of ConceptMap. From there you can access the
# data as you want.
results = g.match(transaction, raw"""match $x sub thing;""")

# If you want work further in with the session, go ahead else close the session
close(session)
```
If you want use the full potential of the client you should read the documentation
of the API functions. There you will find all you need for working programmatically in the database.
Otherwise it is even possible to get most of the time equally results using TypeQL.

```@autodocs
Modules = [TypeDBClient]
```

## User API

* delete

    There are some delete functions:
  * database

    [`delete_database(client::CoreClient, database_name::String)`](@ref)

  * type

    [`delete(r::RemoteConcept{C,T}) where {C <:AbstractThingType, T <: AbstractCoreTransaction}`](@ref)

    Any type can be deleted with this function. Be aware that only types which have no instances
    in the database can be deleted.


* get_has

    [`get_owns(r::RemoteConcept{C,T}, value_type::Optional{EnumType}=nothing,keys_only::Bool=false) where {C <: AbstractThingType,T <: AbstractCoreTransaction}`](@ref)


* get_instances

    [`get_instances(r::RemoteConcept{C,T}) where
        {C <: AbstractThingType,T <: AbstractCoreTransaction}`](@ref)
* get_owns

    [`get_owns(
        r::RemoteConcept{C,T},
        value_type::Optional{EnumType}=nothing,
        keys_only::Bool=false
    ) where {C <: AbstractThingType,T <: AbstractCoreTransaction}`](@ref)

* get_owners
* get_plays
* get_regex
* get_rule
* get_rules
* get_subtypes
* get_supertype
* get_supertypes
* set_abstract
* set_has
* set_label
* set_owns
* set_plays
* set_regex
* set_supertype
* unset_abstract
* unset_has
