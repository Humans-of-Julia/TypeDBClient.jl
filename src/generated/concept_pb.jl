# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct ConceptManager_GetThingType_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager_GetThingType_Req(; kwargs...)
        obj = new(meta(ConceptManager_GetThingType_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager_GetThingType_Req
const __meta_ConceptManager_GetThingType_Req = Ref{ProtoMeta}()
function meta(::Type{ConceptManager_GetThingType_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager_GetThingType_Req)
            __meta_ConceptManager_GetThingType_Req[] = target = ProtoMeta(ConceptManager_GetThingType_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:label => AbstractString]
            meta(target, ConceptManager_GetThingType_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptManager_GetThingType_Req[]
    end
end
function Base.getproperty(obj::ConceptManager_GetThingType_Req, name::Symbol)
    if name === :label
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct ConceptManager_GetThingType <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager_GetThingType(; kwargs...)
        obj = new(meta(ConceptManager_GetThingType), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager_GetThingType
const __meta_ConceptManager_GetThingType = Ref{ProtoMeta}()
function meta(::Type{ConceptManager_GetThingType})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager_GetThingType)
            __meta_ConceptManager_GetThingType[] = target = ProtoMeta(ConceptManager_GetThingType)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ConceptManager_GetThingType, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptManager_GetThingType[]
    end
end

mutable struct ConceptManager_GetThing_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager_GetThing_Req(; kwargs...)
        obj = new(meta(ConceptManager_GetThing_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager_GetThing_Req
const __meta_ConceptManager_GetThing_Req = Ref{ProtoMeta}()
function meta(::Type{ConceptManager_GetThing_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager_GetThing_Req)
            __meta_ConceptManager_GetThing_Req[] = target = ProtoMeta(ConceptManager_GetThing_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:iid => Vector{UInt8}]
            meta(target, ConceptManager_GetThing_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptManager_GetThing_Req[]
    end
end
function Base.getproperty(obj::ConceptManager_GetThing_Req, name::Symbol)
    if name === :iid
        return (obj.__protobuf_jl_internal_values[name])::Vector{UInt8}
    else
        getfield(obj, name)
    end
end

mutable struct ConceptManager_GetThing <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager_GetThing(; kwargs...)
        obj = new(meta(ConceptManager_GetThing), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager_GetThing
const __meta_ConceptManager_GetThing = Ref{ProtoMeta}()
function meta(::Type{ConceptManager_GetThing})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager_GetThing)
            __meta_ConceptManager_GetThing[] = target = ProtoMeta(ConceptManager_GetThing)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ConceptManager_GetThing, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptManager_GetThing[]
    end
end

mutable struct ConceptManager_PutEntityType_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager_PutEntityType_Req(; kwargs...)
        obj = new(meta(ConceptManager_PutEntityType_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager_PutEntityType_Req
const __meta_ConceptManager_PutEntityType_Req = Ref{ProtoMeta}()
function meta(::Type{ConceptManager_PutEntityType_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager_PutEntityType_Req)
            __meta_ConceptManager_PutEntityType_Req[] = target = ProtoMeta(ConceptManager_PutEntityType_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:label => AbstractString]
            meta(target, ConceptManager_PutEntityType_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptManager_PutEntityType_Req[]
    end
end
function Base.getproperty(obj::ConceptManager_PutEntityType_Req, name::Symbol)
    if name === :label
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct ConceptManager_PutEntityType <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager_PutEntityType(; kwargs...)
        obj = new(meta(ConceptManager_PutEntityType), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager_PutEntityType
const __meta_ConceptManager_PutEntityType = Ref{ProtoMeta}()
function meta(::Type{ConceptManager_PutEntityType})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager_PutEntityType)
            __meta_ConceptManager_PutEntityType[] = target = ProtoMeta(ConceptManager_PutEntityType)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ConceptManager_PutEntityType, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptManager_PutEntityType[]
    end
end

mutable struct ConceptManager_PutAttributeType_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager_PutAttributeType_Req(; kwargs...)
        obj = new(meta(ConceptManager_PutAttributeType_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager_PutAttributeType_Req
const __meta_ConceptManager_PutAttributeType_Req = Ref{ProtoMeta}()
function meta(::Type{ConceptManager_PutAttributeType_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager_PutAttributeType_Req)
            __meta_ConceptManager_PutAttributeType_Req[] = target = ProtoMeta(ConceptManager_PutAttributeType_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:label => AbstractString, :value_type => Int32]
            meta(target, ConceptManager_PutAttributeType_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptManager_PutAttributeType_Req[]
    end
end
function Base.getproperty(obj::ConceptManager_PutAttributeType_Req, name::Symbol)
    if name === :label
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :value_type
        return (obj.__protobuf_jl_internal_values[name])::Int32
    else
        getfield(obj, name)
    end
end

mutable struct ConceptManager_PutAttributeType <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager_PutAttributeType(; kwargs...)
        obj = new(meta(ConceptManager_PutAttributeType), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager_PutAttributeType
const __meta_ConceptManager_PutAttributeType = Ref{ProtoMeta}()
function meta(::Type{ConceptManager_PutAttributeType})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager_PutAttributeType)
            __meta_ConceptManager_PutAttributeType[] = target = ProtoMeta(ConceptManager_PutAttributeType)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ConceptManager_PutAttributeType, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptManager_PutAttributeType[]
    end
end

mutable struct ConceptManager_PutRelationType_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager_PutRelationType_Req(; kwargs...)
        obj = new(meta(ConceptManager_PutRelationType_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager_PutRelationType_Req
const __meta_ConceptManager_PutRelationType_Req = Ref{ProtoMeta}()
function meta(::Type{ConceptManager_PutRelationType_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager_PutRelationType_Req)
            __meta_ConceptManager_PutRelationType_Req[] = target = ProtoMeta(ConceptManager_PutRelationType_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:label => AbstractString]
            meta(target, ConceptManager_PutRelationType_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptManager_PutRelationType_Req[]
    end
end
function Base.getproperty(obj::ConceptManager_PutRelationType_Req, name::Symbol)
    if name === :label
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct ConceptManager_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager_Req(; kwargs...)
        obj = new(meta(ConceptManager_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager_Req
const __meta_ConceptManager_Req = Ref{ProtoMeta}()
function meta(::Type{ConceptManager_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager_Req)
            __meta_ConceptManager_Req[] = target = ProtoMeta(ConceptManager_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:get_thing_type_req => ConceptManager_GetThingType_Req, :get_thing_req => ConceptManager_GetThing_Req, :put_entity_type_req => ConceptManager_PutEntityType_Req, :put_attribute_type_req => ConceptManager_PutAttributeType_Req, :put_relation_type_req => ConceptManager_PutRelationType_Req]
            oneofs = Int[1,1,1,1,1]
            oneof_names = Symbol[Symbol("req")]
            meta(target, ConceptManager_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_ConceptManager_Req[]
    end
end
function Base.getproperty(obj::ConceptManager_Req, name::Symbol)
    if name === :get_thing_type_req
        return (obj.__protobuf_jl_internal_values[name])::ConceptManager_GetThingType_Req
    elseif name === :get_thing_req
        return (obj.__protobuf_jl_internal_values[name])::ConceptManager_GetThing_Req
    elseif name === :put_entity_type_req
        return (obj.__protobuf_jl_internal_values[name])::ConceptManager_PutEntityType_Req
    elseif name === :put_attribute_type_req
        return (obj.__protobuf_jl_internal_values[name])::ConceptManager_PutAttributeType_Req
    elseif name === :put_relation_type_req
        return (obj.__protobuf_jl_internal_values[name])::ConceptManager_PutRelationType_Req
    else
        getfield(obj, name)
    end
end

mutable struct ConceptManager_PutRelationType <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager_PutRelationType(; kwargs...)
        obj = new(meta(ConceptManager_PutRelationType), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager_PutRelationType
const __meta_ConceptManager_PutRelationType = Ref{ProtoMeta}()
function meta(::Type{ConceptManager_PutRelationType})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager_PutRelationType)
            __meta_ConceptManager_PutRelationType[] = target = ProtoMeta(ConceptManager_PutRelationType)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ConceptManager_PutRelationType, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptManager_PutRelationType[]
    end
end

mutable struct ConceptManager <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager(; kwargs...)
        obj = new(meta(ConceptManager), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager
const __meta_ConceptManager = Ref{ProtoMeta}()
function meta(::Type{ConceptManager})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager)
            __meta_ConceptManager[] = target = ProtoMeta(ConceptManager)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ConceptManager, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptManager[]
    end
end

mutable struct Relation_AddPlayer_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Relation_AddPlayer_Res(; kwargs...)
        obj = new(meta(Relation_AddPlayer_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Relation_AddPlayer_Res
const __meta_Relation_AddPlayer_Res = Ref{ProtoMeta}()
function meta(::Type{Relation_AddPlayer_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Relation_AddPlayer_Res)
            __meta_Relation_AddPlayer_Res[] = target = ProtoMeta(Relation_AddPlayer_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Relation_AddPlayer_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Relation_AddPlayer_Res[]
    end
end

mutable struct Relation_AddPlayer <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Relation_AddPlayer(; kwargs...)
        obj = new(meta(Relation_AddPlayer), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Relation_AddPlayer
const __meta_Relation_AddPlayer = Ref{ProtoMeta}()
function meta(::Type{Relation_AddPlayer})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Relation_AddPlayer)
            __meta_Relation_AddPlayer[] = target = ProtoMeta(Relation_AddPlayer)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Relation_AddPlayer, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Relation_AddPlayer[]
    end
end

mutable struct Relation_RemovePlayer_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Relation_RemovePlayer_Res(; kwargs...)
        obj = new(meta(Relation_RemovePlayer_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Relation_RemovePlayer_Res
const __meta_Relation_RemovePlayer_Res = Ref{ProtoMeta}()
function meta(::Type{Relation_RemovePlayer_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Relation_RemovePlayer_Res)
            __meta_Relation_RemovePlayer_Res[] = target = ProtoMeta(Relation_RemovePlayer_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Relation_RemovePlayer_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Relation_RemovePlayer_Res[]
    end
end

mutable struct Relation_RemovePlayer <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Relation_RemovePlayer(; kwargs...)
        obj = new(meta(Relation_RemovePlayer), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Relation_RemovePlayer
const __meta_Relation_RemovePlayer = Ref{ProtoMeta}()
function meta(::Type{Relation_RemovePlayer})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Relation_RemovePlayer)
            __meta_Relation_RemovePlayer[] = target = ProtoMeta(Relation_RemovePlayer)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Relation_RemovePlayer, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Relation_RemovePlayer[]
    end
end

mutable struct Relation_GetPlayers <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Relation_GetPlayers(; kwargs...)
        obj = new(meta(Relation_GetPlayers), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Relation_GetPlayers
const __meta_Relation_GetPlayers = Ref{ProtoMeta}()
function meta(::Type{Relation_GetPlayers})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Relation_GetPlayers)
            __meta_Relation_GetPlayers[] = target = ProtoMeta(Relation_GetPlayers)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Relation_GetPlayers, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Relation_GetPlayers[]
    end
end

mutable struct Relation_GetPlayersByRoleType_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Relation_GetPlayersByRoleType_Req(; kwargs...)
        obj = new(meta(Relation_GetPlayersByRoleType_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Relation_GetPlayersByRoleType_Req
const __meta_Relation_GetPlayersByRoleType_Req = Ref{ProtoMeta}()
function meta(::Type{Relation_GetPlayersByRoleType_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Relation_GetPlayersByRoleType_Req)
            __meta_Relation_GetPlayersByRoleType_Req[] = target = ProtoMeta(Relation_GetPlayersByRoleType_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Relation_GetPlayersByRoleType_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Relation_GetPlayersByRoleType_Req[]
    end
end

mutable struct Relation_GetPlayersByRoleType <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Relation_GetPlayersByRoleType(; kwargs...)
        obj = new(meta(Relation_GetPlayersByRoleType), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Relation_GetPlayersByRoleType
const __meta_Relation_GetPlayersByRoleType = Ref{ProtoMeta}()
function meta(::Type{Relation_GetPlayersByRoleType})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Relation_GetPlayersByRoleType)
            __meta_Relation_GetPlayersByRoleType[] = target = ProtoMeta(Relation_GetPlayersByRoleType)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Relation_GetPlayersByRoleType, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Relation_GetPlayersByRoleType[]
    end
end

mutable struct Relation_GetRelating_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Relation_GetRelating_Req(; kwargs...)
        obj = new(meta(Relation_GetRelating_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Relation_GetRelating_Req
const __meta_Relation_GetRelating_Req = Ref{ProtoMeta}()
function meta(::Type{Relation_GetRelating_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Relation_GetRelating_Req)
            __meta_Relation_GetRelating_Req[] = target = ProtoMeta(Relation_GetRelating_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Relation_GetRelating_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Relation_GetRelating_Req[]
    end
end

mutable struct Relation_GetRelating <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Relation_GetRelating(; kwargs...)
        obj = new(meta(Relation_GetRelating), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Relation_GetRelating
const __meta_Relation_GetRelating = Ref{ProtoMeta}()
function meta(::Type{Relation_GetRelating})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Relation_GetRelating)
            __meta_Relation_GetRelating[] = target = ProtoMeta(Relation_GetRelating)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Relation_GetRelating, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Relation_GetRelating[]
    end
end

mutable struct Relation <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Relation(; kwargs...)
        obj = new(meta(Relation), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Relation
const __meta_Relation = Ref{ProtoMeta}()
function meta(::Type{Relation})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Relation)
            __meta_Relation[] = target = ProtoMeta(Relation)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Relation, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Relation[]
    end
end

mutable struct Attribute_Value <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Attribute_Value(; kwargs...)
        obj = new(meta(Attribute_Value), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Attribute_Value
const __meta_Attribute_Value = Ref{ProtoMeta}()
function meta(::Type{Attribute_Value})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Attribute_Value)
            __meta_Attribute_Value[] = target = ProtoMeta(Attribute_Value)
            allflds = Pair{Symbol,Union{Type,String}}[:string => AbstractString, :boolean => Bool, :long => Int64, :double => Float64, :date_time => Int64]
            oneofs = Int[1,1,1,1,1]
            oneof_names = Symbol[Symbol("value")]
            meta(target, Attribute_Value, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Attribute_Value[]
    end
end
function Base.getproperty(obj::Attribute_Value, name::Symbol)
    if name === :string
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :boolean
        return (obj.__protobuf_jl_internal_values[name])::Bool
    elseif name === :long
        return (obj.__protobuf_jl_internal_values[name])::Int64
    elseif name === :double
        return (obj.__protobuf_jl_internal_values[name])::Float64
    elseif name === :date_time
        return (obj.__protobuf_jl_internal_values[name])::Int64
    else
        getfield(obj, name)
    end
end

mutable struct Attribute_GetOwners <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Attribute_GetOwners(; kwargs...)
        obj = new(meta(Attribute_GetOwners), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Attribute_GetOwners
const __meta_Attribute_GetOwners = Ref{ProtoMeta}()
function meta(::Type{Attribute_GetOwners})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Attribute_GetOwners)
            __meta_Attribute_GetOwners[] = target = ProtoMeta(Attribute_GetOwners)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Attribute_GetOwners, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Attribute_GetOwners[]
    end
end

mutable struct Attribute <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Attribute(; kwargs...)
        obj = new(meta(Attribute), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Attribute
const __meta_Attribute = Ref{ProtoMeta}()
function meta(::Type{Attribute})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Attribute)
            __meta_Attribute[] = target = ProtoMeta(Attribute)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Attribute, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Attribute[]
    end
end

const Type_Encoding = (;[
    Symbol("THING_TYPE") => Int32(0),
    Symbol("ENTITY_TYPE") => Int32(1),
    Symbol("RELATION_TYPE") => Int32(2),
    Symbol("ATTRIBUTE_TYPE") => Int32(3),
    Symbol("ROLE_TYPE") => Int32(4),
]...)

mutable struct Type_Delete_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_Delete_Req(; kwargs...)
        obj = new(meta(Type_Delete_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_Delete_Req
const __meta_Type_Delete_Req = Ref{ProtoMeta}()
function meta(::Type{Type_Delete_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_Delete_Req)
            __meta_Type_Delete_Req[] = target = ProtoMeta(Type_Delete_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Type_Delete_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_Delete_Req[]
    end
end

mutable struct Type_Delete_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_Delete_Res(; kwargs...)
        obj = new(meta(Type_Delete_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_Delete_Res
const __meta_Type_Delete_Res = Ref{ProtoMeta}()
function meta(::Type{Type_Delete_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_Delete_Res)
            __meta_Type_Delete_Res[] = target = ProtoMeta(Type_Delete_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Type_Delete_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_Delete_Res[]
    end
end

mutable struct Type_Delete <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_Delete(; kwargs...)
        obj = new(meta(Type_Delete), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_Delete
const __meta_Type_Delete = Ref{ProtoMeta}()
function meta(::Type{Type_Delete})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_Delete)
            __meta_Type_Delete[] = target = ProtoMeta(Type_Delete)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Type_Delete, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_Delete[]
    end
end

mutable struct Type_SetLabel_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_SetLabel_Req(; kwargs...)
        obj = new(meta(Type_SetLabel_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_SetLabel_Req
const __meta_Type_SetLabel_Req = Ref{ProtoMeta}()
function meta(::Type{Type_SetLabel_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_SetLabel_Req)
            __meta_Type_SetLabel_Req[] = target = ProtoMeta(Type_SetLabel_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:label => AbstractString]
            meta(target, Type_SetLabel_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_SetLabel_Req[]
    end
end
function Base.getproperty(obj::Type_SetLabel_Req, name::Symbol)
    if name === :label
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct Type_SetLabel_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_SetLabel_Res(; kwargs...)
        obj = new(meta(Type_SetLabel_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_SetLabel_Res
const __meta_Type_SetLabel_Res = Ref{ProtoMeta}()
function meta(::Type{Type_SetLabel_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_SetLabel_Res)
            __meta_Type_SetLabel_Res[] = target = ProtoMeta(Type_SetLabel_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Type_SetLabel_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_SetLabel_Res[]
    end
end

mutable struct Type_SetLabel <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_SetLabel(; kwargs...)
        obj = new(meta(Type_SetLabel), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_SetLabel
const __meta_Type_SetLabel = Ref{ProtoMeta}()
function meta(::Type{Type_SetLabel})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_SetLabel)
            __meta_Type_SetLabel[] = target = ProtoMeta(Type_SetLabel)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Type_SetLabel, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_SetLabel[]
    end
end

mutable struct Type_IsAbstract_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_IsAbstract_Req(; kwargs...)
        obj = new(meta(Type_IsAbstract_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_IsAbstract_Req
const __meta_Type_IsAbstract_Req = Ref{ProtoMeta}()
function meta(::Type{Type_IsAbstract_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_IsAbstract_Req)
            __meta_Type_IsAbstract_Req[] = target = ProtoMeta(Type_IsAbstract_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Type_IsAbstract_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_IsAbstract_Req[]
    end
end

mutable struct Type_IsAbstract_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_IsAbstract_Res(; kwargs...)
        obj = new(meta(Type_IsAbstract_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_IsAbstract_Res
const __meta_Type_IsAbstract_Res = Ref{ProtoMeta}()
function meta(::Type{Type_IsAbstract_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_IsAbstract_Res)
            __meta_Type_IsAbstract_Res[] = target = ProtoMeta(Type_IsAbstract_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:_abstract => Bool]
            meta(target, Type_IsAbstract_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_IsAbstract_Res[]
    end
end
function Base.getproperty(obj::Type_IsAbstract_Res, name::Symbol)
    if name === :_abstract
        return (obj.__protobuf_jl_internal_values[name])::Bool
    else
        getfield(obj, name)
    end
end

mutable struct Type_IsAbstract <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_IsAbstract(; kwargs...)
        obj = new(meta(Type_IsAbstract), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_IsAbstract
const __meta_Type_IsAbstract = Ref{ProtoMeta}()
function meta(::Type{Type_IsAbstract})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_IsAbstract)
            __meta_Type_IsAbstract[] = target = ProtoMeta(Type_IsAbstract)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Type_IsAbstract, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_IsAbstract[]
    end
end

mutable struct Type_GetSupertype_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_GetSupertype_Req(; kwargs...)
        obj = new(meta(Type_GetSupertype_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_GetSupertype_Req
const __meta_Type_GetSupertype_Req = Ref{ProtoMeta}()
function meta(::Type{Type_GetSupertype_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_GetSupertype_Req)
            __meta_Type_GetSupertype_Req[] = target = ProtoMeta(Type_GetSupertype_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Type_GetSupertype_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_GetSupertype_Req[]
    end
end

mutable struct Type_GetSupertype <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_GetSupertype(; kwargs...)
        obj = new(meta(Type_GetSupertype), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_GetSupertype
const __meta_Type_GetSupertype = Ref{ProtoMeta}()
function meta(::Type{Type_GetSupertype})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_GetSupertype)
            __meta_Type_GetSupertype[] = target = ProtoMeta(Type_GetSupertype)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Type_GetSupertype, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_GetSupertype[]
    end
end

mutable struct Type_SetSupertype_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_SetSupertype_Res(; kwargs...)
        obj = new(meta(Type_SetSupertype_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_SetSupertype_Res
const __meta_Type_SetSupertype_Res = Ref{ProtoMeta}()
function meta(::Type{Type_SetSupertype_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_SetSupertype_Res)
            __meta_Type_SetSupertype_Res[] = target = ProtoMeta(Type_SetSupertype_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Type_SetSupertype_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_SetSupertype_Res[]
    end
end

mutable struct Type_SetSupertype <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_SetSupertype(; kwargs...)
        obj = new(meta(Type_SetSupertype), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_SetSupertype
const __meta_Type_SetSupertype = Ref{ProtoMeta}()
function meta(::Type{Type_SetSupertype})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_SetSupertype)
            __meta_Type_SetSupertype[] = target = ProtoMeta(Type_SetSupertype)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Type_SetSupertype, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_SetSupertype[]
    end
end

mutable struct Type_GetSupertypes_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_GetSupertypes_Req(; kwargs...)
        obj = new(meta(Type_GetSupertypes_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_GetSupertypes_Req
const __meta_Type_GetSupertypes_Req = Ref{ProtoMeta}()
function meta(::Type{Type_GetSupertypes_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_GetSupertypes_Req)
            __meta_Type_GetSupertypes_Req[] = target = ProtoMeta(Type_GetSupertypes_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Type_GetSupertypes_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_GetSupertypes_Req[]
    end
end

mutable struct Type_GetSupertypes <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_GetSupertypes(; kwargs...)
        obj = new(meta(Type_GetSupertypes), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_GetSupertypes
const __meta_Type_GetSupertypes = Ref{ProtoMeta}()
function meta(::Type{Type_GetSupertypes})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_GetSupertypes)
            __meta_Type_GetSupertypes[] = target = ProtoMeta(Type_GetSupertypes)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Type_GetSupertypes, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_GetSupertypes[]
    end
end

mutable struct Type_GetSubtypes_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_GetSubtypes_Req(; kwargs...)
        obj = new(meta(Type_GetSubtypes_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_GetSubtypes_Req
const __meta_Type_GetSubtypes_Req = Ref{ProtoMeta}()
function meta(::Type{Type_GetSubtypes_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_GetSubtypes_Req)
            __meta_Type_GetSubtypes_Req[] = target = ProtoMeta(Type_GetSubtypes_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Type_GetSubtypes_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_GetSubtypes_Req[]
    end
end

mutable struct Type_GetSubtypes <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_GetSubtypes(; kwargs...)
        obj = new(meta(Type_GetSubtypes), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_GetSubtypes
const __meta_Type_GetSubtypes = Ref{ProtoMeta}()
function meta(::Type{Type_GetSubtypes})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_GetSubtypes)
            __meta_Type_GetSubtypes[] = target = ProtoMeta(Type_GetSubtypes)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Type_GetSubtypes, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_GetSubtypes[]
    end
end

mutable struct _Type <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function _Type(; kwargs...)
        obj = new(meta(_Type), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct _Type
const __meta__Type = Ref{ProtoMeta}()
function meta(::Type{_Type})
    ProtoBuf.metalock() do
        if !isassigned(__meta__Type)
            __meta__Type[] = target = ProtoMeta(_Type)
            allflds = Pair{Symbol,Union{Type,String}}[:label => AbstractString, :scope => AbstractString, :encoding => Int32, :value_type => Int32, :root => Bool]
            meta(target, _Type, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta__Type[]
    end
end
function Base.getproperty(obj::_Type, name::Symbol)
    if name === :label
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :scope
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :encoding
        return (obj.__protobuf_jl_internal_values[name])::Int32
    elseif name === :value_type
        return (obj.__protobuf_jl_internal_values[name])::Int32
    elseif name === :root
        return (obj.__protobuf_jl_internal_values[name])::Bool
    else
        getfield(obj, name)
    end
end

mutable struct ConceptManager_GetThingType_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager_GetThingType_Res(; kwargs...)
        obj = new(meta(ConceptManager_GetThingType_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager_GetThingType_Res
const __meta_ConceptManager_GetThingType_Res = Ref{ProtoMeta}()
function meta(::Type{ConceptManager_GetThingType_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager_GetThingType_Res)
            __meta_ConceptManager_GetThingType_Res[] = target = ProtoMeta(ConceptManager_GetThingType_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:thing_type => _Type]
            oneofs = Int[1]
            oneof_names = Symbol[Symbol("res")]
            meta(target, ConceptManager_GetThingType_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_ConceptManager_GetThingType_Res[]
    end
end
function Base.getproperty(obj::ConceptManager_GetThingType_Res, name::Symbol)
    if name === :thing_type
        return (obj.__protobuf_jl_internal_values[name])::_Type
    else
        getfield(obj, name)
    end
end

mutable struct Thing_GetType_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_GetType_Res(; kwargs...)
        obj = new(meta(Thing_GetType_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_GetType_Res
const __meta_Thing_GetType_Res = Ref{ProtoMeta}()
function meta(::Type{Thing_GetType_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_GetType_Res)
            __meta_Thing_GetType_Res[] = target = ProtoMeta(Thing_GetType_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:thing_type => _Type]
            meta(target, Thing_GetType_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_GetType_Res[]
    end
end
function Base.getproperty(obj::Thing_GetType_Res, name::Symbol)
    if name === :thing_type
        return (obj.__protobuf_jl_internal_values[name])::_Type
    else
        getfield(obj, name)
    end
end

mutable struct ConceptManager_PutAttributeType_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager_PutAttributeType_Res(; kwargs...)
        obj = new(meta(ConceptManager_PutAttributeType_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager_PutAttributeType_Res
const __meta_ConceptManager_PutAttributeType_Res = Ref{ProtoMeta}()
function meta(::Type{ConceptManager_PutAttributeType_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager_PutAttributeType_Res)
            __meta_ConceptManager_PutAttributeType_Res[] = target = ProtoMeta(ConceptManager_PutAttributeType_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:attribute_type => _Type]
            meta(target, ConceptManager_PutAttributeType_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptManager_PutAttributeType_Res[]
    end
end
function Base.getproperty(obj::ConceptManager_PutAttributeType_Res, name::Symbol)
    if name === :attribute_type
        return (obj.__protobuf_jl_internal_values[name])::_Type
    else
        getfield(obj, name)
    end
end

mutable struct Attribute_GetOwners_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Attribute_GetOwners_Req(; kwargs...)
        obj = new(meta(Attribute_GetOwners_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Attribute_GetOwners_Req
const __meta_Attribute_GetOwners_Req = Ref{ProtoMeta}()
function meta(::Type{Attribute_GetOwners_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Attribute_GetOwners_Req)
            __meta_Attribute_GetOwners_Req[] = target = ProtoMeta(Attribute_GetOwners_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:thing_type => _Type]
            oneofs = Int[1]
            oneof_names = Symbol[Symbol("filter")]
            meta(target, Attribute_GetOwners_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Attribute_GetOwners_Req[]
    end
end
function Base.getproperty(obj::Attribute_GetOwners_Req, name::Symbol)
    if name === :thing_type
        return (obj.__protobuf_jl_internal_values[name])::_Type
    else
        getfield(obj, name)
    end
end

mutable struct Thing_GetPlaying_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_GetPlaying_ResPart(; kwargs...)
        obj = new(meta(Thing_GetPlaying_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_GetPlaying_ResPart
const __meta_Thing_GetPlaying_ResPart = Ref{ProtoMeta}()
function meta(::Type{Thing_GetPlaying_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_GetPlaying_ResPart)
            __meta_Thing_GetPlaying_ResPart[] = target = ProtoMeta(Thing_GetPlaying_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:role_types => Base.Vector{_Type}]
            meta(target, Thing_GetPlaying_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_GetPlaying_ResPart[]
    end
end
function Base.getproperty(obj::Thing_GetPlaying_ResPart, name::Symbol)
    if name === :role_types
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{_Type}
    else
        getfield(obj, name)
    end
end

mutable struct Type_GetSupertypes_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_GetSupertypes_ResPart(; kwargs...)
        obj = new(meta(Type_GetSupertypes_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_GetSupertypes_ResPart
const __meta_Type_GetSupertypes_ResPart = Ref{ProtoMeta}()
function meta(::Type{Type_GetSupertypes_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_GetSupertypes_ResPart)
            __meta_Type_GetSupertypes_ResPart[] = target = ProtoMeta(Type_GetSupertypes_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:types => Base.Vector{_Type}]
            meta(target, Type_GetSupertypes_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_GetSupertypes_ResPart[]
    end
end
function Base.getproperty(obj::Type_GetSupertypes_ResPart, name::Symbol)
    if name === :types
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{_Type}
    else
        getfield(obj, name)
    end
end

mutable struct ConceptManager_PutEntityType_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager_PutEntityType_Res(; kwargs...)
        obj = new(meta(ConceptManager_PutEntityType_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager_PutEntityType_Res
const __meta_ConceptManager_PutEntityType_Res = Ref{ProtoMeta}()
function meta(::Type{ConceptManager_PutEntityType_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager_PutEntityType_Res)
            __meta_ConceptManager_PutEntityType_Res[] = target = ProtoMeta(ConceptManager_PutEntityType_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:entity_type => _Type]
            meta(target, ConceptManager_PutEntityType_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptManager_PutEntityType_Res[]
    end
end
function Base.getproperty(obj::ConceptManager_PutEntityType_Res, name::Symbol)
    if name === :entity_type
        return (obj.__protobuf_jl_internal_values[name])::_Type
    else
        getfield(obj, name)
    end
end

mutable struct Type_GetSupertype_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_GetSupertype_Res(; kwargs...)
        obj = new(meta(Type_GetSupertype_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_GetSupertype_Res
const __meta_Type_GetSupertype_Res = Ref{ProtoMeta}()
function meta(::Type{Type_GetSupertype_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_GetSupertype_Res)
            __meta_Type_GetSupertype_Res[] = target = ProtoMeta(Type_GetSupertype_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:_type => _Type]
            oneofs = Int[1]
            oneof_names = Symbol[Symbol("res")]
            meta(target, Type_GetSupertype_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Type_GetSupertype_Res[]
    end
end
function Base.getproperty(obj::Type_GetSupertype_Res, name::Symbol)
    if name === :_type
        return (obj.__protobuf_jl_internal_values[name])::_Type
    else
        getfield(obj, name)
    end
end

mutable struct Thing_Delete_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_Delete_Req(; kwargs...)
        obj = new(meta(Thing_Delete_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_Delete_Req
const __meta_Thing_Delete_Req = Ref{ProtoMeta}()
function meta(::Type{Thing_Delete_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_Delete_Req)
            __meta_Thing_Delete_Req[] = target = ProtoMeta(Thing_Delete_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Thing_Delete_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_Delete_Req[]
    end
end

mutable struct Thing_Delete_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_Delete_Res(; kwargs...)
        obj = new(meta(Thing_Delete_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_Delete_Res
const __meta_Thing_Delete_Res = Ref{ProtoMeta}()
function meta(::Type{Thing_Delete_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_Delete_Res)
            __meta_Thing_Delete_Res[] = target = ProtoMeta(Thing_Delete_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Thing_Delete_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_Delete_Res[]
    end
end

mutable struct Thing_Delete <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_Delete(; kwargs...)
        obj = new(meta(Thing_Delete), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_Delete
const __meta_Thing_Delete = Ref{ProtoMeta}()
function meta(::Type{Thing_Delete})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_Delete)
            __meta_Thing_Delete[] = target = ProtoMeta(Thing_Delete)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Thing_Delete, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_Delete[]
    end
end

mutable struct Thing_GetType_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_GetType_Req(; kwargs...)
        obj = new(meta(Thing_GetType_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_GetType_Req
const __meta_Thing_GetType_Req = Ref{ProtoMeta}()
function meta(::Type{Thing_GetType_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_GetType_Req)
            __meta_Thing_GetType_Req[] = target = ProtoMeta(Thing_GetType_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Thing_GetType_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_GetType_Req[]
    end
end

mutable struct Thing_GetType <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_GetType(; kwargs...)
        obj = new(meta(Thing_GetType), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_GetType
const __meta_Thing_GetType = Ref{ProtoMeta}()
function meta(::Type{Thing_GetType})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_GetType)
            __meta_Thing_GetType[] = target = ProtoMeta(Thing_GetType)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Thing_GetType, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_GetType[]
    end
end

mutable struct Thing_SetHas_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_SetHas_Res(; kwargs...)
        obj = new(meta(Thing_SetHas_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_SetHas_Res
const __meta_Thing_SetHas_Res = Ref{ProtoMeta}()
function meta(::Type{Thing_SetHas_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_SetHas_Res)
            __meta_Thing_SetHas_Res[] = target = ProtoMeta(Thing_SetHas_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Thing_SetHas_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_SetHas_Res[]
    end
end

mutable struct Thing_SetHas <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_SetHas(; kwargs...)
        obj = new(meta(Thing_SetHas), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_SetHas
const __meta_Thing_SetHas = Ref{ProtoMeta}()
function meta(::Type{Thing_SetHas})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_SetHas)
            __meta_Thing_SetHas[] = target = ProtoMeta(Thing_SetHas)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Thing_SetHas, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_SetHas[]
    end
end

mutable struct Thing_UnsetHas_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_UnsetHas_Res(; kwargs...)
        obj = new(meta(Thing_UnsetHas_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_UnsetHas_Res
const __meta_Thing_UnsetHas_Res = Ref{ProtoMeta}()
function meta(::Type{Thing_UnsetHas_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_UnsetHas_Res)
            __meta_Thing_UnsetHas_Res[] = target = ProtoMeta(Thing_UnsetHas_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Thing_UnsetHas_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_UnsetHas_Res[]
    end
end

mutable struct Thing_UnsetHas <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_UnsetHas(; kwargs...)
        obj = new(meta(Thing_UnsetHas), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_UnsetHas
const __meta_Thing_UnsetHas = Ref{ProtoMeta}()
function meta(::Type{Thing_UnsetHas})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_UnsetHas)
            __meta_Thing_UnsetHas[] = target = ProtoMeta(Thing_UnsetHas)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Thing_UnsetHas, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_UnsetHas[]
    end
end

mutable struct Thing_GetHas <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_GetHas(; kwargs...)
        obj = new(meta(Thing_GetHas), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_GetHas
const __meta_Thing_GetHas = Ref{ProtoMeta}()
function meta(::Type{Thing_GetHas})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_GetHas)
            __meta_Thing_GetHas[] = target = ProtoMeta(Thing_GetHas)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Thing_GetHas, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_GetHas[]
    end
end

mutable struct Thing_GetPlaying_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_GetPlaying_Req(; kwargs...)
        obj = new(meta(Thing_GetPlaying_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_GetPlaying_Req
const __meta_Thing_GetPlaying_Req = Ref{ProtoMeta}()
function meta(::Type{Thing_GetPlaying_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_GetPlaying_Req)
            __meta_Thing_GetPlaying_Req[] = target = ProtoMeta(Thing_GetPlaying_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Thing_GetPlaying_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_GetPlaying_Req[]
    end
end

mutable struct Thing_GetPlaying <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_GetPlaying(; kwargs...)
        obj = new(meta(Thing_GetPlaying), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_GetPlaying
const __meta_Thing_GetPlaying = Ref{ProtoMeta}()
function meta(::Type{Thing_GetPlaying})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_GetPlaying)
            __meta_Thing_GetPlaying[] = target = ProtoMeta(Thing_GetPlaying)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Thing_GetPlaying, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_GetPlaying[]
    end
end

mutable struct Thing_GetRelations <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_GetRelations(; kwargs...)
        obj = new(meta(Thing_GetRelations), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_GetRelations
const __meta_Thing_GetRelations = Ref{ProtoMeta}()
function meta(::Type{Thing_GetRelations})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_GetRelations)
            __meta_Thing_GetRelations[] = target = ProtoMeta(Thing_GetRelations)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Thing_GetRelations, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_GetRelations[]
    end
end

mutable struct Thing <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing(; kwargs...)
        obj = new(meta(Thing), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing
const __meta_Thing = Ref{ProtoMeta}()
function meta(::Type{Thing})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing)
            __meta_Thing[] = target = ProtoMeta(Thing)
            allflds = Pair{Symbol,Union{Type,String}}[:iid => Vector{UInt8}, :_type => _Type, :value => Attribute_Value, :inferred => Bool]
            meta(target, Thing, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing[]
    end
end
function Base.getproperty(obj::Thing, name::Symbol)
    if name === :iid
        return (obj.__protobuf_jl_internal_values[name])::Vector{UInt8}
    elseif name === :_type
        return (obj.__protobuf_jl_internal_values[name])::_Type
    elseif name === :value
        return (obj.__protobuf_jl_internal_values[name])::Attribute_Value
    elseif name === :inferred
        return (obj.__protobuf_jl_internal_values[name])::Bool
    else
        getfield(obj, name)
    end
end

mutable struct Type_GetSubtypes_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_GetSubtypes_ResPart(; kwargs...)
        obj = new(meta(Type_GetSubtypes_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_GetSubtypes_ResPart
const __meta_Type_GetSubtypes_ResPart = Ref{ProtoMeta}()

function meta(::Type{Type_GetSubtypes_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_GetSubtypes_ResPart)
            __meta_Type_GetSubtypes_ResPart[] = target = ProtoMeta(Type_GetSubtypes_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:types => Base.Vector{_Type}]
            meta(target, Type_GetSubtypes_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_GetSubtypes_ResPart[]
    end
end
function Base.getproperty(obj::Type_GetSubtypes_ResPart, name::Symbol)
    if name === :types
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{_Type}
    else
        getfield(obj, name)
    end
end

mutable struct Type_SetSupertype_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_SetSupertype_Req(; kwargs...)
        obj = new(meta(Type_SetSupertype_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_SetSupertype_Req
const __meta_Type_SetSupertype_Req = Ref{ProtoMeta}()
function meta(::Type{Type_SetSupertype_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_SetSupertype_Req)
            __meta_Type_SetSupertype_Req[] = target = ProtoMeta(Type_SetSupertype_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:_type => _Type]
            meta(target, Type_SetSupertype_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Type_SetSupertype_Req[]
    end
end
function Base.getproperty(obj::Type_SetSupertype_Req, name::Symbol)
    if name === :_type
        return (obj.__protobuf_jl_internal_values[name])::_Type
    else
        getfield(obj, name)
    end
end

mutable struct Thing_GetRelations_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_GetRelations_Req(; kwargs...)
        obj = new(meta(Thing_GetRelations_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_GetRelations_Req
const __meta_Thing_GetRelations_Req = Ref{ProtoMeta}()
function meta(::Type{Thing_GetRelations_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_GetRelations_Req)
            __meta_Thing_GetRelations_Req[] = target = ProtoMeta(Thing_GetRelations_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:role_types => Base.Vector{_Type}]
            meta(target, Thing_GetRelations_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_GetRelations_Req[]
    end
end
function Base.getproperty(obj::Thing_GetRelations_Req, name::Symbol)
    if name === :role_types
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{_Type}
    else
        getfield(obj, name)
    end
end

mutable struct ConceptManager_PutRelationType_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager_PutRelationType_Res(; kwargs...)
        obj = new(meta(ConceptManager_PutRelationType_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager_PutRelationType_Res
const __meta_ConceptManager_PutRelationType_Res = Ref{ProtoMeta}()
function meta(::Type{ConceptManager_PutRelationType_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager_PutRelationType_Res)
            __meta_ConceptManager_PutRelationType_Res[] = target = ProtoMeta(ConceptManager_PutRelationType_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:relation_type => _Type]
            meta(target, ConceptManager_PutRelationType_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptManager_PutRelationType_Res[]
    end
end
function Base.getproperty(obj::ConceptManager_PutRelationType_Res, name::Symbol)
    if name === :relation_type
        return (obj.__protobuf_jl_internal_values[name])::_Type
    else
        getfield(obj, name)
    end
end

mutable struct Relation_GetRelating_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Relation_GetRelating_ResPart(; kwargs...)
        obj = new(meta(Relation_GetRelating_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Relation_GetRelating_ResPart
const __meta_Relation_GetRelating_ResPart = Ref{ProtoMeta}()
function meta(::Type{Relation_GetRelating_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Relation_GetRelating_ResPart)
            __meta_Relation_GetRelating_ResPart[] = target = ProtoMeta(Relation_GetRelating_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:role_types => Base.Vector{_Type}]
            meta(target, Relation_GetRelating_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Relation_GetRelating_ResPart[]
    end
end
function Base.getproperty(obj::Relation_GetRelating_ResPart, name::Symbol)
    if name === :role_types
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{_Type}
    else
        getfield(obj, name)
    end
end

mutable struct Relation_GetPlayers_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Relation_GetPlayers_Req(; kwargs...)
        obj = new(meta(Relation_GetPlayers_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Relation_GetPlayers_Req
const __meta_Relation_GetPlayers_Req = Ref{ProtoMeta}()
function meta(::Type{Relation_GetPlayers_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Relation_GetPlayers_Req)
            __meta_Relation_GetPlayers_Req[] = target = ProtoMeta(Relation_GetPlayers_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:role_types => Base.Vector{_Type}]
            meta(target, Relation_GetPlayers_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Relation_GetPlayers_Req[]
    end
end
function Base.getproperty(obj::Relation_GetPlayers_Req, name::Symbol)
    if name === :role_types
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{_Type}
    else
        getfield(obj, name)
    end
end

mutable struct Thing_GetHas_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_GetHas_Req(; kwargs...)
        obj = new(meta(Thing_GetHas_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_GetHas_Req
const __meta_Thing_GetHas_Req = Ref{ProtoMeta}()
function meta(::Type{Thing_GetHas_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_GetHas_Req)
            __meta_Thing_GetHas_Req[] = target = ProtoMeta(Thing_GetHas_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:attribute_types => Base.Vector{_Type}, :keys_only => Bool]
            meta(target, Thing_GetHas_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_GetHas_Req[]
    end
end
function Base.getproperty(obj::Thing_GetHas_Req, name::Symbol)
    if name === :attribute_types
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{_Type}
    elseif name === :keys_only
        return (obj.__protobuf_jl_internal_values[name])::Bool
    else
        getfield(obj, name)
    end
end

mutable struct Thing_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_Res(; kwargs...)
        obj = new(meta(Thing_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_Res
const __meta_Thing_Res = Ref{ProtoMeta}()
function meta(::Type{Thing_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_Res)
            __meta_Thing_Res[] = target = ProtoMeta(Thing_Res)
            fnum = Int[100,101,102,103,200,201]
            allflds = Pair{Symbol,Union{Type,String}}[:thing_delete_res => Thing_Delete_Res, :thing_get_type_res => Thing_GetType_Res, :thing_set_has_res => Thing_SetHas_Res, :thing_unset_has_res => Thing_UnsetHas_Res, :relation_add_player_res => Relation_AddPlayer_Res, :relation_remove_player_res => Relation_RemovePlayer_Res]
            oneofs = Int[1,1,1,1,1,1]
            oneof_names = Symbol[Symbol("res")]
            meta(target, Thing_Res, allflds, ProtoBuf.DEF_REQ, fnum, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Thing_Res[]
    end
end
function Base.getproperty(obj::Thing_Res, name::Symbol)
    if name === :thing_delete_res
        return (obj.__protobuf_jl_internal_values[name])::Thing_Delete_Res
    elseif name === :thing_get_type_res
        return (obj.__protobuf_jl_internal_values[name])::Thing_GetType_Res
    elseif name === :thing_set_has_res
        return (obj.__protobuf_jl_internal_values[name])::Thing_SetHas_Res
    elseif name === :thing_unset_has_res
        return (obj.__protobuf_jl_internal_values[name])::Thing_UnsetHas_Res
    elseif name === :relation_add_player_res
        return (obj.__protobuf_jl_internal_values[name])::Relation_AddPlayer_Res
    elseif name === :relation_remove_player_res
        return (obj.__protobuf_jl_internal_values[name])::Relation_RemovePlayer_Res
    else
        getfield(obj, name)
    end
end

mutable struct Thing_GetRelations_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_GetRelations_ResPart(; kwargs...)
        obj = new(meta(Thing_GetRelations_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_GetRelations_ResPart
const __meta_Thing_GetRelations_ResPart = Ref{ProtoMeta}()
function meta(::Type{Thing_GetRelations_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_GetRelations_ResPart)
            __meta_Thing_GetRelations_ResPart[] = target = ProtoMeta(Thing_GetRelations_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:relations => Base.Vector{Thing}]
            meta(target, Thing_GetRelations_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_GetRelations_ResPart[]
    end
end
function Base.getproperty(obj::Thing_GetRelations_ResPart, name::Symbol)
    if name === :relations
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{Thing}
    else
        getfield(obj, name)
    end
end

mutable struct Relation_GetPlayersByRoleType_RoleTypeWithPlayer <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Relation_GetPlayersByRoleType_RoleTypeWithPlayer(; kwargs...)
        obj = new(meta(Relation_GetPlayersByRoleType_RoleTypeWithPlayer), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Relation_GetPlayersByRoleType_RoleTypeWithPlayer
const __meta_Relation_GetPlayersByRoleType_RoleTypeWithPlayer = Ref{ProtoMeta}()
function meta(::Type{Relation_GetPlayersByRoleType_RoleTypeWithPlayer})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Relation_GetPlayersByRoleType_RoleTypeWithPlayer)
            __meta_Relation_GetPlayersByRoleType_RoleTypeWithPlayer[] = target = ProtoMeta(Relation_GetPlayersByRoleType_RoleTypeWithPlayer)
            allflds = Pair{Symbol,Union{Type,String}}[:role_type => _Type, :player => Thing]
            meta(target, Relation_GetPlayersByRoleType_RoleTypeWithPlayer, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Relation_GetPlayersByRoleType_RoleTypeWithPlayer[]
    end
end
function Base.getproperty(obj::Relation_GetPlayersByRoleType_RoleTypeWithPlayer, name::Symbol)
    if name === :role_type
        return (obj.__protobuf_jl_internal_values[name])::_Type
    elseif name === :player
        return (obj.__protobuf_jl_internal_values[name])::Thing
    else
        getfield(obj, name)
    end
end

mutable struct Thing_UnsetHas_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_UnsetHas_Req(; kwargs...)
        obj = new(meta(Thing_UnsetHas_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_UnsetHas_Req
const __meta_Thing_UnsetHas_Req = Ref{ProtoMeta}()
function meta(::Type{Thing_UnsetHas_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_UnsetHas_Req)
            __meta_Thing_UnsetHas_Req[] = target = ProtoMeta(Thing_UnsetHas_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:attribute => Thing]
            meta(target, Thing_UnsetHas_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_UnsetHas_Req[]
    end
end
function Base.getproperty(obj::Thing_UnsetHas_Req, name::Symbol)
    if name === :attribute
        return (obj.__protobuf_jl_internal_values[name])::Thing
    else
        getfield(obj, name)
    end
end

mutable struct Thing_SetHas_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_SetHas_Req(; kwargs...)
        obj = new(meta(Thing_SetHas_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_SetHas_Req
const __meta_Thing_SetHas_Req = Ref{ProtoMeta}()
function meta(::Type{Thing_SetHas_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_SetHas_Req)
            __meta_Thing_SetHas_Req[] = target = ProtoMeta(Thing_SetHas_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:attribute => Thing]
            meta(target, Thing_SetHas_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_SetHas_Req[]
    end
end
function Base.getproperty(obj::Thing_SetHas_Req, name::Symbol)
    if name === :attribute
        return (obj.__protobuf_jl_internal_values[name])::Thing
    else
        getfield(obj, name)
    end
end

mutable struct Relation_GetPlayers_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Relation_GetPlayers_ResPart(; kwargs...)
        obj = new(meta(Relation_GetPlayers_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Relation_GetPlayers_ResPart
const __meta_Relation_GetPlayers_ResPart = Ref{ProtoMeta}()
function meta(::Type{Relation_GetPlayers_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Relation_GetPlayers_ResPart)
            __meta_Relation_GetPlayers_ResPart[] = target = ProtoMeta(Relation_GetPlayers_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:things => Base.Vector{Thing}]
            meta(target, Relation_GetPlayers_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Relation_GetPlayers_ResPart[]
    end
end
function Base.getproperty(obj::Relation_GetPlayers_ResPart, name::Symbol)
    if name === :things
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{Thing}
    else
        getfield(obj, name)
    end
end

mutable struct Concept <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Concept(; kwargs...)
        obj = new(meta(Concept), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Concept
const __meta_Concept = Ref{ProtoMeta}()
function meta(::Type{Concept})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Concept)
            __meta_Concept[] = target = ProtoMeta(Concept)
            allflds = Pair{Symbol,Union{Type,String}}[:thing => Thing, :_type => _Type]
            oneofs = Int[1,1]
            oneof_names = Symbol[Symbol("concept")]
            meta(target, Concept, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Concept[]
    end
end
function Base.getproperty(obj::Concept, name::Symbol)
    if name === :thing
        return (obj.__protobuf_jl_internal_values[name])::Thing
    elseif name === :_type
        return (obj.__protobuf_jl_internal_values[name])::_Type
    else
        getfield(obj, name)
    end
end

mutable struct Relation_AddPlayer_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Relation_AddPlayer_Req(; kwargs...)
        obj = new(meta(Relation_AddPlayer_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Relation_AddPlayer_Req
const __meta_Relation_AddPlayer_Req = Ref{ProtoMeta}()
function meta(::Type{Relation_AddPlayer_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Relation_AddPlayer_Req)
            __meta_Relation_AddPlayer_Req[] = target = ProtoMeta(Relation_AddPlayer_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:role_type => _Type, :player => Thing]
            meta(target, Relation_AddPlayer_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Relation_AddPlayer_Req[]
    end
end
function Base.getproperty(obj::Relation_AddPlayer_Req, name::Symbol)
    if name === :role_type
        return (obj.__protobuf_jl_internal_values[name])::_Type
    elseif name === :player
        return (obj.__protobuf_jl_internal_values[name])::Thing
    else
        getfield(obj, name)
    end
end

mutable struct Relation_RemovePlayer_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Relation_RemovePlayer_Req(; kwargs...)
        obj = new(meta(Relation_RemovePlayer_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Relation_RemovePlayer_Req
const __meta_Relation_RemovePlayer_Req = Ref{ProtoMeta}()
function meta(::Type{Relation_RemovePlayer_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Relation_RemovePlayer_Req)
            __meta_Relation_RemovePlayer_Req[] = target = ProtoMeta(Relation_RemovePlayer_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:role_type => _Type, :player => Thing]
            meta(target, Relation_RemovePlayer_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Relation_RemovePlayer_Req[]
    end
end
function Base.getproperty(obj::Relation_RemovePlayer_Req, name::Symbol)
    if name === :role_type
        return (obj.__protobuf_jl_internal_values[name])::_Type
    elseif name === :player
        return (obj.__protobuf_jl_internal_values[name])::Thing
    else
        getfield(obj, name)
    end
end

mutable struct ConceptManager_GetThing_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager_GetThing_Res(; kwargs...)
        obj = new(meta(ConceptManager_GetThing_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager_GetThing_Res
const __meta_ConceptManager_GetThing_Res = Ref{ProtoMeta}()
function meta(::Type{ConceptManager_GetThing_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager_GetThing_Res)
            __meta_ConceptManager_GetThing_Res[] = target = ProtoMeta(ConceptManager_GetThing_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:thing => Thing]
            oneofs = Int[1]
            oneof_names = Symbol[Symbol("res")]
            meta(target, ConceptManager_GetThing_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_ConceptManager_GetThing_Res[]
    end
end
function Base.getproperty(obj::ConceptManager_GetThing_Res, name::Symbol)
    if name === :thing
        return (obj.__protobuf_jl_internal_values[name])::Thing
    else
        getfield(obj, name)
    end
end

mutable struct Thing_GetHas_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_GetHas_ResPart(; kwargs...)
        obj = new(meta(Thing_GetHas_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_GetHas_ResPart
const __meta_Thing_GetHas_ResPart = Ref{ProtoMeta}()
function meta(::Type{Thing_GetHas_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_GetHas_ResPart)
            __meta_Thing_GetHas_ResPart[] = target = ProtoMeta(Thing_GetHas_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:attributes => Base.Vector{Thing}]
            meta(target, Thing_GetHas_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Thing_GetHas_ResPart[]
    end
end
function Base.getproperty(obj::Thing_GetHas_ResPart, name::Symbol)
    if name === :attributes
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{Thing}
    else
        getfield(obj, name)
    end
end

mutable struct Attribute_GetOwners_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Attribute_GetOwners_ResPart(; kwargs...)
        obj = new(meta(Attribute_GetOwners_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Attribute_GetOwners_ResPart
const __meta_Attribute_GetOwners_ResPart = Ref{ProtoMeta}()
function meta(::Type{Attribute_GetOwners_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Attribute_GetOwners_ResPart)
            __meta_Attribute_GetOwners_ResPart[] = target = ProtoMeta(Attribute_GetOwners_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:things => Base.Vector{Thing}]
            meta(target, Attribute_GetOwners_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Attribute_GetOwners_ResPart[]
    end
end
function Base.getproperty(obj::Attribute_GetOwners_ResPart, name::Symbol)
    if name === :things
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{Thing}
    else
        getfield(obj, name)
    end
end

mutable struct Relation_GetPlayersByRoleType_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Relation_GetPlayersByRoleType_ResPart(; kwargs...)
        obj = new(meta(Relation_GetPlayersByRoleType_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Relation_GetPlayersByRoleType_ResPart
const __meta_Relation_GetPlayersByRoleType_ResPart = Ref{ProtoMeta}()
function meta(::Type{Relation_GetPlayersByRoleType_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Relation_GetPlayersByRoleType_ResPart)
            __meta_Relation_GetPlayersByRoleType_ResPart[] = target = ProtoMeta(Relation_GetPlayersByRoleType_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:role_types_with_players => Base.Vector{Relation_GetPlayersByRoleType_RoleTypeWithPlayer}]
            meta(target, Relation_GetPlayersByRoleType_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Relation_GetPlayersByRoleType_ResPart[]
    end
end
function Base.getproperty(obj::Relation_GetPlayersByRoleType_ResPart, name::Symbol)
    if name === :role_types_with_players
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{Relation_GetPlayersByRoleType_RoleTypeWithPlayer}
    else
        getfield(obj, name)
    end
end

mutable struct ConceptManager_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptManager_Res(; kwargs...)
        obj = new(meta(ConceptManager_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptManager_Res
const __meta_ConceptManager_Res = Ref{ProtoMeta}()
function meta(::Type{ConceptManager_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptManager_Res)
            __meta_ConceptManager_Res[] = target = ProtoMeta(ConceptManager_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:get_thing_type_res => ConceptManager_GetThingType_Res, :get_thing_res => ConceptManager_GetThing_Res, :put_entity_type_res => ConceptManager_PutEntityType_Res, :put_attribute_type_res => ConceptManager_PutAttributeType_Res, :put_relation_type_res => ConceptManager_PutRelationType_Res]
            oneofs = Int[1,1,1,1,1]
            oneof_names = Symbol[Symbol("res")]
            meta(target, ConceptManager_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_ConceptManager_Res[]
    end
end
function Base.getproperty(obj::ConceptManager_Res, name::Symbol)
    if name === :get_thing_type_res
        return (obj.__protobuf_jl_internal_values[name])::ConceptManager_GetThingType_Res
    elseif name === :get_thing_res
        return (obj.__protobuf_jl_internal_values[name])::ConceptManager_GetThing_Res
    elseif name === :put_entity_type_res
        return (obj.__protobuf_jl_internal_values[name])::ConceptManager_PutEntityType_Res
    elseif name === :put_attribute_type_res
        return (obj.__protobuf_jl_internal_values[name])::ConceptManager_PutAttributeType_Res
    elseif name === :put_relation_type_res
        return (obj.__protobuf_jl_internal_values[name])::ConceptManager_PutRelationType_Res
    else
        getfield(obj, name)
    end
end

mutable struct Thing_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_ResPart(; kwargs...)
        obj = new(meta(Thing_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_ResPart
const __meta_Thing_ResPart = Ref{ProtoMeta}()
function meta(::Type{Thing_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_ResPart)
            __meta_Thing_ResPart[] = target = ProtoMeta(Thing_ResPart)
            fnum = Int[100,101,102,200,201,202,300]
            allflds = Pair{Symbol,Union{Type,String}}[:thing_get_has_res_part => Thing_GetHas_ResPart, :thing_get_relations_res_part => Thing_GetRelations_ResPart, :thing_get_playing_res_part => Thing_GetPlaying_ResPart, :relation_get_players_res_part => Relation_GetPlayers_ResPart, :relation_get_players_by_role_type_res_part => Relation_GetPlayersByRoleType_ResPart, :relation_get_relating_res_part => Relation_GetRelating_ResPart, :attribute_get_owners_res_part => Attribute_GetOwners_ResPart]
            oneofs = Int[1,1,1,1,1,1,1]
            oneof_names = Symbol[Symbol("res")]
            meta(target, Thing_ResPart, allflds, ProtoBuf.DEF_REQ, fnum, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Thing_ResPart[]
    end
end
function Base.getproperty(obj::Thing_ResPart, name::Symbol)
    if name === :thing_get_has_res_part
        return (obj.__protobuf_jl_internal_values[name])::Thing_GetHas_ResPart
    elseif name === :thing_get_relations_res_part
        return (obj.__protobuf_jl_internal_values[name])::Thing_GetRelations_ResPart
    elseif name === :thing_get_playing_res_part
        return (obj.__protobuf_jl_internal_values[name])::Thing_GetPlaying_ResPart
    elseif name === :relation_get_players_res_part
        return (obj.__protobuf_jl_internal_values[name])::Relation_GetPlayers_ResPart
    elseif name === :relation_get_players_by_role_type_res_part
        return (obj.__protobuf_jl_internal_values[name])::Relation_GetPlayersByRoleType_ResPart
    elseif name === :relation_get_relating_res_part
        return (obj.__protobuf_jl_internal_values[name])::Relation_GetRelating_ResPart
    elseif name === :attribute_get_owners_res_part
        return (obj.__protobuf_jl_internal_values[name])::Attribute_GetOwners_ResPart
    else
        getfield(obj, name)
    end
end

mutable struct Thing_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Thing_Req(; kwargs...)
        obj = new(meta(Thing_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Thing_Req
const __meta_Thing_Req = Ref{ProtoMeta}()
function meta(::Type{Thing_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Thing_Req)
            __meta_Thing_Req[] = target = ProtoMeta(Thing_Req)
            fnum = Int[1,100,101,102,103,104,105,106,200,201,202,203,204,300]
            allflds = Pair{Symbol,Union{Type,String}}[:iid => Vector{UInt8}, :thing_delete_req => Thing_Delete_Req, :thing_get_type_req => Thing_GetType_Req, :thing_get_has_req => Thing_GetHas_Req, :thing_set_has_req => Thing_SetHas_Req, :thing_unset_has_req => Thing_UnsetHas_Req, :thing_get_relations_req => Thing_GetRelations_Req, :thing_get_playing_req => Thing_GetPlaying_Req, :relation_add_player_req => Relation_AddPlayer_Req, :relation_remove_player_req => Relation_RemovePlayer_Req, :relation_get_players_req => Relation_GetPlayers_Req, :relation_get_players_by_role_type_req => Relation_GetPlayersByRoleType_Req, :relation_get_relating_req => Relation_GetRelating_Req, :attribute_get_owners_req => Attribute_GetOwners_Req]
            oneofs = Int[0,1,1,1,1,1,1,1,1,1,1,1,1,1]
            oneof_names = Symbol[Symbol("req")]
            meta(target, Thing_Req, allflds, ProtoBuf.DEF_REQ, fnum, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Thing_Req[]
    end
end
function Base.getproperty(obj::Thing_Req, name::Symbol)
    if name === :iid
        return (obj.__protobuf_jl_internal_values[name])::Vector{UInt8}
    elseif name === :thing_delete_req
        return (obj.__protobuf_jl_internal_values[name])::Thing_Delete_Req
    elseif name === :thing_get_type_req
        return (obj.__protobuf_jl_internal_values[name])::Thing_GetType_Req
    elseif name === :thing_get_has_req
        return (obj.__protobuf_jl_internal_values[name])::Thing_GetHas_Req
    elseif name === :thing_set_has_req
        return (obj.__protobuf_jl_internal_values[name])::Thing_SetHas_Req
    elseif name === :thing_unset_has_req
        return (obj.__protobuf_jl_internal_values[name])::Thing_UnsetHas_Req
    elseif name === :thing_get_relations_req
        return (obj.__protobuf_jl_internal_values[name])::Thing_GetRelations_Req
    elseif name === :thing_get_playing_req
        return (obj.__protobuf_jl_internal_values[name])::Thing_GetPlaying_Req
    elseif name === :relation_add_player_req
        return (obj.__protobuf_jl_internal_values[name])::Relation_AddPlayer_Req
    elseif name === :relation_remove_player_req
        return (obj.__protobuf_jl_internal_values[name])::Relation_RemovePlayer_Req
    elseif name === :relation_get_players_req
        return (obj.__protobuf_jl_internal_values[name])::Relation_GetPlayers_Req
    elseif name === :relation_get_players_by_role_type_req
        return (obj.__protobuf_jl_internal_values[name])::Relation_GetPlayersByRoleType_Req
    elseif name === :relation_get_relating_req
        return (obj.__protobuf_jl_internal_values[name])::Relation_GetRelating_Req
    elseif name === :attribute_get_owners_req
        return (obj.__protobuf_jl_internal_values[name])::Attribute_GetOwners_Req
    else
        getfield(obj, name)
    end
end

mutable struct RoleType_GetRelationTypes_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RoleType_GetRelationTypes_Req(; kwargs...)
        obj = new(meta(RoleType_GetRelationTypes_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RoleType_GetRelationTypes_Req
const __meta_RoleType_GetRelationTypes_Req = Ref{ProtoMeta}()
function meta(::Type{RoleType_GetRelationTypes_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RoleType_GetRelationTypes_Req)
            __meta_RoleType_GetRelationTypes_Req[] = target = ProtoMeta(RoleType_GetRelationTypes_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, RoleType_GetRelationTypes_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RoleType_GetRelationTypes_Req[]
    end
end

mutable struct RoleType_GetRelationTypes_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RoleType_GetRelationTypes_ResPart(; kwargs...)
        obj = new(meta(RoleType_GetRelationTypes_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RoleType_GetRelationTypes_ResPart
const __meta_RoleType_GetRelationTypes_ResPart = Ref{ProtoMeta}()
function meta(::Type{RoleType_GetRelationTypes_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RoleType_GetRelationTypes_ResPart)
            __meta_RoleType_GetRelationTypes_ResPart[] = target = ProtoMeta(RoleType_GetRelationTypes_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:relation_types => Base.Vector{_Type}]
            meta(target, RoleType_GetRelationTypes_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RoleType_GetRelationTypes_ResPart[]
    end
end
function Base.getproperty(obj::RoleType_GetRelationTypes_ResPart, name::Symbol)
    if name === :relation_types
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{_Type}
    else
        getfield(obj, name)
    end
end

mutable struct RoleType_GetRelationTypes <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RoleType_GetRelationTypes(; kwargs...)
        obj = new(meta(RoleType_GetRelationTypes), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RoleType_GetRelationTypes
const __meta_RoleType_GetRelationTypes = Ref{ProtoMeta}()
function meta(::Type{RoleType_GetRelationTypes})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RoleType_GetRelationTypes)
            __meta_RoleType_GetRelationTypes[] = target = ProtoMeta(RoleType_GetRelationTypes)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, RoleType_GetRelationTypes, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RoleType_GetRelationTypes[]
    end
end

mutable struct RoleType_GetPlayers_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RoleType_GetPlayers_Req(; kwargs...)
        obj = new(meta(RoleType_GetPlayers_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RoleType_GetPlayers_Req
const __meta_RoleType_GetPlayers_Req = Ref{ProtoMeta}()
function meta(::Type{RoleType_GetPlayers_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RoleType_GetPlayers_Req)
            __meta_RoleType_GetPlayers_Req[] = target = ProtoMeta(RoleType_GetPlayers_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, RoleType_GetPlayers_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RoleType_GetPlayers_Req[]
    end
end

mutable struct RoleType_GetPlayers_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RoleType_GetPlayers_ResPart(; kwargs...)
        obj = new(meta(RoleType_GetPlayers_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RoleType_GetPlayers_ResPart
const __meta_RoleType_GetPlayers_ResPart = Ref{ProtoMeta}()
function meta(::Type{RoleType_GetPlayers_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RoleType_GetPlayers_ResPart)
            __meta_RoleType_GetPlayers_ResPart[] = target = ProtoMeta(RoleType_GetPlayers_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:thing_types => Base.Vector{_Type}]
            meta(target, RoleType_GetPlayers_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RoleType_GetPlayers_ResPart[]
    end
end
function Base.getproperty(obj::RoleType_GetPlayers_ResPart, name::Symbol)
    if name === :thing_types
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{_Type}
    else
        getfield(obj, name)
    end
end

mutable struct RoleType_GetPlayers <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RoleType_GetPlayers(; kwargs...)
        obj = new(meta(RoleType_GetPlayers), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RoleType_GetPlayers
const __meta_RoleType_GetPlayers = Ref{ProtoMeta}()
function meta(::Type{RoleType_GetPlayers})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RoleType_GetPlayers)
            __meta_RoleType_GetPlayers[] = target = ProtoMeta(RoleType_GetPlayers)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, RoleType_GetPlayers, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RoleType_GetPlayers[]
    end
end

mutable struct RoleType <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RoleType(; kwargs...)
        obj = new(meta(RoleType), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RoleType
const __meta_RoleType = Ref{ProtoMeta}()
function meta(::Type{RoleType})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RoleType)
            __meta_RoleType[] = target = ProtoMeta(RoleType)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, RoleType, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RoleType[]
    end
end

mutable struct ThingType_SetAbstract_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_SetAbstract_Req(; kwargs...)
        obj = new(meta(ThingType_SetAbstract_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_SetAbstract_Req
const __meta_ThingType_SetAbstract_Req = Ref{ProtoMeta}()
function meta(::Type{ThingType_SetAbstract_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_SetAbstract_Req)
            __meta_ThingType_SetAbstract_Req[] = target = ProtoMeta(ThingType_SetAbstract_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_SetAbstract_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_SetAbstract_Req[]
    end
end

mutable struct ThingType_SetAbstract_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_SetAbstract_Res(; kwargs...)
        obj = new(meta(ThingType_SetAbstract_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_SetAbstract_Res
const __meta_ThingType_SetAbstract_Res = Ref{ProtoMeta}()
function meta(::Type{ThingType_SetAbstract_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_SetAbstract_Res)
            __meta_ThingType_SetAbstract_Res[] = target = ProtoMeta(ThingType_SetAbstract_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_SetAbstract_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_SetAbstract_Res[]
    end
end

mutable struct ThingType_SetAbstract <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_SetAbstract(; kwargs...)
        obj = new(meta(ThingType_SetAbstract), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_SetAbstract
const __meta_ThingType_SetAbstract = Ref{ProtoMeta}()
function meta(::Type{ThingType_SetAbstract})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_SetAbstract)
            __meta_ThingType_SetAbstract[] = target = ProtoMeta(ThingType_SetAbstract)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_SetAbstract, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_SetAbstract[]
    end
end

mutable struct ThingType_UnsetAbstract_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_UnsetAbstract_Req(; kwargs...)
        obj = new(meta(ThingType_UnsetAbstract_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_UnsetAbstract_Req
const __meta_ThingType_UnsetAbstract_Req = Ref{ProtoMeta}()
function meta(::Type{ThingType_UnsetAbstract_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_UnsetAbstract_Req)
            __meta_ThingType_UnsetAbstract_Req[] = target = ProtoMeta(ThingType_UnsetAbstract_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_UnsetAbstract_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_UnsetAbstract_Req[]
    end
end

mutable struct ThingType_UnsetAbstract_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_UnsetAbstract_Res(; kwargs...)
        obj = new(meta(ThingType_UnsetAbstract_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_UnsetAbstract_Res
const __meta_ThingType_UnsetAbstract_Res = Ref{ProtoMeta}()
function meta(::Type{ThingType_UnsetAbstract_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_UnsetAbstract_Res)
            __meta_ThingType_UnsetAbstract_Res[] = target = ProtoMeta(ThingType_UnsetAbstract_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_UnsetAbstract_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_UnsetAbstract_Res[]
    end
end

mutable struct ThingType_UnsetAbstract <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_UnsetAbstract(; kwargs...)
        obj = new(meta(ThingType_UnsetAbstract), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_UnsetAbstract
const __meta_ThingType_UnsetAbstract = Ref{ProtoMeta}()
function meta(::Type{ThingType_UnsetAbstract})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_UnsetAbstract)
            __meta_ThingType_UnsetAbstract[] = target = ProtoMeta(ThingType_UnsetAbstract)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_UnsetAbstract, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_UnsetAbstract[]
    end
end

mutable struct ThingType_GetInstances_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_GetInstances_Req(; kwargs...)
        obj = new(meta(ThingType_GetInstances_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_GetInstances_Req
const __meta_ThingType_GetInstances_Req = Ref{ProtoMeta}()
function meta(::Type{ThingType_GetInstances_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_GetInstances_Req)
            __meta_ThingType_GetInstances_Req[] = target = ProtoMeta(ThingType_GetInstances_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_GetInstances_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_GetInstances_Req[]
    end
end

mutable struct ThingType_GetInstances_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_GetInstances_ResPart(; kwargs...)
        obj = new(meta(ThingType_GetInstances_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_GetInstances_ResPart
const __meta_ThingType_GetInstances_ResPart = Ref{ProtoMeta}()
function meta(::Type{ThingType_GetInstances_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_GetInstances_ResPart)
            __meta_ThingType_GetInstances_ResPart[] = target = ProtoMeta(ThingType_GetInstances_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:things => Base.Vector{Thing}]
            meta(target, ThingType_GetInstances_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_GetInstances_ResPart[]
    end
end
function Base.getproperty(obj::ThingType_GetInstances_ResPart, name::Symbol)
    if name === :things
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{Thing}
    else
        getfield(obj, name)
    end
end

mutable struct ThingType_GetInstances <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_GetInstances(; kwargs...)
        obj = new(meta(ThingType_GetInstances), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_GetInstances
const __meta_ThingType_GetInstances = Ref{ProtoMeta}()
function meta(::Type{ThingType_GetInstances})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_GetInstances)
            __meta_ThingType_GetInstances[] = target = ProtoMeta(ThingType_GetInstances)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_GetInstances, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_GetInstances[]
    end
end

mutable struct ThingType_GetOwns_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_GetOwns_Req(; kwargs...)
        obj = new(meta(ThingType_GetOwns_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_GetOwns_Req
const __meta_ThingType_GetOwns_Req = Ref{ProtoMeta}()
function meta(::Type{ThingType_GetOwns_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_GetOwns_Req)
            __meta_ThingType_GetOwns_Req[] = target = ProtoMeta(ThingType_GetOwns_Req)
            fnum = Int[1,3]
            allflds = Pair{Symbol,Union{Type,String}}[:value_type => Int32, :keys_only => Bool]
            oneofs = Int[1,0]
            oneof_names = Symbol[Symbol("filter")]
            meta(target, ThingType_GetOwns_Req, allflds, ProtoBuf.DEF_REQ, fnum, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_ThingType_GetOwns_Req[]
    end
end
function Base.getproperty(obj::ThingType_GetOwns_Req, name::Symbol)
    if name === :value_type
        return (obj.__protobuf_jl_internal_values[name])::Int32
    elseif name === :keys_only
        return (obj.__protobuf_jl_internal_values[name])::Bool
    else
        getfield(obj, name)
    end
end

mutable struct ThingType_GetOwns_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_GetOwns_ResPart(; kwargs...)
        obj = new(meta(ThingType_GetOwns_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_GetOwns_ResPart
const __meta_ThingType_GetOwns_ResPart = Ref{ProtoMeta}()
function meta(::Type{ThingType_GetOwns_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_GetOwns_ResPart)
            __meta_ThingType_GetOwns_ResPart[] = target = ProtoMeta(ThingType_GetOwns_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:attribute_types => Base.Vector{_Type}]
            meta(target, ThingType_GetOwns_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_GetOwns_ResPart[]
    end
end
function Base.getproperty(obj::ThingType_GetOwns_ResPart, name::Symbol)
    if name === :attribute_types
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{_Type}
    else
        getfield(obj, name)
    end
end

mutable struct ThingType_GetOwns <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_GetOwns(; kwargs...)
        obj = new(meta(ThingType_GetOwns), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_GetOwns
const __meta_ThingType_GetOwns = Ref{ProtoMeta}()
function meta(::Type{ThingType_GetOwns})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_GetOwns)
            __meta_ThingType_GetOwns[] = target = ProtoMeta(ThingType_GetOwns)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_GetOwns, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_GetOwns[]
    end
end

mutable struct ThingType_GetPlays_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_GetPlays_Req(; kwargs...)
        obj = new(meta(ThingType_GetPlays_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_GetPlays_Req
const __meta_ThingType_GetPlays_Req = Ref{ProtoMeta}()
function meta(::Type{ThingType_GetPlays_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_GetPlays_Req)
            __meta_ThingType_GetPlays_Req[] = target = ProtoMeta(ThingType_GetPlays_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_GetPlays_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_GetPlays_Req[]
    end
end

mutable struct ThingType_GetPlays_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_GetPlays_ResPart(; kwargs...)
        obj = new(meta(ThingType_GetPlays_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_GetPlays_ResPart
const __meta_ThingType_GetPlays_ResPart = Ref{ProtoMeta}()
function meta(::Type{ThingType_GetPlays_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_GetPlays_ResPart)
            __meta_ThingType_GetPlays_ResPart[] = target = ProtoMeta(ThingType_GetPlays_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:roles => Base.Vector{_Type}]
            meta(target, ThingType_GetPlays_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_GetPlays_ResPart[]
    end
end
function Base.getproperty(obj::ThingType_GetPlays_ResPart, name::Symbol)
    if name === :roles
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{_Type}
    else
        getfield(obj, name)
    end
end

mutable struct ThingType_GetPlays <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_GetPlays(; kwargs...)
        obj = new(meta(ThingType_GetPlays), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_GetPlays
const __meta_ThingType_GetPlays = Ref{ProtoMeta}()
function meta(::Type{ThingType_GetPlays})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_GetPlays)
            __meta_ThingType_GetPlays[] = target = ProtoMeta(ThingType_GetPlays)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_GetPlays, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_GetPlays[]
    end
end

mutable struct ThingType_SetOwns_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_SetOwns_Req(; kwargs...)
        obj = new(meta(ThingType_SetOwns_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_SetOwns_Req
const __meta_ThingType_SetOwns_Req = Ref{ProtoMeta}()
function meta(::Type{ThingType_SetOwns_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_SetOwns_Req)
            __meta_ThingType_SetOwns_Req[] = target = ProtoMeta(ThingType_SetOwns_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:attribute_type => _Type, :overridden_type => _Type, :is_key => Bool]
            oneofs = Int[0,1,0]
            oneof_names = Symbol[Symbol("overridden")]
            meta(target, ThingType_SetOwns_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_ThingType_SetOwns_Req[]
    end
end
function Base.getproperty(obj::ThingType_SetOwns_Req, name::Symbol)
    if name === :attribute_type
        return (obj.__protobuf_jl_internal_values[name])::_Type
    elseif name === :overridden_type
        return (obj.__protobuf_jl_internal_values[name])::_Type
    elseif name === :is_key
        return (obj.__protobuf_jl_internal_values[name])::Bool
    else
        getfield(obj, name)
    end
end

mutable struct ThingType_SetOwns_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_SetOwns_Res(; kwargs...)
        obj = new(meta(ThingType_SetOwns_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_SetOwns_Res
const __meta_ThingType_SetOwns_Res = Ref{ProtoMeta}()
function meta(::Type{ThingType_SetOwns_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_SetOwns_Res)
            __meta_ThingType_SetOwns_Res[] = target = ProtoMeta(ThingType_SetOwns_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_SetOwns_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_SetOwns_Res[]
    end
end

mutable struct ThingType_SetOwns <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_SetOwns(; kwargs...)
        obj = new(meta(ThingType_SetOwns), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_SetOwns
const __meta_ThingType_SetOwns = Ref{ProtoMeta}()
function meta(::Type{ThingType_SetOwns})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_SetOwns)
            __meta_ThingType_SetOwns[] = target = ProtoMeta(ThingType_SetOwns)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_SetOwns, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_SetOwns[]
    end
end

mutable struct ThingType_SetPlays_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_SetPlays_Req(; kwargs...)
        obj = new(meta(ThingType_SetPlays_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_SetPlays_Req
const __meta_ThingType_SetPlays_Req = Ref{ProtoMeta}()
function meta(::Type{ThingType_SetPlays_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_SetPlays_Req)
            __meta_ThingType_SetPlays_Req[] = target = ProtoMeta(ThingType_SetPlays_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:role => _Type, :overridden_role => _Type]
            oneofs = Int[0,1]
            oneof_names = Symbol[Symbol("overridden")]
            meta(target, ThingType_SetPlays_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_ThingType_SetPlays_Req[]
    end
end
function Base.getproperty(obj::ThingType_SetPlays_Req, name::Symbol)
    if name === :role
        return (obj.__protobuf_jl_internal_values[name])::_Type
    elseif name === :overridden_role
        return (obj.__protobuf_jl_internal_values[name])::_Type
    else
        getfield(obj, name)
    end
end

mutable struct ThingType_SetPlays_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_SetPlays_Res(; kwargs...)
        obj = new(meta(ThingType_SetPlays_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_SetPlays_Res
const __meta_ThingType_SetPlays_Res = Ref{ProtoMeta}()
function meta(::Type{ThingType_SetPlays_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_SetPlays_Res)
            __meta_ThingType_SetPlays_Res[] = target = ProtoMeta(ThingType_SetPlays_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_SetPlays_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_SetPlays_Res[]
    end
end

mutable struct ThingType_SetPlays <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_SetPlays(; kwargs...)
        obj = new(meta(ThingType_SetPlays), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_SetPlays
const __meta_ThingType_SetPlays = Ref{ProtoMeta}()
function meta(::Type{ThingType_SetPlays})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_SetPlays)
            __meta_ThingType_SetPlays[] = target = ProtoMeta(ThingType_SetPlays)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_SetPlays, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_SetPlays[]
    end
end

mutable struct ThingType_UnsetOwns_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_UnsetOwns_Req(; kwargs...)
        obj = new(meta(ThingType_UnsetOwns_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_UnsetOwns_Req
const __meta_ThingType_UnsetOwns_Req = Ref{ProtoMeta}()
function meta(::Type{ThingType_UnsetOwns_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_UnsetOwns_Req)
            __meta_ThingType_UnsetOwns_Req[] = target = ProtoMeta(ThingType_UnsetOwns_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:attribute_type => _Type]
            meta(target, ThingType_UnsetOwns_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_UnsetOwns_Req[]
    end
end
function Base.getproperty(obj::ThingType_UnsetOwns_Req, name::Symbol)
    if name === :attribute_type
        return (obj.__protobuf_jl_internal_values[name])::_Type
    else
        getfield(obj, name)
    end
end

mutable struct ThingType_UnsetOwns_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_UnsetOwns_Res(; kwargs...)
        obj = new(meta(ThingType_UnsetOwns_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_UnsetOwns_Res
const __meta_ThingType_UnsetOwns_Res = Ref{ProtoMeta}()
function meta(::Type{ThingType_UnsetOwns_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_UnsetOwns_Res)
            __meta_ThingType_UnsetOwns_Res[] = target = ProtoMeta(ThingType_UnsetOwns_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_UnsetOwns_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_UnsetOwns_Res[]
    end
end

mutable struct ThingType_UnsetOwns <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_UnsetOwns(; kwargs...)
        obj = new(meta(ThingType_UnsetOwns), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_UnsetOwns
const __meta_ThingType_UnsetOwns = Ref{ProtoMeta}()
function meta(::Type{ThingType_UnsetOwns})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_UnsetOwns)
            __meta_ThingType_UnsetOwns[] = target = ProtoMeta(ThingType_UnsetOwns)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_UnsetOwns, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_UnsetOwns[]
    end
end

mutable struct ThingType_UnsetPlays_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_UnsetPlays_Req(; kwargs...)
        obj = new(meta(ThingType_UnsetPlays_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_UnsetPlays_Req
const __meta_ThingType_UnsetPlays_Req = Ref{ProtoMeta}()
function meta(::Type{ThingType_UnsetPlays_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_UnsetPlays_Req)
            __meta_ThingType_UnsetPlays_Req[] = target = ProtoMeta(ThingType_UnsetPlays_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:role => _Type]
            meta(target, ThingType_UnsetPlays_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_UnsetPlays_Req[]
    end
end
function Base.getproperty(obj::ThingType_UnsetPlays_Req, name::Symbol)
    if name === :role
        return (obj.__protobuf_jl_internal_values[name])::_Type
    else
        getfield(obj, name)
    end
end

mutable struct ThingType_UnsetPlays_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_UnsetPlays_Res(; kwargs...)
        obj = new(meta(ThingType_UnsetPlays_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_UnsetPlays_Res
const __meta_ThingType_UnsetPlays_Res = Ref{ProtoMeta}()
function meta(::Type{ThingType_UnsetPlays_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_UnsetPlays_Res)
            __meta_ThingType_UnsetPlays_Res[] = target = ProtoMeta(ThingType_UnsetPlays_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_UnsetPlays_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_UnsetPlays_Res[]
    end
end

mutable struct ThingType_UnsetPlays <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType_UnsetPlays(; kwargs...)
        obj = new(meta(ThingType_UnsetPlays), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType_UnsetPlays
const __meta_ThingType_UnsetPlays = Ref{ProtoMeta}()
function meta(::Type{ThingType_UnsetPlays})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType_UnsetPlays)
            __meta_ThingType_UnsetPlays[] = target = ProtoMeta(ThingType_UnsetPlays)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType_UnsetPlays, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType_UnsetPlays[]
    end
end

mutable struct ThingType <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ThingType(; kwargs...)
        obj = new(meta(ThingType), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ThingType
const __meta_ThingType = Ref{ProtoMeta}()
function meta(::Type{ThingType})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ThingType)
            __meta_ThingType[] = target = ProtoMeta(ThingType)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, ThingType, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ThingType[]
    end
end

mutable struct EntityType_Create_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function EntityType_Create_Req(; kwargs...)
        obj = new(meta(EntityType_Create_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct EntityType_Create_Req
const __meta_EntityType_Create_Req = Ref{ProtoMeta}()
function meta(::Type{EntityType_Create_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_EntityType_Create_Req)
            __meta_EntityType_Create_Req[] = target = ProtoMeta(EntityType_Create_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, EntityType_Create_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_EntityType_Create_Req[]
    end
end

mutable struct EntityType_Create_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function EntityType_Create_Res(; kwargs...)
        obj = new(meta(EntityType_Create_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct EntityType_Create_Res
const __meta_EntityType_Create_Res = Ref{ProtoMeta}()
function meta(::Type{EntityType_Create_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_EntityType_Create_Res)
            __meta_EntityType_Create_Res[] = target = ProtoMeta(EntityType_Create_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:entity => Thing]
            meta(target, EntityType_Create_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_EntityType_Create_Res[]
    end
end
function Base.getproperty(obj::EntityType_Create_Res, name::Symbol)
    if name === :entity
        return (obj.__protobuf_jl_internal_values[name])::Thing
    else
        getfield(obj, name)
    end
end

mutable struct EntityType_Create <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function EntityType_Create(; kwargs...)
        obj = new(meta(EntityType_Create), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct EntityType_Create
const __meta_EntityType_Create = Ref{ProtoMeta}()
function meta(::Type{EntityType_Create})
    ProtoBuf.metalock() do
        if !isassigned(__meta_EntityType_Create)
            __meta_EntityType_Create[] = target = ProtoMeta(EntityType_Create)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, EntityType_Create, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_EntityType_Create[]
    end
end

mutable struct EntityType <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function EntityType(; kwargs...)
        obj = new(meta(EntityType), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct EntityType
const __meta_EntityType = Ref{ProtoMeta}()
function meta(::Type{EntityType})
    ProtoBuf.metalock() do
        if !isassigned(__meta_EntityType)
            __meta_EntityType[] = target = ProtoMeta(EntityType)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, EntityType, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_EntityType[]
    end
end

mutable struct RelationType_Create_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RelationType_Create_Req(; kwargs...)
        obj = new(meta(RelationType_Create_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RelationType_Create_Req
const __meta_RelationType_Create_Req = Ref{ProtoMeta}()
function meta(::Type{RelationType_Create_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RelationType_Create_Req)
            __meta_RelationType_Create_Req[] = target = ProtoMeta(RelationType_Create_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, RelationType_Create_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RelationType_Create_Req[]
    end
end

mutable struct RelationType_Create_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RelationType_Create_Res(; kwargs...)
        obj = new(meta(RelationType_Create_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RelationType_Create_Res
const __meta_RelationType_Create_Res = Ref{ProtoMeta}()
function meta(::Type{RelationType_Create_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RelationType_Create_Res)
            __meta_RelationType_Create_Res[] = target = ProtoMeta(RelationType_Create_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:relation => Thing]
            meta(target, RelationType_Create_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RelationType_Create_Res[]
    end
end
function Base.getproperty(obj::RelationType_Create_Res, name::Symbol)
    if name === :relation
        return (obj.__protobuf_jl_internal_values[name])::Thing
    else
        getfield(obj, name)
    end
end

mutable struct RelationType_Create <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RelationType_Create(; kwargs...)
        obj = new(meta(RelationType_Create), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RelationType_Create
const __meta_RelationType_Create = Ref{ProtoMeta}()
function meta(::Type{RelationType_Create})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RelationType_Create)
            __meta_RelationType_Create[] = target = ProtoMeta(RelationType_Create)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, RelationType_Create, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RelationType_Create[]
    end
end

mutable struct RelationType_GetRelates_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RelationType_GetRelates_Req(; kwargs...)
        obj = new(meta(RelationType_GetRelates_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RelationType_GetRelates_Req
const __meta_RelationType_GetRelates_Req = Ref{ProtoMeta}()
function meta(::Type{RelationType_GetRelates_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RelationType_GetRelates_Req)
            __meta_RelationType_GetRelates_Req[] = target = ProtoMeta(RelationType_GetRelates_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, RelationType_GetRelates_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RelationType_GetRelates_Req[]
    end
end

mutable struct RelationType_GetRelates_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RelationType_GetRelates_ResPart(; kwargs...)
        obj = new(meta(RelationType_GetRelates_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RelationType_GetRelates_ResPart
const __meta_RelationType_GetRelates_ResPart = Ref{ProtoMeta}()
function meta(::Type{RelationType_GetRelates_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RelationType_GetRelates_ResPart)
            __meta_RelationType_GetRelates_ResPart[] = target = ProtoMeta(RelationType_GetRelates_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:roles => Base.Vector{_Type}]
            meta(target, RelationType_GetRelates_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RelationType_GetRelates_ResPart[]
    end
end
function Base.getproperty(obj::RelationType_GetRelates_ResPart, name::Symbol)
    if name === :roles
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{_Type}
    else
        getfield(obj, name)
    end
end

mutable struct RelationType_GetRelates <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RelationType_GetRelates(; kwargs...)
        obj = new(meta(RelationType_GetRelates), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RelationType_GetRelates
const __meta_RelationType_GetRelates = Ref{ProtoMeta}()
function meta(::Type{RelationType_GetRelates})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RelationType_GetRelates)
            __meta_RelationType_GetRelates[] = target = ProtoMeta(RelationType_GetRelates)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, RelationType_GetRelates, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RelationType_GetRelates[]
    end
end

mutable struct RelationType_GetRelatesForRoleLabel_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RelationType_GetRelatesForRoleLabel_Req(; kwargs...)
        obj = new(meta(RelationType_GetRelatesForRoleLabel_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RelationType_GetRelatesForRoleLabel_Req
const __meta_RelationType_GetRelatesForRoleLabel_Req = Ref{ProtoMeta}()
function meta(::Type{RelationType_GetRelatesForRoleLabel_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RelationType_GetRelatesForRoleLabel_Req)
            __meta_RelationType_GetRelatesForRoleLabel_Req[] = target = ProtoMeta(RelationType_GetRelatesForRoleLabel_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:label => AbstractString]
            meta(target, RelationType_GetRelatesForRoleLabel_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RelationType_GetRelatesForRoleLabel_Req[]
    end
end
function Base.getproperty(obj::RelationType_GetRelatesForRoleLabel_Req, name::Symbol)
    if name === :label
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct RelationType_GetRelatesForRoleLabel_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RelationType_GetRelatesForRoleLabel_Res(; kwargs...)
        obj = new(meta(RelationType_GetRelatesForRoleLabel_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RelationType_GetRelatesForRoleLabel_Res
const __meta_RelationType_GetRelatesForRoleLabel_Res = Ref{ProtoMeta}()
function meta(::Type{RelationType_GetRelatesForRoleLabel_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RelationType_GetRelatesForRoleLabel_Res)
            __meta_RelationType_GetRelatesForRoleLabel_Res[] = target = ProtoMeta(RelationType_GetRelatesForRoleLabel_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:role_type => _Type]
            oneofs = Int[1]
            oneof_names = Symbol[Symbol("role")]
            meta(target, RelationType_GetRelatesForRoleLabel_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_RelationType_GetRelatesForRoleLabel_Res[]
    end
end
function Base.getproperty(obj::RelationType_GetRelatesForRoleLabel_Res, name::Symbol)
    if name === :role_type
        return (obj.__protobuf_jl_internal_values[name])::_Type
    else
        getfield(obj, name)
    end
end

mutable struct RelationType_GetRelatesForRoleLabel <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RelationType_GetRelatesForRoleLabel(; kwargs...)
        obj = new(meta(RelationType_GetRelatesForRoleLabel), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RelationType_GetRelatesForRoleLabel
const __meta_RelationType_GetRelatesForRoleLabel = Ref{ProtoMeta}()
function meta(::Type{RelationType_GetRelatesForRoleLabel})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RelationType_GetRelatesForRoleLabel)
            __meta_RelationType_GetRelatesForRoleLabel[] = target = ProtoMeta(RelationType_GetRelatesForRoleLabel)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, RelationType_GetRelatesForRoleLabel, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RelationType_GetRelatesForRoleLabel[]
    end
end

mutable struct RelationType_SetRelates_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RelationType_SetRelates_Req(; kwargs...)
        obj = new(meta(RelationType_SetRelates_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RelationType_SetRelates_Req
const __meta_RelationType_SetRelates_Req = Ref{ProtoMeta}()
function meta(::Type{RelationType_SetRelates_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RelationType_SetRelates_Req)
            __meta_RelationType_SetRelates_Req[] = target = ProtoMeta(RelationType_SetRelates_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:label => AbstractString, :overridden_label => AbstractString]
            oneofs = Int[0,1]
            oneof_names = Symbol[Symbol("overridden")]
            meta(target, RelationType_SetRelates_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_RelationType_SetRelates_Req[]
    end
end
function Base.getproperty(obj::RelationType_SetRelates_Req, name::Symbol)
    if name === :label
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :overridden_label
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct RelationType_SetRelates_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RelationType_SetRelates_Res(; kwargs...)
        obj = new(meta(RelationType_SetRelates_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RelationType_SetRelates_Res
const __meta_RelationType_SetRelates_Res = Ref{ProtoMeta}()
function meta(::Type{RelationType_SetRelates_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RelationType_SetRelates_Res)
            __meta_RelationType_SetRelates_Res[] = target = ProtoMeta(RelationType_SetRelates_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, RelationType_SetRelates_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RelationType_SetRelates_Res[]
    end
end

mutable struct RelationType_SetRelates <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RelationType_SetRelates(; kwargs...)
        obj = new(meta(RelationType_SetRelates), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RelationType_SetRelates
const __meta_RelationType_SetRelates = Ref{ProtoMeta}()
function meta(::Type{RelationType_SetRelates})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RelationType_SetRelates)
            __meta_RelationType_SetRelates[] = target = ProtoMeta(RelationType_SetRelates)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, RelationType_SetRelates, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RelationType_SetRelates[]
    end
end

mutable struct RelationType_UnsetRelates_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RelationType_UnsetRelates_Req(; kwargs...)
        obj = new(meta(RelationType_UnsetRelates_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RelationType_UnsetRelates_Req
const __meta_RelationType_UnsetRelates_Req = Ref{ProtoMeta}()
function meta(::Type{RelationType_UnsetRelates_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RelationType_UnsetRelates_Req)
            __meta_RelationType_UnsetRelates_Req[] = target = ProtoMeta(RelationType_UnsetRelates_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:label => AbstractString]
            meta(target, RelationType_UnsetRelates_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RelationType_UnsetRelates_Req[]
    end
end
function Base.getproperty(obj::RelationType_UnsetRelates_Req, name::Symbol)
    if name === :label
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct RelationType_UnsetRelates_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RelationType_UnsetRelates_Res(; kwargs...)
        obj = new(meta(RelationType_UnsetRelates_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RelationType_UnsetRelates_Res
const __meta_RelationType_UnsetRelates_Res = Ref{ProtoMeta}()
function meta(::Type{RelationType_UnsetRelates_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RelationType_UnsetRelates_Res)
            __meta_RelationType_UnsetRelates_Res[] = target = ProtoMeta(RelationType_UnsetRelates_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, RelationType_UnsetRelates_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RelationType_UnsetRelates_Res[]
    end
end

mutable struct RelationType_UnsetRelates <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RelationType_UnsetRelates(; kwargs...)
        obj = new(meta(RelationType_UnsetRelates), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RelationType_UnsetRelates
const __meta_RelationType_UnsetRelates = Ref{ProtoMeta}()
function meta(::Type{RelationType_UnsetRelates})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RelationType_UnsetRelates)
            __meta_RelationType_UnsetRelates[] = target = ProtoMeta(RelationType_UnsetRelates)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, RelationType_UnsetRelates, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RelationType_UnsetRelates[]
    end
end

mutable struct RelationType <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function RelationType(; kwargs...)
        obj = new(meta(RelationType), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct RelationType
const __meta_RelationType = Ref{ProtoMeta}()
function meta(::Type{RelationType})
    ProtoBuf.metalock() do
        if !isassigned(__meta_RelationType)
            __meta_RelationType[] = target = ProtoMeta(RelationType)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, RelationType, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_RelationType[]
    end
end

const AttributeType_ValueType = (;[
    Symbol("OBJECT") => Int32(0),
    Symbol("BOOLEAN") => Int32(1),
    Symbol("LONG") => Int32(2),
    Symbol("DOUBLE") => Int32(3),
    Symbol("STRING") => Int32(4),
    Symbol("DATETIME") => Int32(5),
]...)

mutable struct AttributeType_Put_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_Put_Req(; kwargs...)
        obj = new(meta(AttributeType_Put_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_Put_Req
const __meta_AttributeType_Put_Req = Ref{ProtoMeta}()
function meta(::Type{AttributeType_Put_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_Put_Req)
            __meta_AttributeType_Put_Req[] = target = ProtoMeta(AttributeType_Put_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:value => Attribute_Value]
            meta(target, AttributeType_Put_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_Put_Req[]
    end
end
function Base.getproperty(obj::AttributeType_Put_Req, name::Symbol)
    if name === :value
        return (obj.__protobuf_jl_internal_values[name])::Attribute_Value
    else
        getfield(obj, name)
    end
end

mutable struct AttributeType_Put_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_Put_Res(; kwargs...)
        obj = new(meta(AttributeType_Put_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_Put_Res
const __meta_AttributeType_Put_Res = Ref{ProtoMeta}()
function meta(::Type{AttributeType_Put_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_Put_Res)
            __meta_AttributeType_Put_Res[] = target = ProtoMeta(AttributeType_Put_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:attribute => Thing]
            meta(target, AttributeType_Put_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_Put_Res[]
    end
end
function Base.getproperty(obj::AttributeType_Put_Res, name::Symbol)
    if name === :attribute
        return (obj.__protobuf_jl_internal_values[name])::Thing
    else
        getfield(obj, name)
    end
end

mutable struct AttributeType_Put <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_Put(; kwargs...)
        obj = new(meta(AttributeType_Put), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_Put
const __meta_AttributeType_Put = Ref{ProtoMeta}()
function meta(::Type{AttributeType_Put})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_Put)
            __meta_AttributeType_Put[] = target = ProtoMeta(AttributeType_Put)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, AttributeType_Put, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_Put[]
    end
end

mutable struct AttributeType_Get_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_Get_Req(; kwargs...)
        obj = new(meta(AttributeType_Get_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_Get_Req
const __meta_AttributeType_Get_Req = Ref{ProtoMeta}()
function meta(::Type{AttributeType_Get_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_Get_Req)
            __meta_AttributeType_Get_Req[] = target = ProtoMeta(AttributeType_Get_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:value => Attribute_Value]
            meta(target, AttributeType_Get_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_Get_Req[]
    end
end
function Base.getproperty(obj::AttributeType_Get_Req, name::Symbol)
    if name === :value
        return (obj.__protobuf_jl_internal_values[name])::Attribute_Value
    else
        getfield(obj, name)
    end
end

mutable struct AttributeType_Get_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_Get_Res(; kwargs...)
        obj = new(meta(AttributeType_Get_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_Get_Res
const __meta_AttributeType_Get_Res = Ref{ProtoMeta}()
function meta(::Type{AttributeType_Get_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_Get_Res)
            __meta_AttributeType_Get_Res[] = target = ProtoMeta(AttributeType_Get_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:attribute => Thing]
            oneofs = Int[1]
            oneof_names = Symbol[Symbol("res")]
            meta(target, AttributeType_Get_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_AttributeType_Get_Res[]
    end
end
function Base.getproperty(obj::AttributeType_Get_Res, name::Symbol)
    if name === :attribute
        return (obj.__protobuf_jl_internal_values[name])::Thing
    else
        getfield(obj, name)
    end
end

mutable struct AttributeType_Get <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_Get(; kwargs...)
        obj = new(meta(AttributeType_Get), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_Get
const __meta_AttributeType_Get = Ref{ProtoMeta}()
function meta(::Type{AttributeType_Get})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_Get)
            __meta_AttributeType_Get[] = target = ProtoMeta(AttributeType_Get)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, AttributeType_Get, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_Get[]
    end
end

mutable struct AttributeType_GetOwners_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_GetOwners_Req(; kwargs...)
        obj = new(meta(AttributeType_GetOwners_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_GetOwners_Req
const __meta_AttributeType_GetOwners_Req = Ref{ProtoMeta}()
function meta(::Type{AttributeType_GetOwners_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_GetOwners_Req)
            __meta_AttributeType_GetOwners_Req[] = target = ProtoMeta(AttributeType_GetOwners_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:only_key => Bool]
            meta(target, AttributeType_GetOwners_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_GetOwners_Req[]
    end
end
function Base.getproperty(obj::AttributeType_GetOwners_Req, name::Symbol)
    if name === :only_key
        return (obj.__protobuf_jl_internal_values[name])::Bool
    else
        getfield(obj, name)
    end
end

mutable struct AttributeType_GetOwners_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_GetOwners_ResPart(; kwargs...)
        obj = new(meta(AttributeType_GetOwners_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_GetOwners_ResPart
const __meta_AttributeType_GetOwners_ResPart = Ref{ProtoMeta}()
function meta(::Type{AttributeType_GetOwners_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_GetOwners_ResPart)
            __meta_AttributeType_GetOwners_ResPart[] = target = ProtoMeta(AttributeType_GetOwners_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:owners => Base.Vector{_Type}]
            meta(target, AttributeType_GetOwners_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_GetOwners_ResPart[]
    end
end
function Base.getproperty(obj::AttributeType_GetOwners_ResPart, name::Symbol)
    if name === :owners
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{_Type}
    else
        getfield(obj, name)
    end
end

mutable struct Type_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_ResPart(; kwargs...)
        obj = new(meta(Type_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_ResPart
const __meta_Type_ResPart = Ref{ProtoMeta}()
function meta(::Type{Type_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_ResPart)
            __meta_Type_ResPart[] = target = ProtoMeta(Type_ResPart)
            fnum = Int[100,101,200,201,300,301,302,500,600]
            allflds = Pair{Symbol,Union{Type,String}}[:type_get_supertypes_res_part => Type_GetSupertypes_ResPart, :type_get_subtypes_res_part => Type_GetSubtypes_ResPart, :role_type_get_relation_types_res_part => RoleType_GetRelationTypes_ResPart, :role_type_get_players_res_part => RoleType_GetPlayers_ResPart, :thing_type_get_instances_res_part => ThingType_GetInstances_ResPart, :thing_type_get_owns_res_part => ThingType_GetOwns_ResPart, :thing_type_get_plays_res_part => ThingType_GetPlays_ResPart, :relation_type_get_relates_res_part => RelationType_GetRelates_ResPart, :attribute_type_get_owners_res_part => AttributeType_GetOwners_ResPart]
            oneofs = Int[1,1,1,1,1,1,1,1,1]
            oneof_names = Symbol[Symbol("res")]
            meta(target, Type_ResPart, allflds, ProtoBuf.DEF_REQ, fnum, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Type_ResPart[]
    end
end
function Base.getproperty(obj::Type_ResPart, name::Symbol)
    if name === :type_get_supertypes_res_part
        return (obj.__protobuf_jl_internal_values[name])::Type_GetSupertypes_ResPart
    elseif name === :type_get_subtypes_res_part
        return (obj.__protobuf_jl_internal_values[name])::Type_GetSubtypes_ResPart
    elseif name === :role_type_get_relation_types_res_part
        return (obj.__protobuf_jl_internal_values[name])::RoleType_GetRelationTypes_ResPart
    elseif name === :role_type_get_players_res_part
        return (obj.__protobuf_jl_internal_values[name])::RoleType_GetPlayers_ResPart
    elseif name === :thing_type_get_instances_res_part
        return (obj.__protobuf_jl_internal_values[name])::ThingType_GetInstances_ResPart
    elseif name === :thing_type_get_owns_res_part
        return (obj.__protobuf_jl_internal_values[name])::ThingType_GetOwns_ResPart
    elseif name === :thing_type_get_plays_res_part
        return (obj.__protobuf_jl_internal_values[name])::ThingType_GetPlays_ResPart
    elseif name === :relation_type_get_relates_res_part
        return (obj.__protobuf_jl_internal_values[name])::RelationType_GetRelates_ResPart
    elseif name === :attribute_type_get_owners_res_part
        return (obj.__protobuf_jl_internal_values[name])::AttributeType_GetOwners_ResPart
    else
        getfield(obj, name)
    end
end

mutable struct AttributeType_GetOwners <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_GetOwners(; kwargs...)
        obj = new(meta(AttributeType_GetOwners), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_GetOwners
const __meta_AttributeType_GetOwners = Ref{ProtoMeta}()
function meta(::Type{AttributeType_GetOwners})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_GetOwners)
            __meta_AttributeType_GetOwners[] = target = ProtoMeta(AttributeType_GetOwners)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, AttributeType_GetOwners, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_GetOwners[]
    end
end

mutable struct AttributeType_GetRegex_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_GetRegex_Req(; kwargs...)
        obj = new(meta(AttributeType_GetRegex_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_GetRegex_Req
const __meta_AttributeType_GetRegex_Req = Ref{ProtoMeta}()
function meta(::Type{AttributeType_GetRegex_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_GetRegex_Req)
            __meta_AttributeType_GetRegex_Req[] = target = ProtoMeta(AttributeType_GetRegex_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, AttributeType_GetRegex_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_GetRegex_Req[]
    end
end

mutable struct AttributeType_GetRegex_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_GetRegex_Res(; kwargs...)
        obj = new(meta(AttributeType_GetRegex_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_GetRegex_Res
const __meta_AttributeType_GetRegex_Res = Ref{ProtoMeta}()
function meta(::Type{AttributeType_GetRegex_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_GetRegex_Res)
            __meta_AttributeType_GetRegex_Res[] = target = ProtoMeta(AttributeType_GetRegex_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:regex => AbstractString]
            meta(target, AttributeType_GetRegex_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_GetRegex_Res[]
    end
end
function Base.getproperty(obj::AttributeType_GetRegex_Res, name::Symbol)
    if name === :regex
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct AttributeType_GetRegex <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_GetRegex(; kwargs...)
        obj = new(meta(AttributeType_GetRegex), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_GetRegex
const __meta_AttributeType_GetRegex = Ref{ProtoMeta}()
function meta(::Type{AttributeType_GetRegex})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_GetRegex)
            __meta_AttributeType_GetRegex[] = target = ProtoMeta(AttributeType_GetRegex)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, AttributeType_GetRegex, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_GetRegex[]
    end
end

mutable struct AttributeType_SetRegex_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_SetRegex_Req(; kwargs...)
        obj = new(meta(AttributeType_SetRegex_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_SetRegex_Req
const __meta_AttributeType_SetRegex_Req = Ref{ProtoMeta}()
function meta(::Type{AttributeType_SetRegex_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_SetRegex_Req)
            __meta_AttributeType_SetRegex_Req[] = target = ProtoMeta(AttributeType_SetRegex_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:regex => AbstractString]
            meta(target, AttributeType_SetRegex_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_SetRegex_Req[]
    end
end
function Base.getproperty(obj::AttributeType_SetRegex_Req, name::Symbol)
    if name === :regex
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct Type_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_Req(; kwargs...)
        obj = new(meta(Type_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_Req
const __meta_Type_Req = Ref{ProtoMeta}()
function meta(::Type{Type_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_Req)
            __meta_Type_Req[] = target = ProtoMeta(Type_Req)
            fnum = Int[1,2,100,101,102,103,104,105,106,200,201,300,301,302,303,304,305,306,307,308,400,500,501,502,503,504,600,601,602,603,604]
            allflds = Pair{Symbol,Union{Type,String}}[:label => AbstractString, :scope => AbstractString, :type_delete_req => Type_Delete_Req, :type_set_label_req => Type_SetLabel_Req, :type_is_abstract_req => Type_IsAbstract_Req, :type_get_supertype_req => Type_GetSupertype_Req, :type_set_supertype_req => Type_SetSupertype_Req, :type_get_supertypes_req => Type_GetSupertypes_Req, :type_get_subtypes_req => Type_GetSubtypes_Req, :role_type_get_relation_types_req => RoleType_GetRelationTypes_Req, :role_type_get_players_req => RoleType_GetPlayers_Req, :thing_type_get_instances_req => ThingType_GetInstances_Req, :thing_type_set_abstract_req => ThingType_SetAbstract_Req, :thing_type_unset_abstract_req => ThingType_UnsetAbstract_Req, :thing_type_get_owns_req => ThingType_GetOwns_Req, :thing_type_set_owns_req => ThingType_SetOwns_Req, :thing_type_unset_owns_req => ThingType_UnsetOwns_Req, :thing_type_get_plays_req => ThingType_GetPlays_Req, :thing_type_set_plays_req => ThingType_SetPlays_Req, :thing_type_unset_plays_req => ThingType_UnsetPlays_Req, :entity_type_create_req => EntityType_Create_Req, :relation_type_create_req => RelationType_Create_Req, :relation_type_get_relates_for_role_label_req => RelationType_GetRelatesForRoleLabel_Req, :relation_type_get_relates_req => RelationType_GetRelates_Req, :relation_type_set_relates_req => RelationType_SetRelates_Req, :relation_type_unset_relates_req => RelationType_UnsetRelates_Req, :attribute_type_put_req => AttributeType_Put_Req, :attribute_type_get_req => AttributeType_Get_Req, :attribute_type_get_regex_req => AttributeType_GetRegex_Req, :attribute_type_set_regex_req => AttributeType_SetRegex_Req, :attribute_type_get_owners_req => AttributeType_GetOwners_Req]
            oneofs = Int[0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
            oneof_names = Symbol[Symbol("req")]
            meta(target, Type_Req, allflds, ProtoBuf.DEF_REQ, fnum, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Type_Req[]
    end
end
function Base.getproperty(obj::Type_Req, name::Symbol)
    if name === :label
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :scope
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :type_delete_req
        return (obj.__protobuf_jl_internal_values[name])::Type_Delete_Req
    elseif name === :type_set_label_req
        return (obj.__protobuf_jl_internal_values[name])::Type_SetLabel_Req
    elseif name === :type_is_abstract_req
        return (obj.__protobuf_jl_internal_values[name])::Type_IsAbstract_Req
    elseif name === :type_get_supertype_req
        return (obj.__protobuf_jl_internal_values[name])::Type_GetSupertype_Req
    elseif name === :type_set_supertype_req
        return (obj.__protobuf_jl_internal_values[name])::Type_SetSupertype_Req
    elseif name === :type_get_supertypes_req
        return (obj.__protobuf_jl_internal_values[name])::Type_GetSupertypes_Req
    elseif name === :type_get_subtypes_req
        return (obj.__protobuf_jl_internal_values[name])::Type_GetSubtypes_Req
    elseif name === :role_type_get_relation_types_req
        return (obj.__protobuf_jl_internal_values[name])::RoleType_GetRelationTypes_Req
    elseif name === :role_type_get_players_req
        return (obj.__protobuf_jl_internal_values[name])::RoleType_GetPlayers_Req
    elseif name === :thing_type_get_instances_req
        return (obj.__protobuf_jl_internal_values[name])::ThingType_GetInstances_Req
    elseif name === :thing_type_set_abstract_req
        return (obj.__protobuf_jl_internal_values[name])::ThingType_SetAbstract_Req
    elseif name === :thing_type_unset_abstract_req
        return (obj.__protobuf_jl_internal_values[name])::ThingType_UnsetAbstract_Req
    elseif name === :thing_type_get_owns_req
        return (obj.__protobuf_jl_internal_values[name])::ThingType_GetOwns_Req
    elseif name === :thing_type_set_owns_req
        return (obj.__protobuf_jl_internal_values[name])::ThingType_SetOwns_Req
    elseif name === :thing_type_unset_owns_req
        return (obj.__protobuf_jl_internal_values[name])::ThingType_UnsetOwns_Req
    elseif name === :thing_type_get_plays_req
        return (obj.__protobuf_jl_internal_values[name])::ThingType_GetPlays_Req
    elseif name === :thing_type_set_plays_req
        return (obj.__protobuf_jl_internal_values[name])::ThingType_SetPlays_Req
    elseif name === :thing_type_unset_plays_req
        return (obj.__protobuf_jl_internal_values[name])::ThingType_UnsetPlays_Req
    elseif name === :entity_type_create_req
        return (obj.__protobuf_jl_internal_values[name])::EntityType_Create_Req
    elseif name === :relation_type_create_req
        return (obj.__protobuf_jl_internal_values[name])::RelationType_Create_Req
    elseif name === :relation_type_get_relates_for_role_label_req
        return (obj.__protobuf_jl_internal_values[name])::RelationType_GetRelatesForRoleLabel_Req
    elseif name === :relation_type_get_relates_req
        return (obj.__protobuf_jl_internal_values[name])::RelationType_GetRelates_Req
    elseif name === :relation_type_set_relates_req
        return (obj.__protobuf_jl_internal_values[name])::RelationType_SetRelates_Req
    elseif name === :relation_type_unset_relates_req
        return (obj.__protobuf_jl_internal_values[name])::RelationType_UnsetRelates_Req
    elseif name === :attribute_type_put_req
        return (obj.__protobuf_jl_internal_values[name])::AttributeType_Put_Req
    elseif name === :attribute_type_get_req
        return (obj.__protobuf_jl_internal_values[name])::AttributeType_Get_Req
    elseif name === :attribute_type_get_regex_req
        return (obj.__protobuf_jl_internal_values[name])::AttributeType_GetRegex_Req
    elseif name === :attribute_type_set_regex_req
        return (obj.__protobuf_jl_internal_values[name])::AttributeType_SetRegex_Req
    elseif name === :attribute_type_get_owners_req
        return (obj.__protobuf_jl_internal_values[name])::AttributeType_GetOwners_Req
    else
        getfield(obj, name)
    end
end

mutable struct AttributeType_SetRegex_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_SetRegex_Res(; kwargs...)
        obj = new(meta(AttributeType_SetRegex_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_SetRegex_Res
const __meta_AttributeType_SetRegex_Res = Ref{ProtoMeta}()
function meta(::Type{AttributeType_SetRegex_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_SetRegex_Res)
            __meta_AttributeType_SetRegex_Res[] = target = ProtoMeta(AttributeType_SetRegex_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, AttributeType_SetRegex_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_SetRegex_Res[]
    end
end

mutable struct Type_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Type_Res(; kwargs...)
        obj = new(meta(Type_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Type_Res
const __meta_Type_Res = Ref{ProtoMeta}()
function meta(::Type{Type_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Type_Res)
            __meta_Type_Res[] = target = ProtoMeta(Type_Res)
            fnum = Int[100,101,102,103,104,300,301,302,303,304,305,400,500,501,502,503,600,601,602,603]
            allflds = Pair{Symbol,Union{Type,String}}[:type_delete_res => Type_Delete_Res, :type_set_label_res => Type_SetLabel_Res, :type_is_abstract_res => Type_IsAbstract_Res, :type_get_supertype_res => Type_GetSupertype_Res, :type_set_supertype_res => Type_SetSupertype_Res, :thing_type_set_abstract_res => ThingType_SetAbstract_Res, :thing_type_unset_abstract_res => ThingType_UnsetAbstract_Res, :thing_type_set_owns_res => ThingType_SetOwns_Res, :thing_type_unset_owns_res => ThingType_UnsetOwns_Res, :thing_type_set_plays_res => ThingType_SetPlays_Res, :thing_type_unset_plays_res => ThingType_UnsetPlays_Res, :entity_type_create_res => EntityType_Create_Res, :relation_type_create_res => RelationType_Create_Res, :relation_type_get_relates_for_role_label_res => RelationType_GetRelatesForRoleLabel_Res, :relation_type_set_relates_res => RelationType_SetRelates_Res, :relation_type_unset_relates_res => RelationType_UnsetRelates_Res, :attribute_type_put_res => AttributeType_Put_Res, :attribute_type_get_res => AttributeType_Get_Res, :attribute_type_get_regex_res => AttributeType_GetRegex_Res, :attribute_type_set_regex_res => AttributeType_SetRegex_Res]
            oneofs = Int[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
            oneof_names = Symbol[Symbol("res")]
            meta(target, Type_Res, allflds, ProtoBuf.DEF_REQ, fnum, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Type_Res[]
    end
end
function Base.getproperty(obj::Type_Res, name::Symbol)
    if name === :type_delete_res
        return (obj.__protobuf_jl_internal_values[name])::Type_Delete_Res
    elseif name === :type_set_label_res
        return (obj.__protobuf_jl_internal_values[name])::Type_SetLabel_Res
    elseif name === :type_is_abstract_res
        return (obj.__protobuf_jl_internal_values[name])::Type_IsAbstract_Res
    elseif name === :type_get_supertype_res
        return (obj.__protobuf_jl_internal_values[name])::Type_GetSupertype_Res
    elseif name === :type_set_supertype_res
        return (obj.__protobuf_jl_internal_values[name])::Type_SetSupertype_Res
    elseif name === :thing_type_set_abstract_res
        return (obj.__protobuf_jl_internal_values[name])::ThingType_SetAbstract_Res
    elseif name === :thing_type_unset_abstract_res
        return (obj.__protobuf_jl_internal_values[name])::ThingType_UnsetAbstract_Res
    elseif name === :thing_type_set_owns_res
        return (obj.__protobuf_jl_internal_values[name])::ThingType_SetOwns_Res
    elseif name === :thing_type_unset_owns_res
        return (obj.__protobuf_jl_internal_values[name])::ThingType_UnsetOwns_Res
    elseif name === :thing_type_set_plays_res
        return (obj.__protobuf_jl_internal_values[name])::ThingType_SetPlays_Res
    elseif name === :thing_type_unset_plays_res
        return (obj.__protobuf_jl_internal_values[name])::ThingType_UnsetPlays_Res
    elseif name === :entity_type_create_res
        return (obj.__protobuf_jl_internal_values[name])::EntityType_Create_Res
    elseif name === :relation_type_create_res
        return (obj.__protobuf_jl_internal_values[name])::RelationType_Create_Res
    elseif name === :relation_type_get_relates_for_role_label_res
        return (obj.__protobuf_jl_internal_values[name])::RelationType_GetRelatesForRoleLabel_Res
    elseif name === :relation_type_set_relates_res
        return (obj.__protobuf_jl_internal_values[name])::RelationType_SetRelates_Res
    elseif name === :relation_type_unset_relates_res
        return (obj.__protobuf_jl_internal_values[name])::RelationType_UnsetRelates_Res
    elseif name === :attribute_type_put_res
        return (obj.__protobuf_jl_internal_values[name])::AttributeType_Put_Res
    elseif name === :attribute_type_get_res
        return (obj.__protobuf_jl_internal_values[name])::AttributeType_Get_Res
    elseif name === :attribute_type_get_regex_res
        return (obj.__protobuf_jl_internal_values[name])::AttributeType_GetRegex_Res
    elseif name === :attribute_type_set_regex_res
        return (obj.__protobuf_jl_internal_values[name])::AttributeType_SetRegex_Res
    else
        getfield(obj, name)
    end
end

mutable struct AttributeType_SetRegex <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_SetRegex(; kwargs...)
        obj = new(meta(AttributeType_SetRegex), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_SetRegex
const __meta_AttributeType_SetRegex = Ref{ProtoMeta}()
function meta(::Type{AttributeType_SetRegex})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_SetRegex)
            __meta_AttributeType_SetRegex[] = target = ProtoMeta(AttributeType_SetRegex)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, AttributeType_SetRegex, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_SetRegex[]
    end
end

mutable struct AttributeType_GetSubtypes_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_GetSubtypes_Req(; kwargs...)
        obj = new(meta(AttributeType_GetSubtypes_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_GetSubtypes_Req
const __meta_AttributeType_GetSubtypes_Req = Ref{ProtoMeta}()
function meta(::Type{AttributeType_GetSubtypes_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_GetSubtypes_Req)
            __meta_AttributeType_GetSubtypes_Req[] = target = ProtoMeta(AttributeType_GetSubtypes_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:value_type => Int32]
            oneofs = Int[1]
            oneof_names = Symbol[Symbol("req")]
            meta(target, AttributeType_GetSubtypes_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_AttributeType_GetSubtypes_Req[]
    end
end
function Base.getproperty(obj::AttributeType_GetSubtypes_Req, name::Symbol)
    if name === :value_type
        return (obj.__protobuf_jl_internal_values[name])::Int32
    else
        getfield(obj, name)
    end
end

mutable struct AttributeType_GetSubtypes_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_GetSubtypes_ResPart(; kwargs...)
        obj = new(meta(AttributeType_GetSubtypes_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_GetSubtypes_ResPart
const __meta_AttributeType_GetSubtypes_ResPart = Ref{ProtoMeta}()
function meta(::Type{AttributeType_GetSubtypes_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_GetSubtypes_ResPart)
            __meta_AttributeType_GetSubtypes_ResPart[] = target = ProtoMeta(AttributeType_GetSubtypes_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:types => Base.Vector{_Type}]
            meta(target, AttributeType_GetSubtypes_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_GetSubtypes_ResPart[]
    end
end
function Base.getproperty(obj::AttributeType_GetSubtypes_ResPart, name::Symbol)
    if name === :types
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{_Type}
    else
        getfield(obj, name)
    end
end

mutable struct AttributeType_GetSubtypes <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_GetSubtypes(; kwargs...)
        obj = new(meta(AttributeType_GetSubtypes), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_GetSubtypes
const __meta_AttributeType_GetSubtypes = Ref{ProtoMeta}()
function meta(::Type{AttributeType_GetSubtypes})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_GetSubtypes)
            __meta_AttributeType_GetSubtypes[] = target = ProtoMeta(AttributeType_GetSubtypes)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, AttributeType_GetSubtypes, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_GetSubtypes[]
    end
end

mutable struct AttributeType_GetInstances_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_GetInstances_Req(; kwargs...)
        obj = new(meta(AttributeType_GetInstances_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_GetInstances_Req
const __meta_AttributeType_GetInstances_Req = Ref{ProtoMeta}()
function meta(::Type{AttributeType_GetInstances_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_GetInstances_Req)
            __meta_AttributeType_GetInstances_Req[] = target = ProtoMeta(AttributeType_GetInstances_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:value_type => Int32]
            oneofs = Int[1]
            oneof_names = Symbol[Symbol("req")]
            meta(target, AttributeType_GetInstances_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_AttributeType_GetInstances_Req[]
    end
end
function Base.getproperty(obj::AttributeType_GetInstances_Req, name::Symbol)
    if name === :value_type
        return (obj.__protobuf_jl_internal_values[name])::Int32
    else
        getfield(obj, name)
    end
end

mutable struct AttributeType_GetInstances_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_GetInstances_ResPart(; kwargs...)
        obj = new(meta(AttributeType_GetInstances_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_GetInstances_ResPart
const __meta_AttributeType_GetInstances_ResPart = Ref{ProtoMeta}()
function meta(::Type{AttributeType_GetInstances_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_GetInstances_ResPart)
            __meta_AttributeType_GetInstances_ResPart[] = target = ProtoMeta(AttributeType_GetInstances_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:things => Base.Vector{Thing}]
            meta(target, AttributeType_GetInstances_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_GetInstances_ResPart[]
    end
end
function Base.getproperty(obj::AttributeType_GetInstances_ResPart, name::Symbol)
    if name === :things
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{Thing}
    else
        getfield(obj, name)
    end
end

mutable struct AttributeType_GetInstances <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType_GetInstances(; kwargs...)
        obj = new(meta(AttributeType_GetInstances), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType_GetInstances
const __meta_AttributeType_GetInstances = Ref{ProtoMeta}()
function meta(::Type{AttributeType_GetInstances})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType_GetInstances)
            __meta_AttributeType_GetInstances[] = target = ProtoMeta(AttributeType_GetInstances)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, AttributeType_GetInstances, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType_GetInstances[]
    end
end

mutable struct AttributeType <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function AttributeType(; kwargs...)
        obj = new(meta(AttributeType), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct AttributeType
const __meta_AttributeType = Ref{ProtoMeta}()
function meta(::Type{AttributeType})
    ProtoBuf.metalock() do
        if !isassigned(__meta_AttributeType)
            __meta_AttributeType[] = target = ProtoMeta(AttributeType)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, AttributeType, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_AttributeType[]
    end
end

export ConceptManager_Req, ConceptManager_Res, ConceptManager_GetThingType_Req, ConceptManager_GetThingType_Res, ConceptManager_GetThingType, ConceptManager_GetThing_Req, ConceptManager_GetThing_Res, ConceptManager_GetThing, ConceptManager_PutEntityType_Req, ConceptManager_PutEntityType_Res, ConceptManager_PutEntityType, ConceptManager_PutAttributeType_Req, ConceptManager_PutAttributeType_Res, ConceptManager_PutAttributeType, ConceptManager_PutRelationType_Req, ConceptManager_PutRelationType_Res, ConceptManager_PutRelationType, ConceptManager, Concept, Thing_Req, Thing_Res, Thing_ResPart, Thing_Delete_Req, Thing_Delete_Res, Thing_Delete, Thing_GetType_Req, Thing_GetType_Res, Thing_GetType, Thing_SetHas_Req, Thing_SetHas_Res, Thing_SetHas, Thing_UnsetHas_Req, Thing_UnsetHas_Res, Thing_UnsetHas, Thing_GetHas_Req, Thing_GetHas_ResPart, Thing_GetHas, Thing_GetPlaying_Req, Thing_GetPlaying_ResPart, Thing_GetPlaying, Thing_GetRelations_Req, Thing_GetRelations_ResPart, Thing_GetRelations, Thing, Relation_AddPlayer_Req, Relation_AddPlayer_Res, Relation_AddPlayer, Relation_RemovePlayer_Req, Relation_RemovePlayer_Res, Relation_RemovePlayer, Relation_GetPlayers_Req, Relation_GetPlayers_ResPart, Relation_GetPlayers, Relation_GetPlayersByRoleType_RoleTypeWithPlayer, Relation_GetPlayersByRoleType_Req, Relation_GetPlayersByRoleType_ResPart, Relation_GetPlayersByRoleType, Relation_GetRelating_Req, Relation_GetRelating_ResPart, Relation_GetRelating, Relation, Attribute_Value, Attribute_GetOwners_Req, Attribute_GetOwners_ResPart, Attribute_GetOwners, Attribute, Type_Encoding, Type_Req, Type_Res, Type_ResPart, Type_Delete_Req, Type_Delete_Res, Type_Delete, Type_SetLabel_Req, Type_SetLabel_Res, Type_SetLabel, Type_IsAbstract_Req, Type_IsAbstract_Res, Type_IsAbstract, Type_GetSupertype_Req, Type_GetSupertype_Res, Type_GetSupertype, Type_SetSupertype_Req, Type_SetSupertype_Res, Type_SetSupertype, Type_GetSupertypes_Req, Type_GetSupertypes_ResPart, Type_GetSupertypes, Type_GetSubtypes_Req, Type_GetSubtypes_ResPart, Type_GetSubtypes, _Type, RoleType_GetRelationTypes_Req, RoleType_GetRelationTypes_ResPart, RoleType_GetRelationTypes, RoleType_GetPlayers_Req, RoleType_GetPlayers_ResPart, RoleType_GetPlayers, RoleType, ThingType_SetAbstract_Req, ThingType_SetAbstract_Res, ThingType_SetAbstract, ThingType_UnsetAbstract_Req, ThingType_UnsetAbstract_Res, ThingType_UnsetAbstract, ThingType_GetInstances_Req, ThingType_GetInstances_ResPart, ThingType_GetInstances, ThingType_GetOwns_Req, ThingType_GetOwns_ResPart, ThingType_GetOwns, ThingType_GetPlays_Req, ThingType_GetPlays_ResPart, ThingType_GetPlays, ThingType_SetOwns_Req, ThingType_SetOwns_Res, ThingType_SetOwns, ThingType_SetPlays_Req, ThingType_SetPlays_Res, ThingType_SetPlays, ThingType_UnsetOwns_Req, ThingType_UnsetOwns_Res, ThingType_UnsetOwns, ThingType_UnsetPlays_Req, ThingType_UnsetPlays_Res, ThingType_UnsetPlays, ThingType, EntityType_Create_Req, EntityType_Create_Res, EntityType_Create, EntityType, RelationType_Create_Req, RelationType_Create_Res, RelationType_Create, RelationType_GetRelates_Req, RelationType_GetRelates_ResPart, RelationType_GetRelates, RelationType_GetRelatesForRoleLabel_Req, RelationType_GetRelatesForRoleLabel_Res, RelationType_GetRelatesForRoleLabel, RelationType_SetRelates_Req, RelationType_SetRelates_Res, RelationType_SetRelates, RelationType_UnsetRelates_Req, RelationType_UnsetRelates_Res, RelationType_UnsetRelates, RelationType, AttributeType_ValueType, AttributeType_Put_Req, AttributeType_Put_Res, AttributeType_Put, AttributeType_Get_Req, AttributeType_Get_Res, AttributeType_Get, AttributeType_GetOwners_Req, AttributeType_GetOwners_ResPart, AttributeType_GetOwners, AttributeType_GetRegex_Req, AttributeType_GetRegex_Res, AttributeType_GetRegex, AttributeType_SetRegex_Req, AttributeType_SetRegex_Res, AttributeType_SetRegex, AttributeType_GetSubtypes_Req, AttributeType_GetSubtypes_ResPart, AttributeType_GetSubtypes, AttributeType_GetInstances_Req, AttributeType_GetInstances_ResPart, AttributeType_GetInstances, AttributeType
