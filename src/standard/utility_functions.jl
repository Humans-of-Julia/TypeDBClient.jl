"""
    bytes(x::UUID) produces an array of UInt8 with the right
    endian.
"""
bytes(x::UUID) = collect(reinterpret(UInt8, [hton(x.value)]))

"""
copy_to_proto(from_object, to_proto_struct::Type{T}) where {T<: ProtoType}
    perform the conversation from a normal struct to a proto struct. The prerequisite
    for this is the naming of the variable of the normal struct according to
    the proto struct which is to be built.
"""
function copy_to_proto(from_object, to_proto_struct::Type{T}) where {T<: ProtoType}
    result_proto = to_proto_struct()
    for fname in fieldnames(typeof(from_object))
        if !hasproperty(result_proto, Symbol(fname)) && getfield(from_object,Symbol(fname)) !== nothing
            setproperty!(result_proto,Symbol(fname),getfield(from_object,Symbol(fname)))
        end
    end
    return result_proto
end
