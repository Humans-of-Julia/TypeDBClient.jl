# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

# ---------------------------------------------------------------------------------
module DatabaseManagerRequestBuilder

import ..grakn.protocol as Proto

create_req(name::String) = Proto.CoreDatabaseManager_Create_Req(; name)

contains_req(name::String) = Proto.CoreDatabaseManager_Contains_Req(; name)

all_req() = Proto.CoreDatabaseManager_All_Req()

end

# ---------------------------------------------------------------------------------
module DatabaseRequestBuilder

import ..grakn.protocol as Proto

schema_req(name::String) = Proto.CoreDatabase_Schema_Req(; name)

delete_req(name::String) = Proto.CoreDatabase_Delete_Req(; name)

end

# ---------------------------------------------------------------------------------
module SessionRequestBuilder

import ..grakn.protocol as Proto
using ..GraknClient: EnumType, Bytes

function open_req(database::String, _type::EnumType, options::Proto.Options)
    return Proto.Session_Open_Req(; database, _type, options)
end

pulse_req(session_id::Bytes) = Proto.Session_Pulse_Req(; session_id)

end

# ---------------------------------------------------------------------------------
module TransactionRequestBuilder

import ..grakn.protocol as Proto
using ..GraknClient: EnumType, Bytes
using UUIDs: UUID

function client_msg(reqs::AbstractVector{Proto.Transaction_Req})
    return Proto.Transaction_Client(; reqs)
end

function stream_req(req_id::UUID)
    req_id = string(req_id) # TODO will be changed to Vector{UInt}
    stream_req = Proto.Transaction_Stream_Req()
    return Proto.Transaction_Req(; req_id, stream_req)
end

function open_req(
    session_id::Bytes,
    _type::EnumType,
    options::Proto.Options,
    network_latency_millis::Int
)
    open_req = Proto.Transaction_Open_Req(;
        session_id, _type, options, network_latency_millis
    )
    return Proto.Transaction_Req(; open_req)
end

function commit_req()
    # metadata = tracing_data()
    commit_req = Proto.Transaction_Commit_Req()
    return Proto.Transaction_Req(; commit_req)
end

end

# ---------------------------------------------------------------------------------
module QueryManagerRequestBuilder

import ..grakn.protocol as Proto
import ..GraknClient

for (f, t) in (
    (:define_req,                :Define_Req),
    (:undefine_req,              :Undefine_Req),
    (:match_req,                 :Match_Req),
    (:match_aggregate_req,       :MatchAggregate_Req),
    (:match_group_req,           :MatchGroup_Req),
    (:match_group_aggregate_req, :MatchGroupAggregate_Req),
    (:insert_req,                :Insert_Req),
    (:delete_req,                :Delete_Req),
    (:update_req,                :Update_Req),
)
    func = Symbol("$f")
    type = Symbol("QueryManager_$t")
    @eval begin
        function $func(query::String, options::Proto.Options = Proto.Options())
            $f = Proto.$type(; query)
            query_manager_req = Proto.QueryManager_Req(; $f, options)
            return Proto.Transaction_Req(; query_manager_req)
        end
    end
end

end

# ---------------------------------------------------------------------------------
module ConceptManagerRequestBuilder

import ..grakn.protocol as Proto
using ..GraknClient: EnumType, bytes

function _treq(; kwargs...)
    return Proto.Transaction_Req(
        concept_manager_req = Proto.ConceptManager_Req(; kwargs...)
    )
end

function put_entity_type_req(label::String)
    return _treq(
        put_entity_type_req = Proto.ConceptManager_PutEntityType_Req(; label)
    )
end

function put_relation_type_req(label::String)
    return _treq(
        put_relation_type_req = Proto.ConceptManager_PutRelationType_Req(; label)
    )
end

function put_attribute_type_req(label::String, value_type::EnumType)
    return _treq(
        put_attribute_type_req =
            Proto.ConceptManager_PutAttributeType_Req(; label, value_type)
    )
end

function get_thing_type_req(label::String)
    return _treq(
        get_thing_type_req = Proto.ConceptManager_GetThingType_Req(; label)
    )
end

function get_thing_req(iid::String)
    return _treq(
        get_thing_req = Proto.ConceptManager_GetThing_Req(; iid = bytes(iid))
    )
end

end

# ---------------------------------------------------------------------------------
module LogicManagerRequestBuilder

import ..grakn.protocol as Proto

function _treq(; kwargs...)
    return Proto.Transaction_Req(
        logic_manager_req = Proto.LogicManager_Req(
            ; kwargs...
        )
    )
end

function put_rule_req(label::String, when::String, then::String)
    return _treq(
        put_rule_req = Proto.LogicManager_PutRule_Req(; label, when, then)
    )
end

function get_rule_req(label::String)
    return _treq(
        get_rule_req = Proto.LogicManager_GetRule_Req(; label)
    )
end

function get_rules_req()
    return _treq(
        get_rules_req = Proto.LogicManager_GetRules_Req()
    )
end

end

# ---------------------------------------------------------------------------------
module TypeRequestBuilder

import ..grakn.protocol as Proto
using ..GraknClient: Label

# Ignore linter error here
function _treq(label, scope; kwargs...)
    return Proto.Transaction_Req(
        type_req = Proto.Type_Req(; label, scope, kwargs...)
    )
end

function is_abstract_req(label::Label)
    return _treq(label.name, label.scope;
        type_is_abstract_req = Proto.Type_IsAbstract_Req()
    )
end

function set_label_req(label::Label, new_label::String)
    return _treq(label.name, label.scope;
        type_set_label_req = Proto.Type_SetLabel_Req(
            label = new_label
        )
    )
end

function get_supertypes_req(label::Label)
    return _treq(label.name, label.scope;
        type_get_supertypes_req = Proto.Type_GetSupertypes_Req()
    )
end

function get_subtypes_req(label::Label)
    return _treq(label.name, label.scope;
        type_get_subtypes_req = Proto.Type_GetSubtypes_Req()
    )
end

end
