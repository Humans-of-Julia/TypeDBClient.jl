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
include(joinpath(@__DIR__,"client.jl"))

export GraknBlockingClient, GraknClientException

end #module



