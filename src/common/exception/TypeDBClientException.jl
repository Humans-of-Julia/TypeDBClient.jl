# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

mutable struct TypeDBClientException <: Exception
    error_message::Optional{AbstractGeneralError}
    params::Optional{Tuple}
    individual_message::Optional{String}
    cause::Optional{Exception}
end

function Base.show(io::IO, typedb_excption::TypeDBClientException)
    err_message = string(typedb_excption.error_message)
    joined_params = ""
    if typedb_excption.params !== nothing
        if !isempty(typedb_excption.params)
            replace_item = "_error_item"
            err_message = replace(err_message, replace_item=>string(typedb_excption.params[1]))
            joined_params = join(typedb_excption.params, "\n")
        end
    end
    str = "TypeDBClientException:
        message: $(err_message)
        params: $(joined_params)
        remark: $(typedb_excption.individual_message)
        cause: $(Base.show(typedb_excption.cause))"

    print(io,str)
    return nothing
end

function TypeDBClientException(err::Type{T}, parameters...) where {T<:AbstractGeneralError}
    err = _build_error_messages(err)
    _params = parameters === nothing && Tuple{}()
    return TypeDBClientException(err, parameters, nothing, nothing)
end

function TypeDBClientException(message::String, cause::T) where {T<:Exception}
    err = _build_error_messages(GENERAL_UNKOWN_ERROR)
    return TypeDBClientException(err,nothing,message,cause)
end
