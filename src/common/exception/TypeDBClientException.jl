# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

mutable struct TypeDBClientException <: Exception
    error_message::T where {T<:Union{<:AbstractGeneralError,<:Nothing}}
    params::Optional{Tuple}
    individual_message::Union{Nothing, String}
    cause::R where {R<:Union{Nothing, Exception}}
end

Base.show(io::IO, typedb_excption::TypeDBClientException) = Base.print(io,typedb_excption)
function Base.print(io::IO, typedb_excption::TypeDBClientException)
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


#
# package typedb.client.common.exception;
#
# import io.grpc.Status;
# import io.grpc.StatusRuntimeException;
#
# import javax.annotation.Nullable;
#
# public class TypeDBClientException extends RuntimeException {
#
#     @Nullable
#     private final ErrorMessage errorMessage;
#
#     public TypeDBClientException(ErrorMessage error, Object... parameters) {
#         super(error.message(parameters));
#         assert !getMessage().contains("%s");
#         this.errorMessage = error;
#     }
#
#     public TypeDBClientException(String message, Throwable cause) {
#         super(message, cause);
#         this.errorMessage = null;
#     }
#
#     public static TypeDBClientException of(StatusRuntimeException statusRuntimeException) {
#         // "Received Rst Stream" occurs if the server is in the process of shutting down.
#         if (statusRuntimeException.getStatus().getCode() == Status.Code.UNAVAILABLE
#                 || statusRuntimeException.getStatus().getCode() == Status.Code.UNKNOWN
#                 || statusRuntimeException.getMessage().contains("Received Rst Stream")) {
#             return new TypeDBClientException(ErrorMessage.Client.UNABLE_TO_CONNECT);
#         } else if (isReplicaNotPrimaryException(statusRuntimeException)) {
#             return new TypeDBClientException(ErrorMessage.Client.CLUSTER_REPLICA_NOT_PRIMARY);
#         }
#         return new TypeDBClientException(statusRuntimeException.getStatus().getDescription(), statusRuntimeException);
#     }
#
#     public String getName() {
#         return this.getClass().getName();
#     }
#
#     @Nullable
#     public ErrorMessage getErrorMessage() {
#         return errorMessage;
#     }
#
#     // TODO: propagate exception from the server side in a less-brittle way
#     private static boolean isReplicaNotPrimaryException(StatusRuntimeException statusRuntimeException) {
#         return statusRuntimeException.getStatus().getCode() == Status.Code.INTERNAL && statusRuntimeException.getStatus().getDescription().contains("[RPL01]");
#     }
# }
