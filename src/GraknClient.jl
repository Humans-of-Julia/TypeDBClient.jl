# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

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
using UUIDs

import Base: show, close

###### abstract types ##################
#                                      # 
########################################

abstract type AbstractTransaction end
abstract type AbstractConceptManager end
abstract type AbstractLogicManager end
abstract type AbstractQueryManager end

###### inlcudes ########################
#                                      # 
########################################

include(joinpath(@__DIR__,"generated","grakn.jl"))
include(joinpath(@__DIR__,"generated","grakn_pb.jl"))
include(joinpath(@__DIR__,"common","exception.jl"))
include(joinpath(@__DIR__,"GraknOptions.jl"))
include(joinpath(@__DIR__,"rpc","database_manager.jl"))
include(joinpath(@__DIR__,"client.jl"))
include(joinpath(@__DIR__,"concept","ConceptManager.jl"))
include(joinpath(@__DIR__,"query","query_manager.jl"))
include(joinpath(@__DIR__,"logic","logic_manager.jl"))
include(joinpath(@__DIR__,"rpc","session.jl"))
include(joinpath(@__DIR__,"rpc","transaction.jl"))

export GraknBlockingClient, GraknClientException, Session, Transaction

end #module



