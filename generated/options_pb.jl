# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct Options <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Options(; kwargs...)
        obj = new(meta(Options), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
        end
        obj
    end
end # mutable struct Options
const __meta_Options = Ref{ProtoMeta}()
function meta(::Type{Options})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Options)
            __meta_Options[] = target = ProtoMeta(Options)
            allflds = Pair{Symbol,Union{Type,String}}[:infer => Bool, :trace_inference => Bool, :explain => Bool, :parallel => Bool, :prefetch_size => Int32, :prefetch => Bool, :session_idle_timeout_millis => Int32, :schema_lock_acquire_timeout_millis => Int32, :read_any_replica => Bool]
            oneofs = Int[1,2,3,4,5,6,7,8,9]
            oneof_names = Symbol[Symbol("infer_opt"),Symbol("trace_inference_opt"),Symbol("explain_opt"),Symbol("parallel_opt"),Symbol("prefetch_size_opt"),Symbol("prefetch_opt"),Symbol("session_idle_timeout_opt"),Symbol("schema_lock_acquire_timeout_opt"),Symbol("read_any_replica_opt")]
            meta(target, Options, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Options[]
    end
end
function Base.getproperty(obj::Options, name::Symbol)
    if name === :infer
        return (obj.__protobuf_jl_internal_values[name])::Bool
    elseif name === :trace_inference
        return (obj.__protobuf_jl_internal_values[name])::Bool
    elseif name === :explain
        return (obj.__protobuf_jl_internal_values[name])::Bool
    elseif name === :parallel
        return (obj.__protobuf_jl_internal_values[name])::Bool
    elseif name === :prefetch_size
        return (obj.__protobuf_jl_internal_values[name])::Int32
    elseif name === :prefetch
        return (obj.__protobuf_jl_internal_values[name])::Bool
    elseif name === :session_idle_timeout_millis
        return (obj.__protobuf_jl_internal_values[name])::Int32
    elseif name === :schema_lock_acquire_timeout_millis
        return (obj.__protobuf_jl_internal_values[name])::Int32
    elseif name === :read_any_replica
        return (obj.__protobuf_jl_internal_values[name])::Bool
    else
        getfield(obj, name)
    end
end

export Options
