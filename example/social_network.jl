# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

# This example uses the social_network dataset. You can create the schema and upload data
# by following instructionns from https://docs.grakn.ai/docs/general/quickstart

using Revise

import TypeDBClient.typedb.protocol as P
import TypeDBClient as C

client = C.CoreClient("127.0.0.1", 1729)
session = C.CoreSession(client, "social_network", P.Session_Type.DATA)

function query(q::AbstractString)
    transaction = C.CoreTransaction(
        session, session.sessionID, P.Transaction_Type.READ, C.TypeDBOptions()
    )
    result = C.match(transaction, q)
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

# Fetch a thing_type for testing
function get_thing_type_as_remote(name::String)
    transaction = C.CoreTransaction(session, session.sessionID, P.Transaction_Type.READ, C.TypeDBOptions())
    concept_manager = C.ConceptManager(transaction)
    thing_type_res = C.execute(concept_manager, C.ConceptManagerRequestBuilder.get_thing_type_req(name))
    thing_type = C.instantiate(thing_type_res.concept_manager_res.get_thing_type_res.thing_type)
    return C.as_remote(title_thing_type, transaction)
end

t = get_thing_type_as_remote("title")
@show res = C.get_supertype(t)

t = get_thing_type_as_remote("title")
@show res = C.get_supertypes(t)

# TODO - BidirectionalStream couldn't find any result for this call
#  Union{TypeDBClient.typedb.protocol.Transaction_Res, TypeDBClient.typedb.protocol.Transaction_ResPart}[]
t = get_thing_type_as_remote("content")
@show res = C.get_owns(t)

t = get_thing_type_as_remote("language")
@show res = C.get_plays(t)


close(session)
close(client)
