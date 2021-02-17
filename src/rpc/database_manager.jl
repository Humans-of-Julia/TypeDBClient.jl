module Database_Manager
    
include(joinpath(@__DIR__,"src/generated/grakn.jl"))
include(joinpath(@__DIR__,"src/generated/grakn_pb.jl"))
include(joinpath(@__DIR__,"src/common/grakn_exception.jl"))

using ProtoBuf
using gRPC

using .grakn.protocol

export contains

# from graknprotocol.protobuf.grakn_pb2_grpc import GraknStub
# import graknprotocol.protobuf.database_pb2 as database_proto
# from grpc import Channel, RpcError

# from grakn.common.exception import GraknClientException


mutable struct DatabaseManager
    _grpc_sub::AbstractProtoServiceStub
end 

function DatabaseManager(channel::gRPC.gRPCChannel)
        _grpc_stub = GraknStub(channel)
end

function contains(db_manager::Database_Manager, name::String)
    stub_local = db_manager._grpc_stub
    request = grakn.protocol.Database_Contains_Req(name=name)

    # try
    #     result = database_contains(stub_local, gRPCController(), inp::grakn.protocol.Database_Contains_Req, done::Function) 
    # catch ex
    #     throw(GraknClientException(ex))
    # end
end

    # def create(self, name: str):
    #     request = database_proto.Database.Create.Req()
    #     request.name = name
    #     try:
    #         self._grpc_stub.database_create(request)
    #     except RpcError as e:
    #         raise GraknClientException(e)

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