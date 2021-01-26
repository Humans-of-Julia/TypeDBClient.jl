# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct Query_Match_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_Match_Req(; kwargs...)
        obj = new(meta(Query_Match_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_Match_Req
const __meta_Query_Match_Req = Ref{ProtoMeta}()
function meta(::Type{Query_Match_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_Match_Req)
            __meta_Query_Match_Req[] = target = ProtoMeta(Query_Match_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:query => AbstractString]
            meta(target, Query_Match_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_Match_Req[]
    end
end
function Base.getproperty(obj::Query_Match_Req, name::Symbol)
    if name === :query
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct Query_Match_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_Match_Res(; kwargs...)
        obj = new(meta(Query_Match_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_Match_Res
const __meta_Query_Match_Res = Ref{ProtoMeta}()
function meta(::Type{Query_Match_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_Match_Res)
            __meta_Query_Match_Res[] = target = ProtoMeta(Query_Match_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:answers => Base.Vector{ConceptMap}]
            meta(target, Query_Match_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_Match_Res[]
    end
end
function Base.getproperty(obj::Query_Match_Res, name::Symbol)
    if name === :answers
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{ConceptMap}
    else
        getfield(obj, name)
    end
end

mutable struct Query_Match <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_Match(; kwargs...)
        obj = new(meta(Query_Match), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_Match
const __meta_Query_Match = Ref{ProtoMeta}()
function meta(::Type{Query_Match})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_Match)
            __meta_Query_Match[] = target = ProtoMeta(Query_Match)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Query_Match, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_Match[]
    end
end

mutable struct Query_MatchAggregate_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_MatchAggregate_Req(; kwargs...)
        obj = new(meta(Query_MatchAggregate_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_MatchAggregate_Req
const __meta_Query_MatchAggregate_Req = Ref{ProtoMeta}()
function meta(::Type{Query_MatchAggregate_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_MatchAggregate_Req)
            __meta_Query_MatchAggregate_Req[] = target = ProtoMeta(Query_MatchAggregate_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:query => AbstractString]
            meta(target, Query_MatchAggregate_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_MatchAggregate_Req[]
    end
end
function Base.getproperty(obj::Query_MatchAggregate_Req, name::Symbol)
    if name === :query
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct Query_MatchAggregate_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_MatchAggregate_Res(; kwargs...)
        obj = new(meta(Query_MatchAggregate_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_MatchAggregate_Res
const __meta_Query_MatchAggregate_Res = Ref{ProtoMeta}()
function meta(::Type{Query_MatchAggregate_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_MatchAggregate_Res)
            __meta_Query_MatchAggregate_Res[] = target = ProtoMeta(Query_MatchAggregate_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:answer => Numeric]
            meta(target, Query_MatchAggregate_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_MatchAggregate_Res[]
    end
end
function Base.getproperty(obj::Query_MatchAggregate_Res, name::Symbol)
    if name === :answer
        return (obj.__protobuf_jl_internal_values[name])::Numeric
    else
        getfield(obj, name)
    end
end

mutable struct Query_MatchAggregate <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_MatchAggregate(; kwargs...)
        obj = new(meta(Query_MatchAggregate), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_MatchAggregate
const __meta_Query_MatchAggregate = Ref{ProtoMeta}()
function meta(::Type{Query_MatchAggregate})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_MatchAggregate)
            __meta_Query_MatchAggregate[] = target = ProtoMeta(Query_MatchAggregate)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Query_MatchAggregate, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_MatchAggregate[]
    end
end

mutable struct Query_MatchGroup_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_MatchGroup_Req(; kwargs...)
        obj = new(meta(Query_MatchGroup_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_MatchGroup_Req
const __meta_Query_MatchGroup_Req = Ref{ProtoMeta}()
function meta(::Type{Query_MatchGroup_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_MatchGroup_Req)
            __meta_Query_MatchGroup_Req[] = target = ProtoMeta(Query_MatchGroup_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:query => AbstractString]
            meta(target, Query_MatchGroup_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_MatchGroup_Req[]
    end
end
function Base.getproperty(obj::Query_MatchGroup_Req, name::Symbol)
    if name === :query
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct Query_MatchGroup_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_MatchGroup_Res(; kwargs...)
        obj = new(meta(Query_MatchGroup_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_MatchGroup_Res
const __meta_Query_MatchGroup_Res = Ref{ProtoMeta}()
function meta(::Type{Query_MatchGroup_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_MatchGroup_Res)
            __meta_Query_MatchGroup_Res[] = target = ProtoMeta(Query_MatchGroup_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:answers => Base.Vector{ConceptMapGroup}]
            meta(target, Query_MatchGroup_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_MatchGroup_Res[]
    end
end
function Base.getproperty(obj::Query_MatchGroup_Res, name::Symbol)
    if name === :answers
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{ConceptMapGroup}
    else
        getfield(obj, name)
    end
end

mutable struct Query_MatchGroup <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_MatchGroup(; kwargs...)
        obj = new(meta(Query_MatchGroup), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_MatchGroup
const __meta_Query_MatchGroup = Ref{ProtoMeta}()
function meta(::Type{Query_MatchGroup})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_MatchGroup)
            __meta_Query_MatchGroup[] = target = ProtoMeta(Query_MatchGroup)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Query_MatchGroup, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_MatchGroup[]
    end
end

mutable struct Query_MatchGroupAggregate_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_MatchGroupAggregate_Req(; kwargs...)
        obj = new(meta(Query_MatchGroupAggregate_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_MatchGroupAggregate_Req
const __meta_Query_MatchGroupAggregate_Req = Ref{ProtoMeta}()
function meta(::Type{Query_MatchGroupAggregate_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_MatchGroupAggregate_Req)
            __meta_Query_MatchGroupAggregate_Req[] = target = ProtoMeta(Query_MatchGroupAggregate_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:query => AbstractString]
            meta(target, Query_MatchGroupAggregate_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_MatchGroupAggregate_Req[]
    end
end
function Base.getproperty(obj::Query_MatchGroupAggregate_Req, name::Symbol)
    if name === :query
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct Query_MatchGroupAggregate_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_MatchGroupAggregate_Res(; kwargs...)
        obj = new(meta(Query_MatchGroupAggregate_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_MatchGroupAggregate_Res
const __meta_Query_MatchGroupAggregate_Res = Ref{ProtoMeta}()
function meta(::Type{Query_MatchGroupAggregate_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_MatchGroupAggregate_Res)
            __meta_Query_MatchGroupAggregate_Res[] = target = ProtoMeta(Query_MatchGroupAggregate_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:answers => Base.Vector{NumericGroup}]
            meta(target, Query_MatchGroupAggregate_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_MatchGroupAggregate_Res[]
    end
end
function Base.getproperty(obj::Query_MatchGroupAggregate_Res, name::Symbol)
    if name === :answers
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{NumericGroup}
    else
        getfield(obj, name)
    end
end

mutable struct Query_MatchGroupAggregate <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_MatchGroupAggregate(; kwargs...)
        obj = new(meta(Query_MatchGroupAggregate), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_MatchGroupAggregate
const __meta_Query_MatchGroupAggregate = Ref{ProtoMeta}()
function meta(::Type{Query_MatchGroupAggregate})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_MatchGroupAggregate)
            __meta_Query_MatchGroupAggregate[] = target = ProtoMeta(Query_MatchGroupAggregate)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Query_MatchGroupAggregate, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_MatchGroupAggregate[]
    end
end

mutable struct Query_Insert_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_Insert_Req(; kwargs...)
        obj = new(meta(Query_Insert_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_Insert_Req
const __meta_Query_Insert_Req = Ref{ProtoMeta}()
function meta(::Type{Query_Insert_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_Insert_Req)
            __meta_Query_Insert_Req[] = target = ProtoMeta(Query_Insert_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:query => AbstractString]
            meta(target, Query_Insert_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_Insert_Req[]
    end
end
function Base.getproperty(obj::Query_Insert_Req, name::Symbol)
    if name === :query
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct Query_Insert_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_Insert_Res(; kwargs...)
        obj = new(meta(Query_Insert_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_Insert_Res
const __meta_Query_Insert_Res = Ref{ProtoMeta}()
function meta(::Type{Query_Insert_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_Insert_Res)
            __meta_Query_Insert_Res[] = target = ProtoMeta(Query_Insert_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:answers => Base.Vector{ConceptMap}]
            meta(target, Query_Insert_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_Insert_Res[]
    end
end
function Base.getproperty(obj::Query_Insert_Res, name::Symbol)
    if name === :answers
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{ConceptMap}
    else
        getfield(obj, name)
    end
end

mutable struct Query_Insert <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_Insert(; kwargs...)
        obj = new(meta(Query_Insert), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_Insert
const __meta_Query_Insert = Ref{ProtoMeta}()
function meta(::Type{Query_Insert})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_Insert)
            __meta_Query_Insert[] = target = ProtoMeta(Query_Insert)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Query_Insert, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_Insert[]
    end
end

mutable struct Query_Delete_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_Delete_Req(; kwargs...)
        obj = new(meta(Query_Delete_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_Delete_Req
const __meta_Query_Delete_Req = Ref{ProtoMeta}()
function meta(::Type{Query_Delete_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_Delete_Req)
            __meta_Query_Delete_Req[] = target = ProtoMeta(Query_Delete_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:query => AbstractString]
            meta(target, Query_Delete_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_Delete_Req[]
    end
end
function Base.getproperty(obj::Query_Delete_Req, name::Symbol)
    if name === :query
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct Query_Delete_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_Delete_Res(; kwargs...)
        obj = new(meta(Query_Delete_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_Delete_Res
const __meta_Query_Delete_Res = Ref{ProtoMeta}()
function meta(::Type{Query_Delete_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_Delete_Res)
            __meta_Query_Delete_Res[] = target = ProtoMeta(Query_Delete_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Query_Delete_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_Delete_Res[]
    end
end

mutable struct Query_Delete <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_Delete(; kwargs...)
        obj = new(meta(Query_Delete), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_Delete
const __meta_Query_Delete = Ref{ProtoMeta}()
function meta(::Type{Query_Delete})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_Delete)
            __meta_Query_Delete[] = target = ProtoMeta(Query_Delete)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Query_Delete, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_Delete[]
    end
end

mutable struct Query_Define_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_Define_Req(; kwargs...)
        obj = new(meta(Query_Define_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_Define_Req
const __meta_Query_Define_Req = Ref{ProtoMeta}()
function meta(::Type{Query_Define_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_Define_Req)
            __meta_Query_Define_Req[] = target = ProtoMeta(Query_Define_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:query => AbstractString]
            meta(target, Query_Define_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_Define_Req[]
    end
end
function Base.getproperty(obj::Query_Define_Req, name::Symbol)
    if name === :query
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct Query_Define_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_Define_Res(; kwargs...)
        obj = new(meta(Query_Define_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_Define_Res
const __meta_Query_Define_Res = Ref{ProtoMeta}()
function meta(::Type{Query_Define_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_Define_Res)
            __meta_Query_Define_Res[] = target = ProtoMeta(Query_Define_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Query_Define_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_Define_Res[]
    end
end

mutable struct Query_Define <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_Define(; kwargs...)
        obj = new(meta(Query_Define), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_Define
const __meta_Query_Define = Ref{ProtoMeta}()
function meta(::Type{Query_Define})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_Define)
            __meta_Query_Define[] = target = ProtoMeta(Query_Define)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Query_Define, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_Define[]
    end
end

mutable struct Query_Undefine_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_Undefine_Req(; kwargs...)
        obj = new(meta(Query_Undefine_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_Undefine_Req
const __meta_Query_Undefine_Req = Ref{ProtoMeta}()
function meta(::Type{Query_Undefine_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_Undefine_Req)
            __meta_Query_Undefine_Req[] = target = ProtoMeta(Query_Undefine_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:query => AbstractString]
            meta(target, Query_Undefine_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_Undefine_Req[]
    end
end
function Base.getproperty(obj::Query_Undefine_Req, name::Symbol)
    if name === :query
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct Query_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_Req(; kwargs...)
        obj = new(meta(Query_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_Req
const __meta_Query_Req = Ref{ProtoMeta}()
function meta(::Type{Query_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_Req)
            __meta_Query_Req[] = target = ProtoMeta(Query_Req)
            fnum = Int[1,100,101,102,103,104,105,106,107]
            allflds = Pair{Symbol,Union{Type,String}}[:options => Options, :delete_req => Query_Delete_Req, :define_req => Query_Define_Req, :undefine_req => Query_Undefine_Req, :match_req => Query_Match_Req, :match_aggregate_req => Query_MatchAggregate_Req, :match_group_req => Query_MatchGroup_Req, :match_group_aggregate_req => Query_MatchGroupAggregate_Req, :insert_req => Query_Insert_Req]
            oneofs = Int[0,1,1,1,1,1,1,1,1]
            oneof_names = Symbol[Symbol("req")]
            meta(target, Query_Req, allflds, ProtoBuf.DEF_REQ, fnum, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Query_Req[]
    end
end
function Base.getproperty(obj::Query_Req, name::Symbol)
    if name === :options
        return (obj.__protobuf_jl_internal_values[name])::Options
    elseif name === :delete_req
        return (obj.__protobuf_jl_internal_values[name])::Query_Delete_Req
    elseif name === :define_req
        return (obj.__protobuf_jl_internal_values[name])::Query_Define_Req
    elseif name === :undefine_req
        return (obj.__protobuf_jl_internal_values[name])::Query_Undefine_Req
    elseif name === :match_req
        return (obj.__protobuf_jl_internal_values[name])::Query_Match_Req
    elseif name === :match_aggregate_req
        return (obj.__protobuf_jl_internal_values[name])::Query_MatchAggregate_Req
    elseif name === :match_group_req
        return (obj.__protobuf_jl_internal_values[name])::Query_MatchGroup_Req
    elseif name === :match_group_aggregate_req
        return (obj.__protobuf_jl_internal_values[name])::Query_MatchGroupAggregate_Req
    elseif name === :insert_req
        return (obj.__protobuf_jl_internal_values[name])::Query_Insert_Req
    else
        getfield(obj, name)
    end
end

mutable struct Query_Undefine_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_Undefine_Res(; kwargs...)
        obj = new(meta(Query_Undefine_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_Undefine_Res
const __meta_Query_Undefine_Res = Ref{ProtoMeta}()
function meta(::Type{Query_Undefine_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_Undefine_Res)
            __meta_Query_Undefine_Res[] = target = ProtoMeta(Query_Undefine_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Query_Undefine_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_Undefine_Res[]
    end
end

mutable struct Query_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_Res(; kwargs...)
        obj = new(meta(Query_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_Res
const __meta_Query_Res = Ref{ProtoMeta}()
function meta(::Type{Query_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_Res)
            __meta_Query_Res[] = target = ProtoMeta(Query_Res)
            fnum = Int[100,101,102,103,104,105,106,107]
            allflds = Pair{Symbol,Union{Type,String}}[:delete_res => Query_Delete_Res, :define_res => Query_Define_Res, :undefine_res => Query_Undefine_Res, :match_res => Query_Match_Res, :match_aggregate_res => Query_MatchAggregate_Res, :match_group_res => Query_MatchGroup_Res, :match_group_aggregate_res => Query_MatchGroupAggregate_Res, :insert_res => Query_Insert_Res]
            oneofs = Int[1,1,1,1,1,1,1,1]
            oneof_names = Symbol[Symbol("res")]
            meta(target, Query_Res, allflds, ProtoBuf.DEF_REQ, fnum, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Query_Res[]
    end
end
function Base.getproperty(obj::Query_Res, name::Symbol)
    if name === :delete_res
        return (obj.__protobuf_jl_internal_values[name])::Query_Delete_Res
    elseif name === :define_res
        return (obj.__protobuf_jl_internal_values[name])::Query_Define_Res
    elseif name === :undefine_res
        return (obj.__protobuf_jl_internal_values[name])::Query_Undefine_Res
    elseif name === :match_res
        return (obj.__protobuf_jl_internal_values[name])::Query_Match_Res
    elseif name === :match_aggregate_res
        return (obj.__protobuf_jl_internal_values[name])::Query_MatchAggregate_Res
    elseif name === :match_group_res
        return (obj.__protobuf_jl_internal_values[name])::Query_MatchGroup_Res
    elseif name === :match_group_aggregate_res
        return (obj.__protobuf_jl_internal_values[name])::Query_MatchGroupAggregate_Res
    elseif name === :insert_res
        return (obj.__protobuf_jl_internal_values[name])::Query_Insert_Res
    else
        getfield(obj, name)
    end
end

mutable struct Query_Undefine <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query_Undefine(; kwargs...)
        obj = new(meta(Query_Undefine), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query_Undefine
const __meta_Query_Undefine = Ref{ProtoMeta}()
function meta(::Type{Query_Undefine})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query_Undefine)
            __meta_Query_Undefine[] = target = ProtoMeta(Query_Undefine)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Query_Undefine, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query_Undefine[]
    end
end

mutable struct Query <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Query(; kwargs...)
        obj = new(meta(Query), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Query
const __meta_Query = Ref{ProtoMeta}()
function meta(::Type{Query})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Query)
            __meta_Query[] = target = ProtoMeta(Query)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Query, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Query[]
    end
end

export Query_Req, Query_Res, Query_Match_Req, Query_Match_Res, Query_Match, Query_MatchAggregate_Req, Query_MatchAggregate_Res, Query_MatchAggregate, Query_MatchGroup_Req, Query_MatchGroup_Res, Query_MatchGroup, Query_MatchGroupAggregate_Req, Query_MatchGroupAggregate_Res, Query_MatchGroupAggregate, Query_Insert_Req, Query_Insert_Res, Query_Insert, Query_Delete_Req, Query_Delete_Res, Query_Delete, Query_Define_Req, Query_Define_Res, Query_Define, Query_Undefine_Req, Query_Undefine_Res, Query_Undefine, Query
