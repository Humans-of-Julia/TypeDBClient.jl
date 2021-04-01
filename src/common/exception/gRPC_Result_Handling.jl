function grpc_result_or_error(result::T,
    status::Task,
    f::Function) where {T<:Union{<:ProtoType,<:Channel{<:ProtoType},<:Nothing}}
    intern_status = fetch(status)
    ok = intern_status.success
    if ok == true && result !== nothing
        return f(result)
    elseif ok === false
        throw(GraknClientException(intern_Status.message, gRPCException(intern_status.message)))
    else
        throw(GraknClientException("something went wrong in gRPC", gRPCException("Error not defined by gRPC")))
    end

end
