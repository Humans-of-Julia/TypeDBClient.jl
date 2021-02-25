#=
In root folder run $ bash setup.sh to genrate the proto files

then install the packages from GitHub

(GraknClient) pkg> add https://github.com/tanmaykm/HPack.jl
(GraknClient) pkg> add https://github.com/tanmaykm/HTTP2.jl
(GraknClient) pkg> add https://github.com/tanmaykm/gRPC.jl

=#
module GraknClient
# following this example here: https://github.com/tanmaykm/DexClient.jl/blob/master/src/DexClient.jl

using gRPC
using Sockets

import Base: show, close

include(joinpath(@__DIR__,"generated","grakn.jl"))
include(joinpath(@__DIR__,"generated","grakn_pb.jl"))
include(joinpath(@__DIR__,"common","exception.jl"))
include(joinpath(@__DIR__,"rpc","database_manager.jl"))

export GraknBlockingClient, GraknClientException

using .grakn
using .Database_Manager

const DEFAULT_GRAKN_GRPC_PORT = 1729

struct GraknBlockingClient
    controller::gRPCController
    client::gRPCClient
    grakn_stub::GraknBlockingStub
    databases::DatabaseManager
    address::IPAddr
    port::Int
end

GraknBlockingClient(port::Integer = DEFAULT_GRAKN_GRPC_PORT) = GraknBlockingClient(ip"127.0.0.1", port)
GraknBlockingClient(address::String, port::Integer) = GraknBlockingClient(Sockets.parse(IPAddr , address), port)
function GraknBlockingClient(ip::IPAddr, port::Integer)
    controller = gRPCController()
    try 
        client = gRPCClient(ip, port)
        databases = DatabaseManager(client.channel)
        grakn_blocking_stub = stub(client, GraknBlockingStub)
        GraknBlockingClient(controller, client, grakn_blocking_stub, databases, ip, port)
    catch ex
        if typeof(ex) == Base.IOError
            throw(GraknClientException("Connection could not established. Proof the address, port and the accessibility of the server \n 
                                       for more Information refer to the stored exception in this exception"))
        end
    end
end

show(io::IO, grakn::GraknBlockingClient) = print(io,"Grakn(", grakn.client.sock, ")")
close(grakn::GraknBlockingClient) = close(grakn.client)

end #module



