# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE
abstract type AbstractTypeDBStub end

mutable struct Core_TypeDBStub <: AbstractTypeDBStub
    blockingStub::Proto.TypeDBBlockingStub
    asyncStub::Proto.TypeDBStub
end

function Core_TypeDBStub(channel::gRPCClient.gRPCChannel)
    blockingStub = Proto.TypeDBBlockingStub(channel)
    asyncStub = Proto.TypeDBStub(channel)
    return Core_TypeDBStub(blockingStub,asyncStub)
end

mutable struct Cluster_TypeDBStub <: AbstractTypeDBStub
    blockingStub::Proto.TypeDBBlockingStub
end

function Cluster_TypeDBStub(channel::gRPCClient.gRPCChannel)
    blockingStub = Proto.TypeDBBlockingStub(channel)
    return Cluster_TypeDBStub(blockingStub)
end

function ensure_connected(stub::T) where {T<:AbstractTypeDBStub}
    throw(TypeDBClientException(GENERAL_UNKOWN_ERROR,"function TypeDBStub.jl/ensure_connected isn't implemented yet"))
end
