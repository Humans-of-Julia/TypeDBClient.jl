# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct Database_Contains_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Database_Contains_Req(; kwargs...)
        obj = new(meta(Database_Contains_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Database_Contains_Req
const __meta_Database_Contains_Req = Ref{ProtoMeta}()
function meta(::Type{Database_Contains_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Database_Contains_Req)
            __meta_Database_Contains_Req[] = target = ProtoMeta(Database_Contains_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:name => AbstractString]
            meta(target, Database_Contains_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Database_Contains_Req[]
    end
end
function Base.getproperty(obj::Database_Contains_Req, name::Symbol)
    if name === :name
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct Database_Contains_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Database_Contains_Res(; kwargs...)
        obj = new(meta(Database_Contains_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Database_Contains_Res
const __meta_Database_Contains_Res = Ref{ProtoMeta}()
function meta(::Type{Database_Contains_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Database_Contains_Res)
            __meta_Database_Contains_Res[] = target = ProtoMeta(Database_Contains_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:contains => Bool]
            meta(target, Database_Contains_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Database_Contains_Res[]
    end
end
function Base.getproperty(obj::Database_Contains_Res, name::Symbol)
    if name === :contains
        return (obj.__protobuf_jl_internal_values[name])::Bool
    else
        getfield(obj, name)
    end
end

mutable struct Database_Contains <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Database_Contains(; kwargs...)
        obj = new(meta(Database_Contains), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Database_Contains
const __meta_Database_Contains = Ref{ProtoMeta}()
function meta(::Type{Database_Contains})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Database_Contains)
            __meta_Database_Contains[] = target = ProtoMeta(Database_Contains)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Database_Contains, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Database_Contains[]
    end
end

mutable struct Database_Create_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Database_Create_Req(; kwargs...)
        obj = new(meta(Database_Create_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Database_Create_Req
const __meta_Database_Create_Req = Ref{ProtoMeta}()
function meta(::Type{Database_Create_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Database_Create_Req)
            __meta_Database_Create_Req[] = target = ProtoMeta(Database_Create_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:name => AbstractString]
            meta(target, Database_Create_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Database_Create_Req[]
    end
end
function Base.getproperty(obj::Database_Create_Req, name::Symbol)
    if name === :name
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct Database_Create_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Database_Create_Res(; kwargs...)
        obj = new(meta(Database_Create_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Database_Create_Res
const __meta_Database_Create_Res = Ref{ProtoMeta}()
function meta(::Type{Database_Create_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Database_Create_Res)
            __meta_Database_Create_Res[] = target = ProtoMeta(Database_Create_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Database_Create_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Database_Create_Res[]
    end
end

mutable struct Database_Create <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Database_Create(; kwargs...)
        obj = new(meta(Database_Create), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Database_Create
const __meta_Database_Create = Ref{ProtoMeta}()
function meta(::Type{Database_Create})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Database_Create)
            __meta_Database_Create[] = target = ProtoMeta(Database_Create)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Database_Create, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Database_Create[]
    end
end

mutable struct Database_All_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Database_All_Req(; kwargs...)
        obj = new(meta(Database_All_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Database_All_Req
const __meta_Database_All_Req = Ref{ProtoMeta}()
function meta(::Type{Database_All_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Database_All_Req)
            __meta_Database_All_Req[] = target = ProtoMeta(Database_All_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Database_All_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Database_All_Req[]
    end
end

mutable struct Database_All_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Database_All_Res(; kwargs...)
        obj = new(meta(Database_All_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Database_All_Res
const __meta_Database_All_Res = Ref{ProtoMeta}()
function meta(::Type{Database_All_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Database_All_Res)
            __meta_Database_All_Res[] = target = ProtoMeta(Database_All_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:names => Base.Vector{AbstractString}]
            meta(target, Database_All_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Database_All_Res[]
    end
end
function Base.getproperty(obj::Database_All_Res, name::Symbol)
    if name === :names
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{AbstractString}
    else
        getfield(obj, name)
    end
end

mutable struct Database_All <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Database_All(; kwargs...)
        obj = new(meta(Database_All), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Database_All
const __meta_Database_All = Ref{ProtoMeta}()
function meta(::Type{Database_All})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Database_All)
            __meta_Database_All[] = target = ProtoMeta(Database_All)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Database_All, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Database_All[]
    end
end

mutable struct Database_Delete_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Database_Delete_Req(; kwargs...)
        obj = new(meta(Database_Delete_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Database_Delete_Req
const __meta_Database_Delete_Req = Ref{ProtoMeta}()
function meta(::Type{Database_Delete_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Database_Delete_Req)
            __meta_Database_Delete_Req[] = target = ProtoMeta(Database_Delete_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:name => AbstractString]
            meta(target, Database_Delete_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Database_Delete_Req[]
    end
end
function Base.getproperty(obj::Database_Delete_Req, name::Symbol)
    if name === :name
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct Database_Delete_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Database_Delete_Res(; kwargs...)
        obj = new(meta(Database_Delete_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Database_Delete_Res
const __meta_Database_Delete_Res = Ref{ProtoMeta}()
function meta(::Type{Database_Delete_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Database_Delete_Res)
            __meta_Database_Delete_Res[] = target = ProtoMeta(Database_Delete_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Database_Delete_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Database_Delete_Res[]
    end
end

mutable struct Database_Delete <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Database_Delete(; kwargs...)
        obj = new(meta(Database_Delete), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Database_Delete
const __meta_Database_Delete = Ref{ProtoMeta}()
function meta(::Type{Database_Delete})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Database_Delete)
            __meta_Database_Delete[] = target = ProtoMeta(Database_Delete)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Database_Delete, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Database_Delete[]
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

export Database_Contains_Req, Database_Contains_Res, Database_Contains, Database_Create_Req, Database_Create_Res, Database_Create, Database_All_Req, Database_All_Res, Database_All, Database_Delete_Req, Database_Delete_Res, Database_Delete, Database
