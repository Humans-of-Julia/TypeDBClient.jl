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

include("src/generated/grakn.jl")
include("src/generated/grakn_pb.jl")
using .grakn

const DEFAULT_GRAKN_GRPC_PORT = 1729

struct GraknBlockingClient
    controller::gRPCController
    client::gRPCClient
    grakn_stub::GraknBlockingStub

    GraknBlockingClient(port::Integer = DEFAULT_GRAKN_GRPC_PORT) = GraknBlockingClient(ip"127.0.0.1", port)
    function GraknBlockingClient(ip::IPv4, port::Integer)
        controller = gRPCController()
        client = gRPCClient(ip, port)
        grakn_blocking_stub = stub(client, GraknBlockingStub)
        new(controller, client, grakn_blocking_stub)
    end
end

show(io::IO, grakn::GraknBlockingClient) = print("Grakn(", grakn.client.sock, ")")
close(grakn::GraknBlockingClient) = close(grakn.client)

for fn in (:CreateClient, :UpdateClient, :DeleteClient, :CreatePassword, :UpdatePassword, :DeletePassword, :ListPasswords, :GetVersion, :ListRefresh, :RevokeRefresh)
    @eval begin
        import .grakn: $fn
        $fn(grakn::GraknBlockingClient, args...) = $fn(grakn.grakn_stub, grakn.controller, args...)
    end
end

export GraknBlockingClient

end #module



