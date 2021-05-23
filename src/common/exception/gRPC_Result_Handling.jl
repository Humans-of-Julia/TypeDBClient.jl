function grpc_result_or_error(result::T,
    status::Task,
    f::Function) where {T<:Union{<:Proto.ProtoType,<:Channel{<:Proto.ProtoType},<:Nothing}}

    if istaskdone(status)
        s = fetch(status)
        if !s.success
            throw(TypeDBClientException(s.message, gRPCServiceCallException(s.grpc_status,fetch(status).message)))
        elseif result === nothing
            throw(TypeDBClientException("something went wrong in gRPC", gRPCServiceCallException(0, "Error not defined by gRPC")))
        end
    end
    f(result)
end
