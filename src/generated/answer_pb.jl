# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct ConceptMap_MapEntry <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptMap_MapEntry(; kwargs...)
        obj = new(meta(ConceptMap_MapEntry), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptMap_MapEntry (mapentry)
const __meta_ConceptMap_MapEntry = Ref{ProtoMeta}()
function meta(::Type{ConceptMap_MapEntry})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptMap_MapEntry)
            __meta_ConceptMap_MapEntry[] = target = ProtoMeta(ConceptMap_MapEntry)
            allflds = Pair{Symbol,Union{Type,String}}[:key => AbstractString, :value => Concept]
            meta(target, ConceptMap_MapEntry, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptMap_MapEntry[]
    end
end
function Base.getproperty(obj::ConceptMap_MapEntry, name::Symbol)
    if name === :key
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :value
        return (obj.__protobuf_jl_internal_values[name])::Concept
    else
        getfield(obj, name)
    end
end

mutable struct ConceptMap <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptMap(; kwargs...)
        obj = new(meta(ConceptMap), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptMap
const __meta_ConceptMap = Ref{ProtoMeta}()
function meta(::Type{ConceptMap})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptMap)
            __meta_ConceptMap[] = target = ProtoMeta(ConceptMap)
            allflds = Pair{Symbol,Union{Type,String}}[:map => Base.Dict{AbstractString,Concept}, :pattern => AbstractString]
            meta(target, ConceptMap, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptMap[]
    end
end
function Base.getproperty(obj::ConceptMap, name::Symbol)
    if name === :map
        return (obj.__protobuf_jl_internal_values[name])::Base.Dict{AbstractString,Concept}
    elseif name === :pattern
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct ConceptMapGroup <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ConceptMapGroup(; kwargs...)
        obj = new(meta(ConceptMapGroup), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ConceptMapGroup
const __meta_ConceptMapGroup = Ref{ProtoMeta}()
function meta(::Type{ConceptMapGroup})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ConceptMapGroup)
            __meta_ConceptMapGroup[] = target = ProtoMeta(ConceptMapGroup)
            allflds = Pair{Symbol,Union{Type,String}}[:owner => Concept, :concept_maps => Base.Vector{ConceptMap}]
            meta(target, ConceptMapGroup, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptMapGroup[]
    end
end
function Base.getproperty(obj::ConceptMapGroup, name::Symbol)
    if name === :owner
        return (obj.__protobuf_jl_internal_values[name])::Concept
    elseif name === :concept_maps
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{ConceptMap}
    else
        getfield(obj, name)
    end
end

mutable struct Numeric <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Numeric(; kwargs...)
        obj = new(meta(Numeric), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Numeric
const __meta_Numeric = Ref{ProtoMeta}()
function meta(::Type{Numeric})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Numeric)
            __meta_Numeric[] = target = ProtoMeta(Numeric)
            allflds = Pair{Symbol,Union{Type,String}}[:long_value => Int64, :double_value => Float64, :nan => Bool]
            oneofs = Int[1,1,1]
            oneof_names = Symbol[Symbol("value")]
            meta(target, Numeric, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Numeric[]
    end
end
function Base.getproperty(obj::Numeric, name::Symbol)
    if name === :long_value
        return (obj.__protobuf_jl_internal_values[name])::Int64
    elseif name === :double_value
        return (obj.__protobuf_jl_internal_values[name])::Float64
    elseif name === :nan
        return (obj.__protobuf_jl_internal_values[name])::Bool
    else
        getfield(obj, name)
    end
end

mutable struct NumericGroup <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function NumericGroup(; kwargs...)
        obj = new(meta(NumericGroup), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct NumericGroup
const __meta_NumericGroup = Ref{ProtoMeta}()
function meta(::Type{NumericGroup})
    ProtoBuf.metalock() do
        if !isassigned(__meta_NumericGroup)
            __meta_NumericGroup[] = target = ProtoMeta(NumericGroup)
            allflds = Pair{Symbol,Union{Type,String}}[:owner => Concept, :number => Numeric]
            meta(target, NumericGroup, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_NumericGroup[]
    end
end
function Base.getproperty(obj::NumericGroup, name::Symbol)
    if name === :owner
        return (obj.__protobuf_jl_internal_values[name])::Concept
    elseif name === :number
        return (obj.__protobuf_jl_internal_values[name])::Numeric
    else
        getfield(obj, name)
    end
end

export ConceptMap_MapEntry, ConceptMap, ConceptMapGroup, Numeric, NumericGroup
# mapentries: "ConceptMap_MapEntry" => ("AbstractString", "Concept")
