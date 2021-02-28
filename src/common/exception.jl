# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

mutable struct GraknClientException <: Exception
    exeption::Union{Exception,Nothing}
    msg::String
end

GraknClientException(ex::T) where {T<:Exception} = GraknClientException(ex, string(ex)) 
GraknClientException(msg::String) = GraknClientException(nothing, msg)
GraknClientException(msg::String, ex::T) where {T<:Exception} = GraknClientException(ex,msg)
