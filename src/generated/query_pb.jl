# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct QueryManager_Match_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Match_Req(; kwargs...)
        obj = new(meta(QueryManager_Match_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Match_Req
const __meta_QueryManager_Match_Req = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Match_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Match_Req)
            __meta_QueryManager_Match_Req[] = target = ProtoMeta(QueryManager_Match_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:query => AbstractString]
            meta(target, QueryManager_Match_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Match_Req[]
    end
end
function Base.getproperty(obj::QueryManager_Match_Req, name::Symbol)
    if name === :query
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_Match_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Match_ResPart(; kwargs...)
        obj = new(meta(QueryManager_Match_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Match_ResPart
const __meta_QueryManager_Match_ResPart = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Match_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Match_ResPart)
            __meta_QueryManager_Match_ResPart[] = target = ProtoMeta(QueryManager_Match_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:answers => Base.Vector{ConceptMap}]
            meta(target, QueryManager_Match_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Match_ResPart[]
    end
end
function Base.getproperty(obj::QueryManager_Match_ResPart, name::Symbol)
    if name === :answers
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{ConceptMap}
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_Match <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Match(; kwargs...)
        obj = new(meta(QueryManager_Match), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Match
const __meta_QueryManager_Match = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Match})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Match)
            __meta_QueryManager_Match[] = target = ProtoMeta(QueryManager_Match)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, QueryManager_Match, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Match[]
    end
end

mutable struct QueryManager_MatchAggregate_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_MatchAggregate_Req(; kwargs...)
        obj = new(meta(QueryManager_MatchAggregate_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_MatchAggregate_Req
const __meta_QueryManager_MatchAggregate_Req = Ref{ProtoMeta}()
function meta(::Type{QueryManager_MatchAggregate_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_MatchAggregate_Req)
            __meta_QueryManager_MatchAggregate_Req[] = target = ProtoMeta(QueryManager_MatchAggregate_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:query => AbstractString]
            meta(target, QueryManager_MatchAggregate_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_MatchAggregate_Req[]
    end
end
function Base.getproperty(obj::QueryManager_MatchAggregate_Req, name::Symbol)
    if name === :query
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_MatchAggregate_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_MatchAggregate_Res(; kwargs...)
        obj = new(meta(QueryManager_MatchAggregate_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_MatchAggregate_Res
const __meta_QueryManager_MatchAggregate_Res = Ref{ProtoMeta}()
function meta(::Type{QueryManager_MatchAggregate_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_MatchAggregate_Res)
            __meta_QueryManager_MatchAggregate_Res[] = target = ProtoMeta(QueryManager_MatchAggregate_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:answer => Numeric]
            meta(target, QueryManager_MatchAggregate_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_MatchAggregate_Res[]
    end
end
function Base.getproperty(obj::QueryManager_MatchAggregate_Res, name::Symbol)
    if name === :answer
        return (obj.__protobuf_jl_internal_values[name])::Numeric
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_MatchAggregate <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_MatchAggregate(; kwargs...)
        obj = new(meta(QueryManager_MatchAggregate), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_MatchAggregate
const __meta_QueryManager_MatchAggregate = Ref{ProtoMeta}()
function meta(::Type{QueryManager_MatchAggregate})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_MatchAggregate)
            __meta_QueryManager_MatchAggregate[] = target = ProtoMeta(QueryManager_MatchAggregate)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, QueryManager_MatchAggregate, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_MatchAggregate[]
    end
end

mutable struct QueryManager_MatchGroup_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_MatchGroup_Req(; kwargs...)
        obj = new(meta(QueryManager_MatchGroup_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_MatchGroup_Req
const __meta_QueryManager_MatchGroup_Req = Ref{ProtoMeta}()
function meta(::Type{QueryManager_MatchGroup_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_MatchGroup_Req)
            __meta_QueryManager_MatchGroup_Req[] = target = ProtoMeta(QueryManager_MatchGroup_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:query => AbstractString]
            meta(target, QueryManager_MatchGroup_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_MatchGroup_Req[]
    end
end
function Base.getproperty(obj::QueryManager_MatchGroup_Req, name::Symbol)
    if name === :query
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_MatchGroup_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_MatchGroup_ResPart(; kwargs...)
        obj = new(meta(QueryManager_MatchGroup_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_MatchGroup_ResPart
const __meta_QueryManager_MatchGroup_ResPart = Ref{ProtoMeta}()
function meta(::Type{QueryManager_MatchGroup_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_MatchGroup_ResPart)
            __meta_QueryManager_MatchGroup_ResPart[] = target = ProtoMeta(QueryManager_MatchGroup_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:answers => Base.Vector{ConceptMapGroup}]
            meta(target, QueryManager_MatchGroup_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_MatchGroup_ResPart[]
    end
end
function Base.getproperty(obj::QueryManager_MatchGroup_ResPart, name::Symbol)
    if name === :answers
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{ConceptMapGroup}
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_MatchGroup <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_MatchGroup(; kwargs...)
        obj = new(meta(QueryManager_MatchGroup), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_MatchGroup
const __meta_QueryManager_MatchGroup = Ref{ProtoMeta}()
function meta(::Type{QueryManager_MatchGroup})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_MatchGroup)
            __meta_QueryManager_MatchGroup[] = target = ProtoMeta(QueryManager_MatchGroup)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, QueryManager_MatchGroup, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_MatchGroup[]
    end
end

mutable struct QueryManager_MatchGroupAggregate_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_MatchGroupAggregate_Req(; kwargs...)
        obj = new(meta(QueryManager_MatchGroupAggregate_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_MatchGroupAggregate_Req
const __meta_QueryManager_MatchGroupAggregate_Req = Ref{ProtoMeta}()
function meta(::Type{QueryManager_MatchGroupAggregate_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_MatchGroupAggregate_Req)
            __meta_QueryManager_MatchGroupAggregate_Req[] = target = ProtoMeta(QueryManager_MatchGroupAggregate_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:query => AbstractString]
            meta(target, QueryManager_MatchGroupAggregate_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_MatchGroupAggregate_Req[]
    end
end
function Base.getproperty(obj::QueryManager_MatchGroupAggregate_Req, name::Symbol)
    if name === :query
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_MatchGroupAggregate_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_MatchGroupAggregate_ResPart(; kwargs...)
        obj = new(meta(QueryManager_MatchGroupAggregate_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_MatchGroupAggregate_ResPart
const __meta_QueryManager_MatchGroupAggregate_ResPart = Ref{ProtoMeta}()
function meta(::Type{QueryManager_MatchGroupAggregate_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_MatchGroupAggregate_ResPart)
            __meta_QueryManager_MatchGroupAggregate_ResPart[] = target = ProtoMeta(QueryManager_MatchGroupAggregate_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:answers => Base.Vector{NumericGroup}]
            meta(target, QueryManager_MatchGroupAggregate_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_MatchGroupAggregate_ResPart[]
    end
end
function Base.getproperty(obj::QueryManager_MatchGroupAggregate_ResPart, name::Symbol)
    if name === :answers
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{NumericGroup}
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_MatchGroupAggregate <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_MatchGroupAggregate(; kwargs...)
        obj = new(meta(QueryManager_MatchGroupAggregate), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_MatchGroupAggregate
const __meta_QueryManager_MatchGroupAggregate = Ref{ProtoMeta}()
function meta(::Type{QueryManager_MatchGroupAggregate})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_MatchGroupAggregate)
            __meta_QueryManager_MatchGroupAggregate[] = target = ProtoMeta(QueryManager_MatchGroupAggregate)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, QueryManager_MatchGroupAggregate, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_MatchGroupAggregate[]
    end
end

mutable struct QueryManager_Explain_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Explain_Req(; kwargs...)
        obj = new(meta(QueryManager_Explain_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Explain_Req
const __meta_QueryManager_Explain_Req = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Explain_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Explain_Req)
            __meta_QueryManager_Explain_Req[] = target = ProtoMeta(QueryManager_Explain_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:explainable_id => Int64]
            meta(target, QueryManager_Explain_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Explain_Req[]
    end
end
function Base.getproperty(obj::QueryManager_Explain_Req, name::Symbol)
    if name === :explainable_id
        return (obj.__protobuf_jl_internal_values[name])::Int64
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_Explain_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Explain_ResPart(; kwargs...)
        obj = new(meta(QueryManager_Explain_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Explain_ResPart
const __meta_QueryManager_Explain_ResPart = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Explain_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Explain_ResPart)
            __meta_QueryManager_Explain_ResPart[] = target = ProtoMeta(QueryManager_Explain_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:explanations => Base.Vector{Explanation}]
            meta(target, QueryManager_Explain_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Explain_ResPart[]
    end
end
function Base.getproperty(obj::QueryManager_Explain_ResPart, name::Symbol)
    if name === :explanations
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{Explanation}
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_Explain <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Explain(; kwargs...)
        obj = new(meta(QueryManager_Explain), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Explain
const __meta_QueryManager_Explain = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Explain})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Explain)
            __meta_QueryManager_Explain[] = target = ProtoMeta(QueryManager_Explain)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, QueryManager_Explain, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Explain[]
    end
end

mutable struct QueryManager_Insert_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Insert_Req(; kwargs...)
        obj = new(meta(QueryManager_Insert_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Insert_Req
const __meta_QueryManager_Insert_Req = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Insert_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Insert_Req)
            __meta_QueryManager_Insert_Req[] = target = ProtoMeta(QueryManager_Insert_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:query => AbstractString]
            meta(target, QueryManager_Insert_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Insert_Req[]
    end
end
function Base.getproperty(obj::QueryManager_Insert_Req, name::Symbol)
    if name === :query
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_Insert_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Insert_ResPart(; kwargs...)
        obj = new(meta(QueryManager_Insert_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Insert_ResPart
const __meta_QueryManager_Insert_ResPart = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Insert_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Insert_ResPart)
            __meta_QueryManager_Insert_ResPart[] = target = ProtoMeta(QueryManager_Insert_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:answers => Base.Vector{ConceptMap}]
            meta(target, QueryManager_Insert_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Insert_ResPart[]
    end
end
function Base.getproperty(obj::QueryManager_Insert_ResPart, name::Symbol)
    if name === :answers
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{ConceptMap}
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_Insert <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Insert(; kwargs...)
        obj = new(meta(QueryManager_Insert), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Insert
const __meta_QueryManager_Insert = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Insert})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Insert)
            __meta_QueryManager_Insert[] = target = ProtoMeta(QueryManager_Insert)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, QueryManager_Insert, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Insert[]
    end
end

mutable struct QueryManager_Delete_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Delete_Req(; kwargs...)
        obj = new(meta(QueryManager_Delete_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Delete_Req
const __meta_QueryManager_Delete_Req = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Delete_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Delete_Req)
            __meta_QueryManager_Delete_Req[] = target = ProtoMeta(QueryManager_Delete_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:query => AbstractString]
            meta(target, QueryManager_Delete_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Delete_Req[]
    end
end
function Base.getproperty(obj::QueryManager_Delete_Req, name::Symbol)
    if name === :query
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_Delete_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Delete_Res(; kwargs...)
        obj = new(meta(QueryManager_Delete_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Delete_Res
const __meta_QueryManager_Delete_Res = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Delete_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Delete_Res)
            __meta_QueryManager_Delete_Res[] = target = ProtoMeta(QueryManager_Delete_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, QueryManager_Delete_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Delete_Res[]
    end
end

mutable struct QueryManager_Delete <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Delete(; kwargs...)
        obj = new(meta(QueryManager_Delete), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Delete
const __meta_QueryManager_Delete = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Delete})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Delete)
            __meta_QueryManager_Delete[] = target = ProtoMeta(QueryManager_Delete)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, QueryManager_Delete, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Delete[]
    end
end

mutable struct QueryManager_Update_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Update_Req(; kwargs...)
        obj = new(meta(QueryManager_Update_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Update_Req
const __meta_QueryManager_Update_Req = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Update_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Update_Req)
            __meta_QueryManager_Update_Req[] = target = ProtoMeta(QueryManager_Update_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:query => AbstractString]
            meta(target, QueryManager_Update_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Update_Req[]
    end
end
function Base.getproperty(obj::QueryManager_Update_Req, name::Symbol)
    if name === :query
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_Update_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Update_ResPart(; kwargs...)
        obj = new(meta(QueryManager_Update_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Update_ResPart
const __meta_QueryManager_Update_ResPart = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Update_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Update_ResPart)
            __meta_QueryManager_Update_ResPart[] = target = ProtoMeta(QueryManager_Update_ResPart)
            allflds = Pair{Symbol,Union{Type,String}}[:answers => Base.Vector{ConceptMap}]
            meta(target, QueryManager_Update_ResPart, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Update_ResPart[]
    end
end
function Base.getproperty(obj::QueryManager_Update_ResPart, name::Symbol)
    if name === :answers
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{ConceptMap}
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_ResPart <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_ResPart(; kwargs...)
        obj = new(meta(QueryManager_ResPart), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_ResPart
const __meta_QueryManager_ResPart = Ref{ProtoMeta}()
function meta(::Type{QueryManager_ResPart})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_ResPart)
            __meta_QueryManager_ResPart[] = target = ProtoMeta(QueryManager_ResPart)
            fnum = Int[100,101,102,103,104,105]
            allflds = Pair{Symbol,Union{Type,String}}[:match_res_part => QueryManager_Match_ResPart, :match_group_res_part => QueryManager_MatchGroup_ResPart, :match_group_aggregate_res_part => QueryManager_MatchGroupAggregate_ResPart, :insert_res_part => QueryManager_Insert_ResPart, :update_res_part => QueryManager_Update_ResPart, :explain_res_part => QueryManager_Explain_ResPart]
            oneofs = Int[1,1,1,1,1,1]
            oneof_names = Symbol[Symbol("res")]
            meta(target, QueryManager_ResPart, allflds, ProtoBuf.DEF_REQ, fnum, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_QueryManager_ResPart[]
    end
end
function Base.getproperty(obj::QueryManager_ResPart, name::Symbol)
    if name === :match_res_part
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_Match_ResPart
    elseif name === :match_group_res_part
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_MatchGroup_ResPart
    elseif name === :match_group_aggregate_res_part
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_MatchGroupAggregate_ResPart
    elseif name === :insert_res_part
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_Insert_ResPart
    elseif name === :update_res_part
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_Update_ResPart
    elseif name === :explain_res_part
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_Explain_ResPart
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_Update <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Update(; kwargs...)
        obj = new(meta(QueryManager_Update), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Update
const __meta_QueryManager_Update = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Update})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Update)
            __meta_QueryManager_Update[] = target = ProtoMeta(QueryManager_Update)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, QueryManager_Update, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Update[]
    end
end

mutable struct QueryManager_Define_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Define_Req(; kwargs...)
        obj = new(meta(QueryManager_Define_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Define_Req
const __meta_QueryManager_Define_Req = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Define_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Define_Req)
            __meta_QueryManager_Define_Req[] = target = ProtoMeta(QueryManager_Define_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:query => AbstractString]
            meta(target, QueryManager_Define_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Define_Req[]
    end
end
function Base.getproperty(obj::QueryManager_Define_Req, name::Symbol)
    if name === :query
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_Define_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Define_Res(; kwargs...)
        obj = new(meta(QueryManager_Define_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Define_Res
const __meta_QueryManager_Define_Res = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Define_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Define_Res)
            __meta_QueryManager_Define_Res[] = target = ProtoMeta(QueryManager_Define_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, QueryManager_Define_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Define_Res[]
    end
end

mutable struct QueryManager_Define <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Define(; kwargs...)
        obj = new(meta(QueryManager_Define), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Define
const __meta_QueryManager_Define = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Define})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Define)
            __meta_QueryManager_Define[] = target = ProtoMeta(QueryManager_Define)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, QueryManager_Define, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Define[]
    end
end

mutable struct QueryManager_Undefine_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Undefine_Req(; kwargs...)
        obj = new(meta(QueryManager_Undefine_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Undefine_Req
const __meta_QueryManager_Undefine_Req = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Undefine_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Undefine_Req)
            __meta_QueryManager_Undefine_Req[] = target = ProtoMeta(QueryManager_Undefine_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:query => AbstractString]
            meta(target, QueryManager_Undefine_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Undefine_Req[]
    end
end
function Base.getproperty(obj::QueryManager_Undefine_Req, name::Symbol)
    if name === :query
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Req(; kwargs...)
        obj = new(meta(QueryManager_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Req
const __meta_QueryManager_Req = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Req)
            __meta_QueryManager_Req[] = target = ProtoMeta(QueryManager_Req)
            fnum = Int[1,100,101,102,103,104,105,106,107,108,109]
            allflds = Pair{Symbol,Union{Type,String}}[:options => Options, :define_req => QueryManager_Define_Req, :undefine_req => QueryManager_Undefine_Req, :match_req => QueryManager_Match_Req, :match_aggregate_req => QueryManager_MatchAggregate_Req, :match_group_req => QueryManager_MatchGroup_Req, :match_group_aggregate_req => QueryManager_MatchGroupAggregate_Req, :insert_req => QueryManager_Insert_Req, :delete_req => QueryManager_Delete_Req, :update_req => QueryManager_Update_Req, :explain_req => QueryManager_Explain_Req]
            oneofs = Int[0,1,1,1,1,1,1,1,1,1,1]
            oneof_names = Symbol[Symbol("req")]
            meta(target, QueryManager_Req, allflds, ProtoBuf.DEF_REQ, fnum, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_QueryManager_Req[]
    end
end
function Base.getproperty(obj::QueryManager_Req, name::Symbol)
    if name === :options
        return (obj.__protobuf_jl_internal_values[name])::Options
    elseif name === :define_req
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_Define_Req
    elseif name === :undefine_req
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_Undefine_Req
    elseif name === :match_req
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_Match_Req
    elseif name === :match_aggregate_req
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_MatchAggregate_Req
    elseif name === :match_group_req
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_MatchGroup_Req
    elseif name === :match_group_aggregate_req
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_MatchGroupAggregate_Req
    elseif name === :insert_req
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_Insert_Req
    elseif name === :delete_req
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_Delete_Req
    elseif name === :update_req
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_Update_Req
    elseif name === :explain_req
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_Explain_Req
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_Undefine_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Undefine_Res(; kwargs...)
        obj = new(meta(QueryManager_Undefine_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Undefine_Res
const __meta_QueryManager_Undefine_Res = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Undefine_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Undefine_Res)
            __meta_QueryManager_Undefine_Res[] = target = ProtoMeta(QueryManager_Undefine_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, QueryManager_Undefine_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Undefine_Res[]
    end
end

mutable struct QueryManager_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Res(; kwargs...)
        obj = new(meta(QueryManager_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Res
const __meta_QueryManager_Res = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Res)
            __meta_QueryManager_Res[] = target = ProtoMeta(QueryManager_Res)
            fnum = Int[100,101,102,104]
            allflds = Pair{Symbol,Union{Type,String}}[:define_res => QueryManager_Define_Res, :undefine_res => QueryManager_Undefine_Res, :match_aggregate_res => QueryManager_MatchAggregate_Res, :delete_res => QueryManager_Delete_Res]
            oneofs = Int[1,1,1,1]
            oneof_names = Symbol[Symbol("res")]
            meta(target, QueryManager_Res, allflds, ProtoBuf.DEF_REQ, fnum, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_QueryManager_Res[]
    end
end
function Base.getproperty(obj::QueryManager_Res, name::Symbol)
    if name === :define_res
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_Define_Res
    elseif name === :undefine_res
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_Undefine_Res
    elseif name === :match_aggregate_res
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_MatchAggregate_Res
    elseif name === :delete_res
        return (obj.__protobuf_jl_internal_values[name])::QueryManager_Delete_Res
    else
        getfield(obj, name)
    end
end

mutable struct QueryManager_Undefine <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager_Undefine(; kwargs...)
        obj = new(meta(QueryManager_Undefine), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager_Undefine
const __meta_QueryManager_Undefine = Ref{ProtoMeta}()
function meta(::Type{QueryManager_Undefine})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager_Undefine)
            __meta_QueryManager_Undefine[] = target = ProtoMeta(QueryManager_Undefine)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, QueryManager_Undefine, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager_Undefine[]
    end
end

mutable struct QueryManager <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function QueryManager(; kwargs...)
        obj = new(meta(QueryManager), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct QueryManager
const __meta_QueryManager = Ref{ProtoMeta}()
function meta(::Type{QueryManager})
    ProtoBuf.metalock() do
        if !isassigned(__meta_QueryManager)
            __meta_QueryManager[] = target = ProtoMeta(QueryManager)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, QueryManager, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_QueryManager[]
    end
end

export QueryManager_Req, QueryManager_Res, QueryManager_ResPart, QueryManager_Match_Req, QueryManager_Match_ResPart, QueryManager_Match, QueryManager_MatchAggregate_Req, QueryManager_MatchAggregate_Res, QueryManager_MatchAggregate, QueryManager_MatchGroup_Req, QueryManager_MatchGroup_ResPart, QueryManager_MatchGroup, QueryManager_MatchGroupAggregate_Req, QueryManager_MatchGroupAggregate_ResPart, QueryManager_MatchGroupAggregate, QueryManager_Explain_Req, QueryManager_Explain_ResPart, QueryManager_Explain, QueryManager_Insert_Req, QueryManager_Insert_ResPart, QueryManager_Insert, QueryManager_Delete_Req, QueryManager_Delete_Res, QueryManager_Delete, QueryManager_Update_Req, QueryManager_Update_ResPart, QueryManager_Update, QueryManager_Define_Req, QueryManager_Define_Res, QueryManager_Define, QueryManager_Undefine_Req, QueryManager_Undefine_Res, QueryManager_Undefine, QueryManager
