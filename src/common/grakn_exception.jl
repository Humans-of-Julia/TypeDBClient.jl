mutable struct GraknClientException <: Exception
    msg::String
end

GraknClientException() = GraknClientException("Something within the grakn client went wrong")
