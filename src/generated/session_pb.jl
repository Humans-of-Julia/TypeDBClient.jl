# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

const Session_Type = (;[
    Symbol("DATA") => Int32(0),
    Symbol("SCHEMA") => Int32(1),
]...)

mutable struct Session_Open_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Session_Open_Req(; kwargs...)
        obj = new(meta(Session_Open_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Session_Open_Req
const __meta_Session_Open_Req = Ref{ProtoMeta}()
function meta(::Type{Session_Open_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Session_Open_Req)
            __meta_Session_Open_Req[] = target = ProtoMeta(Session_Open_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:database => AbstractString, :_type => Int32, :options => Options]
            meta(target, Session_Open_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Session_Open_Req[]
    end
end
function Base.getproperty(obj::Session_Open_Req, name::Symbol)
    if name === :database
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :_type
        return (obj.__protobuf_jl_internal_values[name])::Int32
    elseif name === :options
        return (obj.__protobuf_jl_internal_values[name])::Options
    else
        getfield(obj, name)
    end
end

mutable struct Session_Open_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Session_Open_Res(; kwargs...)
        obj = new(meta(Session_Open_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Session_Open_Res
const __meta_Session_Open_Res = Ref{ProtoMeta}()
function meta(::Type{Session_Open_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Session_Open_Res)
            __meta_Session_Open_Res[] = target = ProtoMeta(Session_Open_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:session_id => Array{UInt8,1}, :server_duration_millis => Int32]
            meta(target, Session_Open_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Session_Open_Res[]
    end
end
function Base.getproperty(obj::Session_Open_Res, name::Symbol)
    if name === :session_id
        return (obj.__protobuf_jl_internal_values[name])::Array{UInt8,1}
    elseif name === :server_duration_millis
        return (obj.__protobuf_jl_internal_values[name])::Int32
    else
        getfield(obj, name)
    end
end

mutable struct Session_Open <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Session_Open(; kwargs...)
        obj = new(meta(Session_Open), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Session_Open
const __meta_Session_Open = Ref{ProtoMeta}()
function meta(::Type{Session_Open})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Session_Open)
            __meta_Session_Open[] = target = ProtoMeta(Session_Open)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Session_Open, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Session_Open[]
    end
end

mutable struct Session_Close_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Session_Close_Req(; kwargs...)
        obj = new(meta(Session_Close_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Session_Close_Req
const __meta_Session_Close_Req = Ref{ProtoMeta}()
function meta(::Type{Session_Close_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Session_Close_Req)
            __meta_Session_Close_Req[] = target = ProtoMeta(Session_Close_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:session_id => Array{UInt8,1}]
            meta(target, Session_Close_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Session_Close_Req[]
    end
end
function Base.getproperty(obj::Session_Close_Req, name::Symbol)
    if name === :session_id
        return (obj.__protobuf_jl_internal_values[name])::Array{UInt8,1}
    else
        getfield(obj, name)
    end
end

mutable struct Session_Close_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Session_Close_Res(; kwargs...)
        obj = new(meta(Session_Close_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Session_Close_Res
const __meta_Session_Close_Res = Ref{ProtoMeta}()
function meta(::Type{Session_Close_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Session_Close_Res)
            __meta_Session_Close_Res[] = target = ProtoMeta(Session_Close_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Session_Close_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Session_Close_Res[]
    end
end

mutable struct Session_Close <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Session_Close(; kwargs...)
        obj = new(meta(Session_Close), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Session_Close
const __meta_Session_Close = Ref{ProtoMeta}()
function meta(::Type{Session_Close})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Session_Close)
            __meta_Session_Close[] = target = ProtoMeta(Session_Close)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Session_Close, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Session_Close[]
    end
end

mutable struct Session_Pulse_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Session_Pulse_Req(; kwargs...)
        obj = new(meta(Session_Pulse_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Session_Pulse_Req
const __meta_Session_Pulse_Req = Ref{ProtoMeta}()
function meta(::Type{Session_Pulse_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Session_Pulse_Req)
            __meta_Session_Pulse_Req[] = target = ProtoMeta(Session_Pulse_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:session_id => Array{UInt8,1}]
            meta(target, Session_Pulse_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Session_Pulse_Req[]
    end
end
function Base.getproperty(obj::Session_Pulse_Req, name::Symbol)
    if name === :session_id
        return (obj.__protobuf_jl_internal_values[name])::Array{UInt8,1}
    else
        getfield(obj, name)
    end
end

mutable struct Session_Pulse_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Session_Pulse_Res(; kwargs...)
        obj = new(meta(Session_Pulse_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Session_Pulse_Res
const __meta_Session_Pulse_Res = Ref{ProtoMeta}()
function meta(::Type{Session_Pulse_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Session_Pulse_Res)
            __meta_Session_Pulse_Res[] = target = ProtoMeta(Session_Pulse_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:alive => Bool]
            meta(target, Session_Pulse_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Session_Pulse_Res[]
    end
end
function Base.getproperty(obj::Session_Pulse_Res, name::Symbol)
    if name === :alive
        return (obj.__protobuf_jl_internal_values[name])::Bool
    else
        getfield(obj, name)
    end
end

mutable struct Session_Pulse <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Session_Pulse(; kwargs...)
        obj = new(meta(Session_Pulse), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Session_Pulse
const __meta_Session_Pulse = Ref{ProtoMeta}()
function meta(::Type{Session_Pulse})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Session_Pulse)
            __meta_Session_Pulse[] = target = ProtoMeta(Session_Pulse)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Session_Pulse, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Session_Pulse[]
    end
end

mutable struct Session <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Session(; kwargs...)
        obj = new(meta(Session), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Session
const __meta_Session = Ref{ProtoMeta}()
function meta(::Type{Session})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Session)
            __meta_Session[] = target = ProtoMeta(Session)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Session, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Session[]
    end
end

export Session_Type, Session_Open_Req, Session_Open_Res, Session_Open, Session_Close_Req, Session_Close_Res, Session_Close, Session_Pulse_Req, Session_Pulse_Res, Session_Pulse, Session
