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
    println(io,"TypeDBClientException:")
    println(io,"message: ", err_message)
    println(io,"params: ",joined_params)
    println(io,"remark: ",typedb_excption.individual_message)
    print(io,"cause: ")
    println(io,typedb_excption.cause)

    return nothing
end

function TypeDBClientException(err::Type{T}, parameters...) where {T<:AbstractGeneralError}
    def_err = _build_error_messages(err)
    _params = isempty(parameters) ? Tuple{}() : parameters
    return TypeDBClientException(def_err, _params, nothing, nothing)
end

function TypeDBClientException(err::gRPCServiceCallException, parameters...)
    def_err = _build_error_messages(GRPC_SERVER_ERROR)

    # reading the Number and Prefix from the Server message.
    code_prefix = nothing
    code_number = nothing
    bracket_range = findfirst(r"\[.+\]", err.message)
    if bracket_range !== nothing
        bracket_value = err.message[bracket_range]
        range_code_prefix = findfirst(r"[A-Z]+", bracket_value)
        range_code_number = findfirst(r"\d+", bracket_value)
        code_prefix = range_code_prefix !== nothing ? bracket_value[range_code_prefix] : nothing
        code_number = range_code_number !== nothing ? parse(Int64, bracket_value[range_code_number]) : nothing
    else
        # determine the default values to detect the error message
        # if there is no error number from the server
        bracket_value = ""
        bracket_range = 0:0
    end

    code_prefix !== nothing && (def_err.code_prefix = code_prefix)
    code_number !== nothing && (def_err.code_number = code_number)

    def_err.message_prefix = bracket_value
    def_err.message_body = string(strip(err.message[bracket_range.stop+1:end]))

    _params = isempty(parameters) ? Tuple{}() : parameters
    return TypeDBClientException(def_err, _params, nothing, nothing)
end

function TypeDBClientException(message::String, cause::T) where {T<:Exception}
    err = _build_error_messages(GENERAL_UNKOWN_ERROR)
    return TypeDBClientException(err,nothing,message,cause)
end
