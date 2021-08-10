# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct Explainable <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Explainable(; kwargs...)
        obj = new(meta(Explainable), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Explainable
const __meta_Explainable = Ref{ProtoMeta}()
function meta(::Type{Explainable})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Explainable)
            __meta_Explainable[] = target = ProtoMeta(Explainable)
            allflds = Pair{Symbol,Union{Type,String}}[:conjunction => AbstractString, :id => Int64]
            meta(target, Explainable, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Explainable[]
    end
end
function Base.getproperty(obj::Explainable, name::Symbol)
    if name === :conjunction
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :id
        return (obj.__protobuf_jl_internal_values[name])::Int64
    else
        getfield(obj, name)
    end
end

mutable struct Explainables_Owned_OwnedEntry <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Explainables_Owned_OwnedEntry(; kwargs...)
        obj = new(meta(Explainables_Owned_OwnedEntry), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Explainables_Owned_OwnedEntry (mapentry)
const __meta_Explainables_Owned_OwnedEntry = Ref{ProtoMeta}()
function meta(::Type{Explainables_Owned_OwnedEntry})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Explainables_Owned_OwnedEntry)
            __meta_Explainables_Owned_OwnedEntry[] = target = ProtoMeta(Explainables_Owned_OwnedEntry)
            allflds = Pair{Symbol,Union{Type,String}}[:key => AbstractString, :value => Explainable]
            meta(target, Explainables_Owned_OwnedEntry, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Explainables_Owned_OwnedEntry[]
    end
end
function Base.getproperty(obj::Explainables_Owned_OwnedEntry, name::Symbol)
    if name === :key
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :value
        return (obj.__protobuf_jl_internal_values[name])::Explainable
    else
        getfield(obj, name)
    end
end

mutable struct Explainables_RelationsEntry <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Explainables_RelationsEntry(; kwargs...)
        obj = new(meta(Explainables_RelationsEntry), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Explainables_RelationsEntry (mapentry)
const __meta_Explainables_RelationsEntry = Ref{ProtoMeta}()
function meta(::Type{Explainables_RelationsEntry})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Explainables_RelationsEntry)
            __meta_Explainables_RelationsEntry[] = target = ProtoMeta(Explainables_RelationsEntry)
            allflds = Pair{Symbol,Union{Type,String}}[:key => AbstractString, :value => Explainable]
            meta(target, Explainables_RelationsEntry, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Explainables_RelationsEntry[]
    end
end
function Base.getproperty(obj::Explainables_RelationsEntry, name::Symbol)
    if name === :key
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :value
        return (obj.__protobuf_jl_internal_values[name])::Explainable
    else
        getfield(obj, name)
    end
end

mutable struct Explainables_AttributesEntry <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Explainables_AttributesEntry(; kwargs...)
        obj = new(meta(Explainables_AttributesEntry), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Explainables_AttributesEntry (mapentry)
const __meta_Explainables_AttributesEntry = Ref{ProtoMeta}()
function meta(::Type{Explainables_AttributesEntry})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Explainables_AttributesEntry)
            __meta_Explainables_AttributesEntry[] = target = ProtoMeta(Explainables_AttributesEntry)
            allflds = Pair{Symbol,Union{Type,String}}[:key => AbstractString, :value => Explainable]
            meta(target, Explainables_AttributesEntry, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Explainables_AttributesEntry[]
    end
end
function Base.getproperty(obj::Explainables_AttributesEntry, name::Symbol)
    if name === :key
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :value
        return (obj.__protobuf_jl_internal_values[name])::Explainable
    else
        getfield(obj, name)
    end
end

mutable struct Explainables_Owned <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Explainables_Owned(; kwargs...)
        obj = new(meta(Explainables_Owned), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Explainables_Owned
const __meta_Explainables_Owned = Ref{ProtoMeta}()
function meta(::Type{Explainables_Owned})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Explainables_Owned)
            __meta_Explainables_Owned[] = target = ProtoMeta(Explainables_Owned)
            allflds = Pair{Symbol,Union{Type,String}}[:owned => Base.Dict{AbstractString,Explainable}]
            meta(target, Explainables_Owned, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Explainables_Owned[]
    end
end
function Base.getproperty(obj::Explainables_Owned, name::Symbol)
    if name === :owned
        return (obj.__protobuf_jl_internal_values[name])::Base.Dict{AbstractString,Explainable}
    else
        getfield(obj, name)
    end
end

mutable struct Explainables_OwnershipsEntry <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Explainables_OwnershipsEntry(; kwargs...)
        obj = new(meta(Explainables_OwnershipsEntry), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Explainables_OwnershipsEntry (mapentry)
const __meta_Explainables_OwnershipsEntry = Ref{ProtoMeta}()
function meta(::Type{Explainables_OwnershipsEntry})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Explainables_OwnershipsEntry)
            __meta_Explainables_OwnershipsEntry[] = target = ProtoMeta(Explainables_OwnershipsEntry)
            allflds = Pair{Symbol,Union{Type,String}}[:key => AbstractString, :value => Explainables_Owned]
            meta(target, Explainables_OwnershipsEntry, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Explainables_OwnershipsEntry[]
    end
end
function Base.getproperty(obj::Explainables_OwnershipsEntry, name::Symbol)
    if name === :key
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :value
        return (obj.__protobuf_jl_internal_values[name])::Explainables_Owned
    else
        getfield(obj, name)
    end
end

mutable struct Explainables <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Explainables(; kwargs...)
        obj = new(meta(Explainables), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Explainables
const __meta_Explainables = Ref{ProtoMeta}()
function meta(::Type{Explainables})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Explainables)
            __meta_Explainables[] = target = ProtoMeta(Explainables)
            allflds = Pair{Symbol,Union{Type,String}}[:relations => Base.Dict{AbstractString,Explainable}, :attributes => Base.Dict{AbstractString,Explainable}, :ownerships => Base.Dict{AbstractString,Explainables_Owned}]
            meta(target, Explainables, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Explainables[]
    end
end
function Base.getproperty(obj::Explainables, name::Symbol)
    if name === :relations
        return (obj.__protobuf_jl_internal_values[name])::Base.Dict{AbstractString,Explainable}
    elseif name === :attributes
        return (obj.__protobuf_jl_internal_values[name])::Base.Dict{AbstractString,Explainable}
    elseif name === :ownerships
        return (obj.__protobuf_jl_internal_values[name])::Base.Dict{AbstractString,Explainables_Owned}
    else
        getfield(obj, name)
    end
end

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
            allflds = Pair{Symbol,Union{Type,String}}[:map => Base.Dict{AbstractString,Concept}, :explainables => Explainables]
            meta(target, ConceptMap, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ConceptMap[]
    end
end
function Base.getproperty(obj::ConceptMap, name::Symbol)
    if name === :map
        return (obj.__protobuf_jl_internal_values[name])::Base.Dict{AbstractString,Concept}
    elseif name === :explainables
        return (obj.__protobuf_jl_internal_values[name])::Explainables
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

export ConceptMap_MapEntry, ConceptMap, Explainables_RelationsEntry, Explainables_AttributesEntry, Explainables_OwnershipsEntry, Explainables_Owned_OwnedEntry, Explainables_Owned, Explainables, Explainable, ConceptMapGroup, Numeric, NumericGroup
# mapentries: "Explainables_Owned_OwnedEntry" => ("AbstractString", "Explainable"), "Explainables_RelationsEntry" => ("AbstractString", "Explainable"), "Explainables_OwnershipsEntry" => ("AbstractString", "Explainables_Owned"), "Explainables_AttributesEntry" => ("AbstractString", "Explainable"), "ConceptMap_MapEntry" => ("AbstractString", "Concept")
