# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

# This example uses the social_network dataset. You can create the schema and upload data
# by following instructionns from https://docs.grakn.ai/docs/general/quickstart

using Revise

using TypeDBClient
import TypeDBClient.typedb.protocol as P

client = Client("127.0.0.1")
session = Session(client, "social_network", P.Session_Type.DATA)


# ------------------------------------------------------------------
# general query

function query(q::AbstractString)
    transaction = Transaction(
        session, session.sessionID, P.Transaction_Type.READ, TypeDBOptions()
    )
    result = TypeDBClient.match(transaction, q)
    close(transaction)
    return result
end

# Getting attributes
raw_result = query(raw"""
    match $p isa person, has full-name $n, has gender $g; get $n, $g;
    """)
result = map(r -> (fullname = r["n"].value, gender = r["g"].value),
    raw_result)

# Getting entities
raw_result = query(raw"""match $p isa person; get $p;""")
result = map(r -> (iid = r["p"].iid,), raw_result)

# Getting relations
raw_result = query(raw"""match $emp (employer: $x, employee: $y) isa employment; get $emp;""")

#=
typedb console returns the related iid's also!

Julia:
 ConceptMap:
    1. emp => TypeDBClient.Relation("aa8280058000000000000006",
        TypeDBClient.RelationType(:employment, false))

Console:
{ $emp iid 0xaa828005800000000000000a (
    employment:employer: iid 0x966e800a8000000000000003,
    employment:job: iid 0x966e800e8000000000000007,
    employment:employee: iid 0x966e8009800000000000000e) isa employment;
}
=#

# ------------------------------------------------------------------
# ConceptManager methods

function cm_call(f::Function, session)
    transaction = Transaction(session, session.sessionID, P.Transaction_Type.READ, TypeDBOptions())
    concept_manager = ConceptManager(transaction)
    res = f(concept_manager)
    close(transaction)
    return res
end

cm_call(session) do concept_manager
    @show get(concept_manager, ThingType, "title")
    @show get(concept_manager, AttributeType, "title")
end

# ------------------------------------------------------------------
# ThingType methods

# Fetch a thing_type for testing
function get_thing_type_as_remote(name::String)
    transaction = Transaction(session, session.sessionID, P.Transaction_Type.READ, TypeDBOptions())
    concept_manager = ConceptManager(transaction)
    thing_type_res = execute(concept_manager, TypeDBClient.ConceptManagerRequestBuilder.get_thing_type_req(name))
    thing_type = instantiate(thing_type_res.get_thing_type_res.thing_type)
    return as_remote(thing_type, transaction)
end

t = get_thing_type_as_remote("title")
res = get_supertype(t)

t = get_thing_type_as_remote("event-date")
res = get_subtypes(t)

t = get_thing_type_as_remote("approved-date")
res = get_supertypes(t)

t = get_thing_type_as_remote("school")
res = get_instances(t)

t = get_thing_type_as_remote("person")
res = get_owns(t)
res = get_owns(t, VALUE_TYPE.BOOLEAN)
res = get_owns(t, nothing, true)  # keys only => should return "email" atttribute

t = get_thing_type_as_remote("location")
res = get_plays(t)

# TODO - 2021-06-05 17:18:10,362 [typedb-service::0] [ERROR] v.t.core.server.TransactionService - [TYW03] Invalid Type Write: The type 'media' has instances, and cannot be set abstract.
# Should probably create my own attribute and set it to abstract
t = get_thing_type_as_remote("media")
set_abstract(t)

# TODO - com.vaticle.typedb.core.common.exception.TypeDBException: [INT03] Invalid Internal State: Illegal internal operation! This method should not have been called.
# Should probably create my own attribute and set it to abstract and then unset it
t = get_thing_type_as_remote("media")
unset_abstract(t)

t = get_thing_type_as_remote("title")
res = get_owners(t)

# ------------------------------------------------------------------
# AttributeType methods

# attribute_type = AttributeType{VALUE_TYPE.BOOLEAN}(Label("a1"), false)
# transaction = Transaction(session, session.sessionID, P.Transaction_Type.READ, TypeDBOptions())
# remote_attribute_type = as_remote(attribute_type, transaction)
# res = put(remote_attribute_type)

close(session)
close(client)
