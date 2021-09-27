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
session = g.CoreSession(client, "typedb" , g.Proto.Session_Type.SCHEMA, request_timeout=Inf)

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

    * Attribute

    [`get_owners(transaction::AbstractCoreTransaction,
        attribute::AbstractAttribute,
        thing_type::Optional{AbstractThingType} = nothing)`](@ref)

    * AttributeType

    [`get_owners(r::RemoteConcept{C,T}, only_key = false) where {
        C <: AbstractAttributeType, T <: AbstractCoreTransaction}`](@ref)


* get_plays

    [`get_plays(r::RemoteConcept{C,T}) where
        {C <: AbstractThingType,T <: AbstractCoreTransaction}`](@ref)


* get_regex

    [`get_regex(r::RemoteConcept{C,T}) where {
    C <: AbstractAttributeType, T <: AbstractCoreTransaction}`](@ref)


* get_rule

    [`get_rule(log_mgr::AbstractLogicManager, label::String)`](@ref)


* get_rules

    [`get_rules(log_mgr::AbstractLogicManager)`](@ref)


* get_subtypes

    [`get_subtypes(r::RemoteConcept{C,T}) where
    {C <: AbstractType,T <: AbstractCoreTransaction}`](@ref)

* get_supertype

    [`get_supertype(
    r::RemoteConcept{C,T}) where {C <: AbstractType,T <: AbstractCoreTransaction}`](@ref)

* get_supertypes

    [`get_supertypes(r::RemoteConcept{C,T}) where
    {C <: AbstractType,T <: AbstractCoreTransaction}`](@ref)

* set_abstract

    [`set_abstract(r::RemoteConcept{C,T}) where
    {C <: AbstractThingType,T <: AbstractCoreTransaction}`](@ref)

* set_has

    [`set_has(transaction::AbstractCoreTransaction, thing::AbstractThing, attribute::Attribute)`](@ref)

* set_label

    [`set_label(r::RemoteConcept{C,T}, new_label_name::String) where
    {C <: AbstractType,T <: AbstractCoreTransaction}`](@ref)

* set_owns

    [`set_owns(
        r::RemoteConcept{C,T},
        attribute_type::AbstractType,
        is_key::Bool=false,
        overriden_type::Optional{AbstractType}=nothing
    ) where {C <: AbstractType,T <: AbstractCoreTransaction}`](@ref)

* set_plays

    [`function set_plays(
        r::RemoteConcept{C,T},
        role_type::AbstractRoleType,
        overridden_role_type::Optional{AbstractRoleType}=nothing
    ) where {C <: AbstractThingType,T <: AbstractCoreTransaction}`](@ref)

* set_regex

    [``set_regex(r::RemoteConcept{C,T}, regex::Optional{AbstractString}) where {
    C <: AbstractAttributeType, T <: AbstractCoreTransaction}](@ref)

* set_supertype

    [`set_supertype(r::RemoteConcept{C,T},
                            super_type::AbstractThingType) where
                            {C <: AbstractThingType,T <: AbstractCoreTransaction}`](@ref)

* unset_abstract

    [`unset_abstract(r::RemoteConcept{C,T}) where
    {C <: AbstractThingType,T <: AbstractCoreTransaction}`](@ref)

* unset_has

    [`unset_has(transaction::AbstractCoreTransaction, thing::AbstractThing, attribute::Attribute)`](@ref)
