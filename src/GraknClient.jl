# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

#=
In root folder run $ bash setup.sh to genrate the proto files

then install the packages from GitHub
Pkg.rm("gRPCClient")
Pkg.add(url="https://github.com/JuliaComputing/gRPCClient.jl")
] dev gRPCClient

=#
module GraknClient

using gRPCClient, Sockets, UUIDs, Dates
using DataStructures

import Base: show, close, ==

###### abstract types ##################
#                                      #
########################################

abstract type AbstractCoreDatabaseManager end

abstract type AbstracClient end
abstract type AbstractClusterClient <: AbstracClient end
abstract type AbstractCoreClient <: AbstracClient end

abstract type AbstractCoreSession end
abstract type AbstractCoreTransaction end
abstract type AbstractRequestTransmitter end
abstract type AbstractLogicManager end
abstract type AbstractQueryManager end

###### inlcudes ########################
#                                      #
########################################

#generated section
include("generated/grakn.jl")
include("generated/core_service_pb.jl")

#standard julia sources
include("standard/type_aliases.jl")
include("standard/utility_functions.jl")

#api section
include(joinpath(@__DIR__,"api","GraknOptions.jl"))

#common section
include("common/exception/ErrorMessage.jl")
include("common/exception/GraknClientException.jl")
include("common/rpc/GraknStub.jl")
include("common/rpc/RequestBuilder.jl")

#concepts
include("common/Label.jl")
include("concept/Concept.jl")

#concept section
include(joinpath(@__DIR__,"concept","ConceptManagerImpl.jl"))

#logic section
include(joinpath(@__DIR__,"logic","LogicManagerImpl.jl"))

#query section
include(joinpath(@__DIR__,"query","QueryManagerImpl.jl"))

#stream section
include("stream/RequestTransmitter.jl")
include("stream/ResponseCollector.jl")
include("stream/BidirectionalStream.jl")

#core section
include("core/CoreDatabase.jl")
include("core/CoreDatabaseManager.jl")
include("core/CoreClient.jl")
include("core/CoreSession.jl")
include("core/CoreTransaction.jl")

# part of common section -- place because of general grpc resulthandling
include("common/exception/gRPC_Result_Handling.jl")


export GraknCoreBlockingClient, GraknClientException
export contains_database


# export  Session, Transaction

####### pretty printing sectoin ##################

Base.show(io::IO, blocking_stub::GraknCoreBlockingStub) = Base.print(io,blocking_stub)
function Base.print(io::IO, blocking_stub::GraknCoreBlockingStub)
    Base.print(io, "GraknCoreBlockingStub(open: $(!blocking_stub.impl.channel.session.closed))")
    return nothing
end

## Printing UUId stored in Vector in a more readable way
Base.show(io::IO, id::Array{UInt8,1}) = Base.print(io, id)
Base.print(io::IO, id::Array{UInt8,1}) = Base.print(io, string(bytes2hex(id)))

## Printing each request in a shorter form except they have speicalized
## printing options.
Base.show(io::IO, item::T) where {T<:ProtoType} = Base.print(io, item)
function Base.print(io::IO, item::T) where {T<:ProtoType}
    erg  = collect(keys(meta(typeof(item)).symdict))
    str_item = ""
    for attr in erg
        if hasproperty(item, attr)
            str_item *= string(attr) * ": " * string(getproperty(item,attr))
            break
        end
    end
    out_string = string(nameof(typeof(item))) * " ($str_item)"
    Base.print(io, out_string)

    return nothing
end

end #module
