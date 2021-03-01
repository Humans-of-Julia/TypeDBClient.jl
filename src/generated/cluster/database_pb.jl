# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct Database_Discover_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Database_Discover_Req(; kwargs...)
        obj = new(meta(Database_Discover_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Database_Discover_Req
const __meta_Database_Discover_Req = Ref{ProtoMeta}()
function meta(::Type{Database_Discover_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Database_Discover_Req)
            __meta_Database_Discover_Req[] = target = ProtoMeta(Database_Discover_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:database => AbstractString]
            meta(target, Database_Discover_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Database_Discover_Req[]
    end
end
function Base.getproperty(obj::Database_Discover_Req, name::Symbol)
    if name === :database
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct Database_Discover_Res_Replica <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Database_Discover_Res_Replica(; kwargs...)
        obj = new(meta(Database_Discover_Res_Replica), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Database_Discover_Res_Replica
const __meta_Database_Discover_Res_Replica = Ref{ProtoMeta}()
function meta(::Type{Database_Discover_Res_Replica})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Database_Discover_Res_Replica)
            __meta_Database_Discover_Res_Replica[] = target = ProtoMeta(Database_Discover_Res_Replica)
            allflds = Pair{Symbol,Union{Type,String}}[:address => AbstractString, :database => AbstractString, :is_leader => Bool, :term => Int64]
            meta(target, Database_Discover_Res_Replica, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Database_Discover_Res_Replica[]
    end
end
function Base.getproperty(obj::Database_Discover_Res_Replica, name::Symbol)
    if name === :address
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :database
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :is_leader
        return (obj.__protobuf_jl_internal_values[name])::Bool
    elseif name === :term
        return (obj.__protobuf_jl_internal_values[name])::Int64
    else
        getfield(obj, name)
    end
end

mutable struct Database_Discover_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Database_Discover_Res(; kwargs...)
        obj = new(meta(Database_Discover_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Database_Discover_Res
const __meta_Database_Discover_Res = Ref{ProtoMeta}()
function meta(::Type{Database_Discover_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Database_Discover_Res)
            __meta_Database_Discover_Res[] = target = ProtoMeta(Database_Discover_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:replicas => Base.Vector{Database_Discover_Res_Replica}]
            meta(target, Database_Discover_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Database_Discover_Res[]
    end
end
function Base.getproperty(obj::Database_Discover_Res, name::Symbol)
    if name === :replicas
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{Database_Discover_Res_Replica}
    else
        getfield(obj, name)
    end
end

mutable struct Database_Discover <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Database_Discover(; kwargs...)
        obj = new(meta(Database_Discover), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Database_Discover
const __meta_Database_Discover = Ref{ProtoMeta}()
function meta(::Type{Database_Discover})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Database_Discover)
            __meta_Database_Discover[] = target = ProtoMeta(Database_Discover)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Database_Discover, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Database_Discover[]
    end
end

mutable struct Database <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Database(; kwargs...)
        obj = new(meta(Database), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Database
const __meta_Database = Ref{ProtoMeta}()
function meta(::Type{Database})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Database)
            __meta_Database[] = target = ProtoMeta(Database)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Database, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Database[]
    end
end

export Database_Discover_Req, Database_Discover_Res_Replica, Database_Discover_Res, Database_Discover, Database
