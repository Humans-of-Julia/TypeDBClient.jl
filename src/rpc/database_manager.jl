# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

using ProtoBuf
using gRPC

using .grakn.protocol

export DatabaseManager
export contains, create, delete, all


mutable struct DatabaseManager
    _grpc_stub::AbstractProtoServiceStub
end 


function DatabaseManager(channel::gRPC.gRPCChannel)
    grakn_stub = GraknBlockingStub(channel)
    DatabaseManager(grakn_stub)
end


function contains(db_manager::DatabaseManager, name::String)
    stub_local = db_manager._grpc_stub
    request = grakn.protocol.Database_Contains_Req(name=name)
    try
        result = database_contains(stub_local, gRPCController(), request).contains
    catch ex
        throw(GraknClientException(ex))
    end
end


function create(db_manager::DatabaseManager, name::String)
    stub_local = db_manager._grpc_stub
    request = grakn.protocol.Database_Create_Req()
    request.name = name
    if !contains(db_manager,name)
        try
            result = database_create(stub_local, gRPCController(), request) 
        catch ex
            throw(GraknClientException(ex))
        finally

        end
    else    
        throw(GraknClientException("Database $name allready available in the system"))
    end
end


function delete(db_manager::DatabaseManager, name::String)
    stub_local = db_manager._grpc_stub
    request = grakn.protocol.Database_Delete_Req()
    request.name = name
    if contains(db_manager,name) 
        try
            result = database_delete(stub_local, gRPCController(), request) 
        catch ex
            throw(GraknClientException(ex))
        finally

        end
    else
        throw(GraknClientException("Database $name isn't available in the system"))
    end
end


function all(db_manager::DatabaseManager)
    stub_local = db_manager._grpc_stub
    request = grakn.protocol.Database_All_Req()
    try
        result = database_all(stub_local, gRPCController(), request).names
    catch ex
         throw(GraknClientException(e))
    finally

    end
end