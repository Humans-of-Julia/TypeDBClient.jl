function grpc_result_or_error(result::T,
    status::Task,
    f::Function) where {T<:Union{<:Proto.ProtoType,<:Channel{<:Proto.ProtoType},<:Nothing}}
    if istaskdone(status)
        intern_status = fetch(status)
        ok = intern_status.success
    else
        ok = true
    end
    if ok == true && result !== nothing
        return f(result)
    elseif ok === false
        throw(GraknClientException(intern_status.message, gRPCServiceCallException(intern_status.message)))
    else
        throw(GraknClientException("something went wrong in gRPC", gRPCServiceCallException("Error not defined by gRPC")))
    end

end
