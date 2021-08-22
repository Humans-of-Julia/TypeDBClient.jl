# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct CoreDatabaseManager_Contains_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function CoreDatabaseManager_Contains_Req(; kwargs...)
        obj = new(meta(CoreDatabaseManager_Contains_Req), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct CoreDatabaseManager_Contains_Req
const __meta_CoreDatabaseManager_Contains_Req = Ref{ProtoMeta}()
function meta(::Type{CoreDatabaseManager_Contains_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_CoreDatabaseManager_Contains_Req)
            __meta_CoreDatabaseManager_Contains_Req[] = target = ProtoMeta(CoreDatabaseManager_Contains_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:name => AbstractString]
            meta(target, CoreDatabaseManager_Contains_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_CoreDatabaseManager_Contains_Req[]
    end
end
function Base.getproperty(obj::CoreDatabaseManager_Contains_Req, name::Symbol)
    if name === :name
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct CoreDatabaseManager_Contains_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function CoreDatabaseManager_Contains_Res(; kwargs...)
        obj = new(meta(CoreDatabaseManager_Contains_Res), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct CoreDatabaseManager_Contains_Res
const __meta_CoreDatabaseManager_Contains_Res = Ref{ProtoMeta}()
function meta(::Type{CoreDatabaseManager_Contains_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_CoreDatabaseManager_Contains_Res)
            __meta_CoreDatabaseManager_Contains_Res[] = target = ProtoMeta(CoreDatabaseManager_Contains_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:contains => Bool]
            meta(target, CoreDatabaseManager_Contains_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_CoreDatabaseManager_Contains_Res[]
    end
end
function Base.getproperty(obj::CoreDatabaseManager_Contains_Res, name::Symbol)
    if name === :contains
        return (obj.__protobuf_jl_internal_values[name])::Bool
    else
        getfield(obj, name)
    end
end

mutable struct CoreDatabaseManager_Contains <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function CoreDatabaseManager_Contains(; kwargs...)
        obj = new(meta(CoreDatabaseManager_Contains), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct CoreDatabaseManager_Contains
const __meta_CoreDatabaseManager_Contains = Ref{ProtoMeta}()
function meta(::Type{CoreDatabaseManager_Contains})
    ProtoBuf.metalock() do
        if !isassigned(__meta_CoreDatabaseManager_Contains)
            __meta_CoreDatabaseManager_Contains[] = target = ProtoMeta(CoreDatabaseManager_Contains)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, CoreDatabaseManager_Contains, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_CoreDatabaseManager_Contains[]
    end
end

mutable struct CoreDatabaseManager_Create_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function CoreDatabaseManager_Create_Req(; kwargs...)
        obj = new(meta(CoreDatabaseManager_Create_Req), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct CoreDatabaseManager_Create_Req
const __meta_CoreDatabaseManager_Create_Req = Ref{ProtoMeta}()
function meta(::Type{CoreDatabaseManager_Create_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_CoreDatabaseManager_Create_Req)
            __meta_CoreDatabaseManager_Create_Req[] = target = ProtoMeta(CoreDatabaseManager_Create_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:name => AbstractString]
            meta(target, CoreDatabaseManager_Create_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_CoreDatabaseManager_Create_Req[]
    end
end
function Base.getproperty(obj::CoreDatabaseManager_Create_Req, name::Symbol)
    if name === :name
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct CoreDatabaseManager_Create_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function CoreDatabaseManager_Create_Res(; kwargs...)
        obj = new(meta(CoreDatabaseManager_Create_Res), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct CoreDatabaseManager_Create_Res
const __meta_CoreDatabaseManager_Create_Res = Ref{ProtoMeta}()
function meta(::Type{CoreDatabaseManager_Create_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_CoreDatabaseManager_Create_Res)
            __meta_CoreDatabaseManager_Create_Res[] = target = ProtoMeta(CoreDatabaseManager_Create_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, CoreDatabaseManager_Create_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_CoreDatabaseManager_Create_Res[]
    end
end

mutable struct CoreDatabaseManager_Create <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function CoreDatabaseManager_Create(; kwargs...)
        obj = new(meta(CoreDatabaseManager_Create), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct CoreDatabaseManager_Create
const __meta_CoreDatabaseManager_Create = Ref{ProtoMeta}()
function meta(::Type{CoreDatabaseManager_Create})
    ProtoBuf.metalock() do
        if !isassigned(__meta_CoreDatabaseManager_Create)
            __meta_CoreDatabaseManager_Create[] = target = ProtoMeta(CoreDatabaseManager_Create)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, CoreDatabaseManager_Create, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_CoreDatabaseManager_Create[]
    end
end

mutable struct CoreDatabaseManager_All_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function CoreDatabaseManager_All_Req(; kwargs...)
        obj = new(meta(CoreDatabaseManager_All_Req), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct CoreDatabaseManager_All_Req
const __meta_CoreDatabaseManager_All_Req = Ref{ProtoMeta}()
function meta(::Type{CoreDatabaseManager_All_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_CoreDatabaseManager_All_Req)
            __meta_CoreDatabaseManager_All_Req[] = target = ProtoMeta(CoreDatabaseManager_All_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, CoreDatabaseManager_All_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_CoreDatabaseManager_All_Req[]
    end
end

mutable struct CoreDatabaseManager_All_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function CoreDatabaseManager_All_Res(; kwargs...)
        obj = new(meta(CoreDatabaseManager_All_Res), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct CoreDatabaseManager_All_Res
const __meta_CoreDatabaseManager_All_Res = Ref{ProtoMeta}()
function meta(::Type{CoreDatabaseManager_All_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_CoreDatabaseManager_All_Res)
            __meta_CoreDatabaseManager_All_Res[] = target = ProtoMeta(CoreDatabaseManager_All_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:names => Base.Vector{AbstractString}]
            meta(target, CoreDatabaseManager_All_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_CoreDatabaseManager_All_Res[]
    end
end
function Base.getproperty(obj::CoreDatabaseManager_All_Res, name::Symbol)
    if name === :names
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{AbstractString}
    else
        getfield(obj, name)
    end
end

mutable struct CoreDatabaseManager_All <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function CoreDatabaseManager_All(; kwargs...)
        obj = new(meta(CoreDatabaseManager_All), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct CoreDatabaseManager_All
const __meta_CoreDatabaseManager_All = Ref{ProtoMeta}()
function meta(::Type{CoreDatabaseManager_All})
    ProtoBuf.metalock() do
        if !isassigned(__meta_CoreDatabaseManager_All)
            __meta_CoreDatabaseManager_All[] = target = ProtoMeta(CoreDatabaseManager_All)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, CoreDatabaseManager_All, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_CoreDatabaseManager_All[]
    end
end

mutable struct CoreDatabaseManager <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function CoreDatabaseManager(; kwargs...)
        obj = new(meta(CoreDatabaseManager), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct CoreDatabaseManager
const __meta_CoreDatabaseManager = Ref{ProtoMeta}()
function meta(::Type{CoreDatabaseManager})
    ProtoBuf.metalock() do
        if !isassigned(__meta_CoreDatabaseManager)
            __meta_CoreDatabaseManager[] = target = ProtoMeta(CoreDatabaseManager)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, CoreDatabaseManager, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_CoreDatabaseManager[]
    end
end

mutable struct CoreDatabase_Schema_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function CoreDatabase_Schema_Req(; kwargs...)
        obj = new(meta(CoreDatabase_Schema_Req), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct CoreDatabase_Schema_Req
const __meta_CoreDatabase_Schema_Req = Ref{ProtoMeta}()
function meta(::Type{CoreDatabase_Schema_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_CoreDatabase_Schema_Req)
            __meta_CoreDatabase_Schema_Req[] = target = ProtoMeta(CoreDatabase_Schema_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:name => AbstractString]
            meta(target, CoreDatabase_Schema_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_CoreDatabase_Schema_Req[]
    end
end
function Base.getproperty(obj::CoreDatabase_Schema_Req, name::Symbol)
    if name === :name
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct CoreDatabase_Schema_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function CoreDatabase_Schema_Res(; kwargs...)
        obj = new(meta(CoreDatabase_Schema_Res), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct CoreDatabase_Schema_Res
const __meta_CoreDatabase_Schema_Res = Ref{ProtoMeta}()
function meta(::Type{CoreDatabase_Schema_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_CoreDatabase_Schema_Res)
            __meta_CoreDatabase_Schema_Res[] = target = ProtoMeta(CoreDatabase_Schema_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:schema => AbstractString]
            meta(target, CoreDatabase_Schema_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_CoreDatabase_Schema_Res[]
    end
end
function Base.getproperty(obj::CoreDatabase_Schema_Res, name::Symbol)
    if name === :schema
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct CoreDatabase_Schema <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function CoreDatabase_Schema(; kwargs...)
        obj = new(meta(CoreDatabase_Schema), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct CoreDatabase_Schema
const __meta_CoreDatabase_Schema = Ref{ProtoMeta}()
function meta(::Type{CoreDatabase_Schema})
    ProtoBuf.metalock() do
        if !isassigned(__meta_CoreDatabase_Schema)
            __meta_CoreDatabase_Schema[] = target = ProtoMeta(CoreDatabase_Schema)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, CoreDatabase_Schema, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_CoreDatabase_Schema[]
    end
end

mutable struct CoreDatabase_Delete_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function CoreDatabase_Delete_Req(; kwargs...)
        obj = new(meta(CoreDatabase_Delete_Req), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct CoreDatabase_Delete_Req
const __meta_CoreDatabase_Delete_Req = Ref{ProtoMeta}()
function meta(::Type{CoreDatabase_Delete_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_CoreDatabase_Delete_Req)
            __meta_CoreDatabase_Delete_Req[] = target = ProtoMeta(CoreDatabase_Delete_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:name => AbstractString]
            meta(target, CoreDatabase_Delete_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_CoreDatabase_Delete_Req[]
    end
end
function Base.getproperty(obj::CoreDatabase_Delete_Req, name::Symbol)
    if name === :name
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct CoreDatabase_Delete_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function CoreDatabase_Delete_Res(; kwargs...)
        obj = new(meta(CoreDatabase_Delete_Res), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct CoreDatabase_Delete_Res
const __meta_CoreDatabase_Delete_Res = Ref{ProtoMeta}()
function meta(::Type{CoreDatabase_Delete_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_CoreDatabase_Delete_Res)
            __meta_CoreDatabase_Delete_Res[] = target = ProtoMeta(CoreDatabase_Delete_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, CoreDatabase_Delete_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_CoreDatabase_Delete_Res[]
    end
end

mutable struct CoreDatabase_Delete <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function CoreDatabase_Delete(; kwargs...)
        obj = new(meta(CoreDatabase_Delete), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct CoreDatabase_Delete
const __meta_CoreDatabase_Delete = Ref{ProtoMeta}()
function meta(::Type{CoreDatabase_Delete})
    ProtoBuf.metalock() do
        if !isassigned(__meta_CoreDatabase_Delete)
            __meta_CoreDatabase_Delete[] = target = ProtoMeta(CoreDatabase_Delete)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, CoreDatabase_Delete, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_CoreDatabase_Delete[]
    end
end

mutable struct CoreDatabase <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function CoreDatabase(; kwargs...)
        obj = new(meta(CoreDatabase), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct CoreDatabase
const __meta_CoreDatabase = Ref{ProtoMeta}()
function meta(::Type{CoreDatabase})
    ProtoBuf.metalock() do
        if !isassigned(__meta_CoreDatabase)
            __meta_CoreDatabase[] = target = ProtoMeta(CoreDatabase)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, CoreDatabase, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_CoreDatabase[]
    end
end

export CoreDatabaseManager_Contains_Req, CoreDatabaseManager_Contains_Res, CoreDatabaseManager_Contains, CoreDatabaseManager_Create_Req, CoreDatabaseManager_Create_Res, CoreDatabaseManager_Create, CoreDatabaseManager_All_Req, CoreDatabaseManager_All_Res, CoreDatabaseManager_All, CoreDatabaseManager, CoreDatabase_Schema_Req, CoreDatabase_Schema_Res, CoreDatabase_Schema, CoreDatabase_Delete_Req, CoreDatabase_Delete_Res, CoreDatabase_Delete, CoreDatabase
