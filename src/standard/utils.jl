mutable struct Controller
    running::Bool
    duration_in_seconds::Number
end

function close(controller::Controller)
    controller.running = false
end

function sleeper(controller::Controller)
    sleep(controller.duration_in_seconds)
    controller.running = false
    return nothing
end

"""
    bytes(x)

Convert `x` to `Vector{UInt8}`.
"""
bytes(x::UUID) = collect(reinterpret(UInt8, [hton(x.value)]))

function bytes(s::String)
    chunks = (s[i:i+1] for i in 1:2:length(s)-1)  # 2-char chunks
    return parse.(UInt8, chunks; base = 16)
end

# Tracing data is a feature of grabl. No implementation for now.
tracing_data() = Dict{AbstractString, AbstractString}()

"""
copy_to_proto(from_object, to_proto_struct::Type{T}) where {T<: ProtoType}
    perform the conversation from a normal struct to a proto struct. The prerequisite
    for this is the naming of the variable of the normal struct according to
    the proto struct which is to be built.
"""
function copy_to_proto(from_object, to_proto_struct::Type{T}) where {T<: Proto.ProtoType}
    result_proto = to_proto_struct()
    for fname in fieldnames(typeof(from_object))
        if !hasproperty(result_proto, Symbol(fname)) && getfield(from_object,Symbol(fname)) !== nothing
            setproperty!(result_proto,Symbol(fname),getfield(from_object,Symbol(fname)))
        end
    end
    return result_proto
end

function _read_proto_number(proto_numeric::Proto.Numeric)
    kind_of_result = which_oneof(proto_numeric, :value)
    return getproperty(proto_numeric, kind_of_result)
end

"""
    safe_close(source_to_close)
Close a given resource which implementes the close functionalety
safely and only logs potential errors
"""
function safe_close(source_to_close)
    try
        close(source_to_close)
    catch ex
        @error "closing $source_to_close failed. \n
                reason: $ex"
    end
end

function safe_close(channel::Channel)
    if isready(channel)
        @info "There is something wrong with the channel management. \n
               Here an example what's in it:"
        last_item = fetch(channel)
        @info last_item
        func_id = which_oneof(last_item, :res)
        res = getproperty(last_item, func_id)
        @info "kind of item: $res"
    end
    close(channel)
end

function Base.close(inp::Vector{Timer})
    close.(inp)
end
