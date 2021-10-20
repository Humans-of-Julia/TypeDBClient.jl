```@meta
CurrentModule = TypeDBClient
```
# User Guide

## Installation

To use this client, you need a compatible TypeDB Server running.
You can find install instructions in the [TypeDB Documentation](https://docs.vaticle.com/docs/running-typedb/install-and-run).

## Compatibility table:

| TypeDBClient.jl | TypeDB | TypeDB Cluster | Julia |
|:--------------:|:-----------:|:------------:|:------------:|
| 0.1.0 | 2.4      |     -     | >=1.6

Inside the Julia REPL, type ] to enter the Pkg REPL mode then run

`pkg> add TypeDBClient`

## Quickstart

First make sure the TypeDB server is running.
See [Start the TypeDB Server](https://docs.vaticle.com/docs/running-typedb/install-and-run#start-the-typedb-server) section.

In the Julia REPL or in your source code:

`using TypeDBClient`

You have two choices:

* If you are only interested in working interactively, you can use the more simplified API. An example for this is:
```julia
using TypeDBClient: dbconnect, open, read, write, match, insert, commit, create_database

# Connecting the client to TypeDB
dbconnect("127.0.0.1") do client

    # Create a database
    create_database(client, "my-typedb")
    # Opening a session
    open(client, "my-typedb") do session
        # Open a write transaction
        write(session) do transaction
            # Insert a record using TypeQL
            insert(transaction, raw"insert $_ isa person;")
            # Commit the transaction
            commit(transaction)
        end
        # Open a read session
        read(session) do transaction
            # Make a match request with a TypeQL string
            answers = match(transaction, raw"match $p isa person;")
        end
    end
end
```

For working with data using TypeQL, please refer to the syntax on [TypeQL Documentation](https://docs.vaticle.com/docs/query/overview)

* If you want the full stack at your fingertips, then you can use the following commands:

```julia
using TypeDBClient

# Only for convenience reasons, you can write the full name if you want
g = TypeDBClient

# Create a client
client = g.CoreClient("127.0.0.1",1729)

# Create a database called typedb if the database wasn't already created by you previously.
g.create_database(client, "typedb")

#=
    Open a session to write in the schema section of the database.
    Be careful if you work with a schema session. No more sessions are allowed
    until you close this session. Closing a session is mandatory. Don't forget this
    at the end of your work.
=#
session = g.CoreSession(client, "typedb" , g.Proto.Session_Type.SCHEMA, request_timeout=Inf)

# Open a write transaction
transaction = g.transaction(session, g.Proto.Transaction_Type.WRITE)

#=
    Make a query in the database
    The result of this query will be a vector of ConceptMap.
    From there you can access the data as you want.
=#
results = g.match(transaction, "match \$x sub thing;")

# If you want to work further in the session, go ahead, else close the session.
close(session)
```
If you want to use the full potential of the client you should read the documentation
of the API functions. There you will find all you need for working programmatically in the database.
Otherwise, it is even possible to get equal results using TypeQL.

```@autodocs
Modules = [TypeDBClient]
```

## User API

* delete

    There are some delete functions:

  * database

    [`delete_database(client::AbstractCoreClient, name::AbstractString)`](@ref)

  * type

    [`unset_has(transaction::AbstractCoreTransaction, thing::AbstractThing, attribute::Attribute)`](@ref)

    Any type can be deleted with this function. Be aware that only types which have no instances
    in the database can be deleted.


* get_has

    [`get_has(transaction::AbstractCoreTransaction,
        thing::AbstractThing,
        attribute_type::Optional{AttributeType} = nothing,
        attribute_types::Optional{Vector{<:AbstractAttributeType}} = nothing,
        keys_only = false)`](@ref)


* get_instances

    [`get_instances(r::RemoteConcept{<:AbstractThingType})`](@ref)

* get_owns

    [`get_owns(
        r::RemoteConcept{<:AbstractThingType},
        value_type::Optional{EnumType}=nothing,
        keys_only::Bool=false
    )`](@ref)

* get_owners

    * Attribute

    [`get_owners(transaction::AbstractCoreTransaction,
        attribute::AbstractAttribute,
        thing_type::Optional{AbstractThingType} = nothing)`](@ref)

    * AttributeType

    [`get_owners(r::RemoteConcept{<: AbstractAttributeType}, only_key = false)`](@ref)


* get_plays

    [`get_plays(r::RemoteConcept{<: AbstractThingType})`](@ref)



* get_regex

    [`get_regex(r::RemoteConcept{<:AbstractAttributeType})`](@ref)

* get_rule

    [`get_rule(log_mgr::AbstractLogicManager, label::AbstractString)`](@ref)


* get_rules

    [`get_rules(log_mgr::AbstractLogicManager)`](@ref)


* get_subtypes

    [`get_subtypes(r::RemoteConcept{<:AbstractType})`](@ref)


* get_supertype

    [`get_supertype(r::RemoteConcept{<:AbstractType})`](@ref)


* get_supertypes

    [` get_supertypes(r::RemoteConcept{<:AbstractType})`](@ref)


* set_abstract

    [`set_abstract(r::RemoteConcept{<:AbstractThingType})`](@ref)

* set_has

    [`set_has(transaction::AbstractCoreTransaction, thing::AbstractThing, attribute::Attribute)`](@ref)


* set_label

    [`set_label(r::RemoteConcept{<:AbstractType},
    new_label_name::AbstractString)`](@ref)

* set_owns

    [`set_owns(
            r::RemoteConcept{<:AbstractType},
            attribute_type::AbstractType,
            is_key::Bool=false,
            overriden_type::Optional{AbstractType}=nothing
        )`](@ref)


* set_plays

    [`set_plays(
        r::RemoteConcept{<:AbstractThingType},
        role_type::AbstractRoleType,
        overridden_role_type::Optional{AbstractRoleType}=nothing
    )`](@ref)


* set_regex

    [`set_regex(r::RemoteConcept{<:AbstractAttributeType},
    regex::Optional{AbstractString})`](@ref)


* set_supertype

    [`set_supertype(r::RemoteConcept{<: AbstractThingType,<: AbstractCoreTransaction},
        super_type::AbstractThingType)`](@ref)


* unset_abstract

    [`unset_abstract(r::RemoteConcept{<:AbstractThingType})`](@ref)


* unset_has

    [`unset_has(transaction::AbstractCoreTransaction, thing::AbstractThing, attribute::Attribute)`](@ref)
