# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

# function database_contains_req(name::String)
#     return CoreDatabaseManager_Contains_Req().name = name
# end

# function database_schema_req(name::String)
#     return CoreDatabase_Schema_Req().name = name
# end

# function session_open_req(database_name::String, type::Int32, options::grakn.protocol.Options)
#     open_req = grakn.protocol.Session_Open_Req()
#     open_req.database = database_name
#     open_req._type = type
#     open_req.options = options

#     return open_req
# end

# function session_pulse_req(session_id::Array{UInt8,1})
#     puls_req = grakn.protocol.Session_Pulse_Req()
#     puls_req.session_id = session_id
#     return puls_req
# end

# TODO This has a dependency to grabl tracing... Confirm.
function tracing_data()
    return Dict{AbstractString, AbstractString}()
end

# DatabaseManager

database_manager_create_req(name::String) = P.CoreDatabaseManager_Create_Req(; name)
database_manager_contains_req(name::String) = P.CoreDatabaseManager_Contains_Req(; name)
database_manager_all_req() = P.CoreDatabaseManager_All_Req()

# Database

database_schema_req(name::String) = P.CoreDatabaseManager_Schema_Req(; name)
database_delete_req(name::String) = P.CoreDatabaseManager_Delete_Req(; name)

# Session

function session_open_req(database::String, _type::EnumType, options::P.Options)
    return P.Session_Open_Req(; database, _type, options)
end

session_pulse_req(session_id::Bytes) = P.Session_Pulse_Req(; session_id)

# Transaction

transaction_client_msg(reqs::P.Transaction_Req) = P.Transaction_Client(; reqs)

function transaction_stream_req(req_id::UUID)
    req_id = string(req_id)
    stream_req = P.Transaction_Stream_Req()
    return P.Transaction_Req(; req_id, stream_req)
end

function transaction_open_req(
    session_id::Bytes,
    _type::EnumType,
    options::P.Options,
    network_latency_millis::Int
)
    open_req = P.Transaction_Open_Req(; session_id, _type, options, network_latency_millis)
    return P.Transaction_Req(; open_req)
end

function transaction_commit_req()
    metadata = tracing_data()
    commit_req = P.Transaction_Commit_Req()
    return P.Transaction_Req(; metadata, commit_req)
end

# Query Manager

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
    func = Symbol("query_manager_$f")
    type = Symbol("QueryManager_$t")
    @eval begin
        function $func(query::String, options::P.Options)
            $f = P.$type(; query)
            query_manager_req = P.QueryManager_Req(; $f, options)
            return P.Transaction_Req(; query_manager_req)
        end
    end
end
