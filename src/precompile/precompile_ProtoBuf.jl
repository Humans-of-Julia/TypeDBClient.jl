module Precompile_Protobuf

using ProtoBuf

function _precompile_()
    ccall(:jl_generating_output, Cint, ()) == 1 || return nothing
    @assert Base.precompile(Tuple{typeof(ProtoBuf.mapentry_meta),Type{Dict{AbstractString, AbstractString}}})   # time: 0.01447715
    @assert Base.precompile(Tuple{typeof(ProtoBuf.defaultval),Type{Float64}})   # time: 0.006835313
    @assert Base.precompile(Tuple{typeof(ProtoBuf.defaultval),Type{Dict{AbstractString, AbstractString}}})   # time: 0.005609422
    @assert Base.precompile(Tuple{typeof(ProtoBuf.wiretype),Type{Int32}})   # time: 0.004990235
    @assert Base.precompile(Tuple{typeof(ProtoBuf.wiretype),Type{Int64}})   # time: 0.00481454
    @assert Base.precompile(Tuple{typeof(ProtoBuf.write_varint),IOBuffer,Int32})   # time: 0.004749643
    @assert Base.precompile(Tuple{typeof(ProtoBuf.defaultval),Type{Int32}})   # time: 0.004422908
    @assert Base.precompile(Tuple{typeof(ProtoBuf.wiretype),Type{Vector{UInt8}}})   # time: 0.004197969
    @assert Base.precompile(Tuple{typeof(ProtoBuf.wiretype),Type{Float64}})   # time: 0.004151102
    @assert Base.precompile(Tuple{typeof(ProtoBuf.wiretype),Type{Dict{AbstractString, AbstractString}}})   # time: 0.004144187
#    @assert Base.precompile(Tuple{typeof(ProtoBuf.writeproto),IOBuffer,Vector{UInt8},ProtoMetaAttribs})   # time: 0.003951
    @assert Base.precompile(Tuple{typeof(ProtoBuf.defaultval),Type{Int64}})   # time: 0.003861888
#    @assert Base.precompile(Tuple{typeof(ProtoBuf.writeproto),IOBuffer,Int32,ProtoMetaAttribs})   # time: 0.002705993
    @assert Base.precompile(Tuple{typeof(ProtoBuf.defaultval),Type{Vector{UInt8}}})   # time: 0.001826776

    @info "Precompiling ProtoBuf done!"
end

end
