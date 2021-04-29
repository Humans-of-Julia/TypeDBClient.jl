# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

mutable struct CoreClient <: AbstractCoreClient
    #private static final String GRAKN_CLIENT_RPC_THREAD_NAME = "typedb-client-rpc"
    channel::gRPCClient.gRPCChannel
    address::String
    port::Int
    core_stub::Core_TypeDBStub
    databaseMgr::CoreDatabaseManager
    sessions::Dict{String, Union{<:AbstractCoreSession, Nothing}}
end

Base.show(io::IO, core_client::CoreClient) = print(io, "CoreClient(address: $(core_client.address):$(core_client.port))")

function CoreClient(address::String, port::Int)
    channel = gRPCChannel(address * ":" * string(port))
    stub = Core_TypeDBStub(channel)
    databaseMgr = CoreDatabaseManager()
    sessions = Dict{String, Union{<:AbstractCoreSession, Nothing}}()
    return CoreClient(channel,address, port, stub, databaseMgr,sessions)
end

is_cluster(client::AbstractCoreClient) = false

remove_session(client::AbstractCoreClient, session::AbstractCoreSession) = delete!(client.sessions, session.sessionID)
