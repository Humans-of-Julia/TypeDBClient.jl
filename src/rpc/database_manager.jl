module Database_Manager

include(joinpath(@__DIR__,"../generated","grakn.jl"))
include(joinpath(@__DIR__,"../generated","grakn_pb.jl"))
include(joinpath(@__DIR__,"../common","grakn_exception.jl"))

using ProtoBuf
using gRPC

using .grakn.protocol

export DatabaseManager
export contains, create

# from graknprotocol.protobuf.grakn_pb2_grpc import GraknStub
# import graknprotocol.protobuf.database_pb2 as database_proto
# from grpc import Channel, RpcError

# from grakn.common.exception import GraknClientException


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
        result = database_contains(stub_local, gRPCController(), request) 
        result.__protobuf_jl_internal_values[:contains]
    catch ex
        throw(GraknClientException(ex))
    end
end



function create(db_manager::DatabaseManager, name::String)
    stub_local = db_manager._grpc_stub
    request = grakn.protocol.Database_Create_Req()
    request.name = name
    try
        result = database_create(stub_local, gRPCController(), request) 
    catch ex
        throw(GraknClientException(ex))
    end
end

    # def delete(self, name: str):
    #     request = database_proto.Database.Delete.Req()
    #     request.name = name
    #     try:
    #         self._grpc_stub.database_delete(request)
    #     except RpcError as e:
    #         raise GraknClientException(e)

    # def all(self):
    #     try:
    #         return list(self._grpc_stub.database_all(database_proto.Database.All.Req()).names)
    #     except RpcError as e:
    #         raise GraknClientException(e)

end #End of module