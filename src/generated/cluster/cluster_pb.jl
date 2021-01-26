# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct Cluster_Discover_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Cluster_Discover_Req(; kwargs...)
        obj = new(meta(Cluster_Discover_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Cluster_Discover_Req
const __meta_Cluster_Discover_Req = Ref{ProtoMeta}()
function meta(::Type{Cluster_Discover_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Cluster_Discover_Req)
            __meta_Cluster_Discover_Req[] = target = ProtoMeta(Cluster_Discover_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Cluster_Discover_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Cluster_Discover_Req[]
    end
end

mutable struct Cluster_Discover_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Cluster_Discover_Res(; kwargs...)
        obj = new(meta(Cluster_Discover_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Cluster_Discover_Res
const __meta_Cluster_Discover_Res = Ref{ProtoMeta}()
function meta(::Type{Cluster_Discover_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Cluster_Discover_Res)
            __meta_Cluster_Discover_Res[] = target = ProtoMeta(Cluster_Discover_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:servers => Base.Vector{AbstractString}]
            meta(target, Cluster_Discover_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Cluster_Discover_Res[]
    end
end
function Base.getproperty(obj::Cluster_Discover_Res, name::Symbol)
    if name === :servers
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{AbstractString}
    else
        getfield(obj, name)
    end
end

mutable struct Cluster_Discover <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Cluster_Discover(; kwargs...)
        obj = new(meta(Cluster_Discover), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Cluster_Discover
const __meta_Cluster_Discover = Ref{ProtoMeta}()
function meta(::Type{Cluster_Discover})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Cluster_Discover)
            __meta_Cluster_Discover[] = target = ProtoMeta(Cluster_Discover)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Cluster_Discover, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Cluster_Discover[]
    end
end

mutable struct Cluster <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Cluster(; kwargs...)
        obj = new(meta(Cluster), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Cluster
const __meta_Cluster = Ref{ProtoMeta}()
function meta(::Type{Cluster})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Cluster)
            __meta_Cluster[] = target = ProtoMeta(Cluster)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Cluster, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Cluster[]
    end
end

export Cluster_Discover_Req, Cluster_Discover_Res, Cluster_Discover, Cluster
