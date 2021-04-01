# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

mutable struct GraknClientException <: Exception
    error_message::T where {T<:Union{<:AbstractGeneralError,<:Nothing}}
    params
    individual_message::Union{Nothing, String}
    cause::R where {R<:Union{Nothing, Exception}}
end

Base.show(io::IO, grakn_excption::GraknClientException) = Base.print(io,grakn_excption)
function Base.print(io::IO, grakn_excption::GraknClientException)
    str = "GraknClientException:
        message: $(grakn_excption.error_message)
        params: $(join(grakn_excption.params, "\n"))
        remark: $(grakn_excption.individual_message)
        cause: $(Base.show(grakn_excption.cause))
    "
    Base.print(io,str)
    return nothing
end

function GraknClientException(err::Type{T}, parameters...) where {T<:AbstractGeneralError}
    err = _build_error_messages(err)
    return GraknClientException(err, parameters, nothing, nothing)
end

function GraknClientException(message::String, cause::T) where {T<:Exception}
    err = _build_error_messages(GENERAL_UNKOWN_ERROR)
    return GraknClientException(err,nothing,message,cause)
end


#
# package grakn.client.common.exception;
#
# import io.grpc.Status;
# import io.grpc.StatusRuntimeException;
#
# import javax.annotation.Nullable;
#
# public class GraknClientException extends RuntimeException {
#
#     @Nullable
#     private final ErrorMessage errorMessage;
#
#     public GraknClientException(ErrorMessage error, Object... parameters) {
#         super(error.message(parameters));
#         assert !getMessage().contains("%s");
#         this.errorMessage = error;
#     }
#
#     public GraknClientException(String message, Throwable cause) {
#         super(message, cause);
#         this.errorMessage = null;
#     }
#
#     public static GraknClientException of(StatusRuntimeException statusRuntimeException) {
#         // "Received Rst Stream" occurs if the server is in the process of shutting down.
#         if (statusRuntimeException.getStatus().getCode() == Status.Code.UNAVAILABLE
#                 || statusRuntimeException.getStatus().getCode() == Status.Code.UNKNOWN
#                 || statusRuntimeException.getMessage().contains("Received Rst Stream")) {
#             return new GraknClientException(ErrorMessage.Client.UNABLE_TO_CONNECT);
#         } else if (isReplicaNotPrimaryException(statusRuntimeException)) {
#             return new GraknClientException(ErrorMessage.Client.CLUSTER_REPLICA_NOT_PRIMARY);
#         }
#         return new GraknClientException(statusRuntimeException.getStatus().getDescription(), statusRuntimeException);
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
