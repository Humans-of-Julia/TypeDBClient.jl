# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

#=
In root folder run $ bash setup.sh to genrate the proto files

then install the packages from GitHub
Pkg.rm("gRPCClient")
Pkg.add(url="https://github.com/JuliaComputing/gRPCClient.jl")
=#
module GraknClient
# following this example here: https://github.com/tanmaykm/DexClient.jl/blob/master/src/DexClient.jl

using gRPCClient, Sockets, UUIDs, Dates
using DataStructures

import Base: show, close, ==

###### abstract types ##################
#                                      #
########################################

abstract type AbstractCoreDatabaseManager end
abstract type AbstractCoreClient end
abstract type AbstractCoreSession end
abstract type AbstractCoreTransaction end
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
include("standard/utils.jl")

#common section
include("common/Label.jl")
include("common/exception/ErrorMessage.jl")
include("common/exception/GraknClientException.jl")
include("common/rpc/GraknStub.jl")
include("common/rpc/RequestBuilder.jl")

#concepts
include("concept/Concept.jl")

#api section
include("api/GraknOptions.jl")

#stream section
include("stream/RequestTransmitter.jl")

#core section
include("core/CoreDatabase.jl")
include("core/CoreDatabaseManager.jl")
include("core/CoreClient.jl")
include("core/CoreSession.jl")
include("core/CoreTransaction.jl")


export GraknCoreBlockingClient, GraknClientException


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
