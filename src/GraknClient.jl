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

using gRPC, Sockets, UUIDs, Dates

import Base: show, close, ==

###### convience types #################
#                                      #
########################################

const Maybe{T} = Union{T,Nothing}

###### abstract types ##################
#                                      #
########################################

abstract type AbstractCoreDatabaseManager end
abstract type AbstractCoreClient end
abstract type AbstractCoreSession end
abstract type AbstractCoreTransaction end
abstract type AbstractConcept end
abstract type AbstractThing <: AbstractConcept end

###### inlcudes ########################
#                                      #
########################################

#generated section
include(joinpath(@__DIR__,"generated","grakn.jl"))
include(joinpath(@__DIR__,"generated","core_service_pb.jl"))

#common section
include(joinpath(@__DIR__,"common","exception","ErrorMessage.jl"))
include(joinpath(@__DIR__,"common","exception","GraknClientException.jl"))
include(joinpath(@__DIR__,"common","rpc","GraknStub.jl"))
include(joinpath(@__DIR__,"common","rpc","RequestBuilder.jl"))

#api section
include(joinpath(@__DIR__,"api","GraknOptions.jl"))

#stream section
include(joinpath(@__DIR__,"stream","RequestTransmitter.jl"))

#core section
include(joinpath(@__DIR__,"core","CoreDatabase.jl"))
include(joinpath(@__DIR__,"core","CoreDatabaseManager.jl"))
include(joinpath(@__DIR__,"core","CoreClient.jl"))
include(joinpath(@__DIR__,"core","CoreSession.jl"))
include(joinpath(@__DIR__,"core","CoreTransaction.jl"))


export GraknCoreBlockingClient, GraknClientException
# export  Session, Transaction

####### pretty printing sectoin ##################
Base.show(io::IO, blocking_stub::GraknCoreBlockingStub) = Base.print(io,blocking_stub)

function Base.print(io::IO, blocking_stub::GraknCoreBlockingStub)
    Base.print(io, "GraknCoreBlockingStub(open: $(!blocking_stub.impl.channel.session.closed))")
    return nothing
end

end #module
