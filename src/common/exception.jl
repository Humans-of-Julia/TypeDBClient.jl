mutable struct GraknClientException <: Exception
    exeption
    msg::String
end

GraknClientException(ex::T) where {T<:Exception} = GraknClientException(ex,"") 
GraknClientException(msg::String) = GraknClientException(nothing, msg)