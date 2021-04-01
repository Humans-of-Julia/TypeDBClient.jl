# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

#=
In root folder run $ bash setup.sh to genrate the proto files

then install the packages from GitHub
Pkg.rm("gRPCClient")

=#
module GraknClient
# following this example here: https://github.com/tanmaykm/DexClient.jl/blob/master/src/DexClient.jl

using gRPCClient, Sockets, UUIDs, Dates
using DataStructures

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
abstract type AbstractConceptManager end
abstract type AbstractLogicManager end
abstract type AbstractQueryManager end
abstract type AbstractThing <: AbstractConcept end

###### inlcudes ########################
#                                      #
########################################

#generated section
include(joinpath(@__DIR__,"generated","grakn.jl"))
include(joinpath(@__DIR__,"generated","core_service_pb.jl"))

#api section
include(joinpath(@__DIR__,"api","GraknOptions.jl"))

#common section
include(joinpath(@__DIR__,"common","exception","ErrorMessage.jl"))
include(joinpath(@__DIR__,"common","exception","GraknClientException.jl"))
include(joinpath(@__DIR__,"common","rpc","GraknStub.jl"))
include(joinpath(@__DIR__,"common","rpc","RequestBuilder.jl"))

#stream section
include(joinpath(@__DIR__,"stream","RequestTransmitter.jl"))
include(joinpath(@__DIR__,"stream","ResponseCollector.jl"))
include(joinpath(@__DIR__,"stream","BidirectionalStream.jl"))

#core section
include(joinpath(@__DIR__,"core","CoreDatabase.jl"))
include(joinpath(@__DIR__,"core","CoreDatabaseManager.jl"))
include(joinpath(@__DIR__,"core","CoreClient.jl"))
include(joinpath(@__DIR__,"core","CoreSession.jl"))
include(joinpath(@__DIR__,"core","CoreTransaction.jl"))

# part of common section -- place because of general grpc resulthandling
include(joinpath(@__DIR__,"common","exception","gRPC_Result_Handling.jl"))


export GraknCoreBlockingClient, GraknClientException
export contains_database

# export  Session, Transaction

####### pretty printing sectoin ##################
Base.show(io::IO, blocking_stub::GraknCoreBlockingStub) = Base.print(io,blocking_stub)

function Base.print(io::IO, blocking_stub::GraknCoreBlockingStub)
    Base.print(io, "GraknCoreBlockingStub(open: $(!blocking_stub.impl.channel.session.closed))")
    return nothing
end


function copy_to_proto(from_object, to_proto_struct::Type{T}) where {T<: ProtoType}
    result_proto = to_proto_struct()
    for fname in fieldnames(typeof(from_object))
        if !hasproperty(result_proto, Symbol(fname)) && getfield(from_object,Symbol(fname)) !== nothing
            setproperty!(result_proto,Symbol(fname),getfield(from_object,Symbol(fname)))
        end
    end
    result_proto
end

end #module
