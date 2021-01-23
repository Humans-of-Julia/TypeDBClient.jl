# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct LogicManager_GetRule_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function LogicManager_GetRule_Req(; kwargs...)
        obj = new(meta(LogicManager_GetRule_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct LogicManager_GetRule_Req
const __meta_LogicManager_GetRule_Req = Ref{ProtoMeta}()
function meta(::Type{LogicManager_GetRule_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_LogicManager_GetRule_Req)
            __meta_LogicManager_GetRule_Req[] = target = ProtoMeta(LogicManager_GetRule_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:label => AbstractString]
            meta(target, LogicManager_GetRule_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_LogicManager_GetRule_Req[]
    end
end
function Base.getproperty(obj::LogicManager_GetRule_Req, name::Symbol)
    if name === :label
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct LogicManager_GetRule <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function LogicManager_GetRule(; kwargs...)
        obj = new(meta(LogicManager_GetRule), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct LogicManager_GetRule
const __meta_LogicManager_GetRule = Ref{ProtoMeta}()
function meta(::Type{LogicManager_GetRule})
    ProtoBuf.metalock() do
        if !isassigned(__meta_LogicManager_GetRule)
            __meta_LogicManager_GetRule[] = target = ProtoMeta(LogicManager_GetRule)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, LogicManager_GetRule, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_LogicManager_GetRule[]
    end
end

mutable struct LogicManager_PutRule_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function LogicManager_PutRule_Req(; kwargs...)
        obj = new(meta(LogicManager_PutRule_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct LogicManager_PutRule_Req
const __meta_LogicManager_PutRule_Req = Ref{ProtoMeta}()
function meta(::Type{LogicManager_PutRule_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_LogicManager_PutRule_Req)
            __meta_LogicManager_PutRule_Req[] = target = ProtoMeta(LogicManager_PutRule_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:label => AbstractString, :when => AbstractString, :then => AbstractString]
            meta(target, LogicManager_PutRule_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_LogicManager_PutRule_Req[]
    end
end
function Base.getproperty(obj::LogicManager_PutRule_Req, name::Symbol)
    if name === :label
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :when
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :then
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct LogicManager_PutRule <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function LogicManager_PutRule(; kwargs...)
        obj = new(meta(LogicManager_PutRule), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct LogicManager_PutRule
const __meta_LogicManager_PutRule = Ref{ProtoMeta}()
function meta(::Type{LogicManager_PutRule})
    ProtoBuf.metalock() do
        if !isassigned(__meta_LogicManager_PutRule)
            __meta_LogicManager_PutRule[] = target = ProtoMeta(LogicManager_PutRule)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, LogicManager_PutRule, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_LogicManager_PutRule[]
    end
end

mutable struct LogicManager_GetRules_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function LogicManager_GetRules_Req(; kwargs...)
        obj = new(meta(LogicManager_GetRules_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct LogicManager_GetRules_Req
const __meta_LogicManager_GetRules_Req = Ref{ProtoMeta}()
function meta(::Type{LogicManager_GetRules_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_LogicManager_GetRules_Req)
            __meta_LogicManager_GetRules_Req[] = target = ProtoMeta(LogicManager_GetRules_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, LogicManager_GetRules_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_LogicManager_GetRules_Req[]
    end
end

mutable struct LogicManager_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function LogicManager_Req(; kwargs...)
        obj = new(meta(LogicManager_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct LogicManager_Req
const __meta_LogicManager_Req = Ref{ProtoMeta}()
function meta(::Type{LogicManager_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_LogicManager_Req)
            __meta_LogicManager_Req[] = target = ProtoMeta(LogicManager_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:get_rule_req => LogicManager_GetRule_Req, :put_rule_req => LogicManager_PutRule_Req, :get_rules_req => LogicManager_GetRules_Req]
            oneofs = Int[1,1,1]
            oneof_names = Symbol[Symbol("req")]
            meta(target, LogicManager_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_LogicManager_Req[]
    end
end
function Base.getproperty(obj::LogicManager_Req, name::Symbol)
    if name === :get_rule_req
        return (obj.__protobuf_jl_internal_values[name])::LogicManager_GetRule_Req
    elseif name === :put_rule_req
        return (obj.__protobuf_jl_internal_values[name])::LogicManager_PutRule_Req
    elseif name === :get_rules_req
        return (obj.__protobuf_jl_internal_values[name])::LogicManager_GetRules_Req
    else
        getfield(obj, name)
    end
end

mutable struct LogicManager_GetRules <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function LogicManager_GetRules(; kwargs...)
        obj = new(meta(LogicManager_GetRules), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct LogicManager_GetRules
const __meta_LogicManager_GetRules = Ref{ProtoMeta}()
function meta(::Type{LogicManager_GetRules})
    ProtoBuf.metalock() do
        if !isassigned(__meta_LogicManager_GetRules)
            __meta_LogicManager_GetRules[] = target = ProtoMeta(LogicManager_GetRules)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, LogicManager_GetRules, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_LogicManager_GetRules[]
    end
end

mutable struct LogicManager <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function LogicManager(; kwargs...)
        obj = new(meta(LogicManager), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct LogicManager
const __meta_LogicManager = Ref{ProtoMeta}()
function meta(::Type{LogicManager})
    ProtoBuf.metalock() do
        if !isassigned(__meta_LogicManager)
            __meta_LogicManager[] = target = ProtoMeta(LogicManager)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, LogicManager, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_LogicManager[]
    end
end

mutable struct Rule_Delete_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Rule_Delete_Req(; kwargs...)
        obj = new(meta(Rule_Delete_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Rule_Delete_Req
const __meta_Rule_Delete_Req = Ref{ProtoMeta}()
function meta(::Type{Rule_Delete_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Rule_Delete_Req)
            __meta_Rule_Delete_Req[] = target = ProtoMeta(Rule_Delete_Req)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Rule_Delete_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Rule_Delete_Req[]
    end
end

mutable struct Rule_Delete_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Rule_Delete_Res(; kwargs...)
        obj = new(meta(Rule_Delete_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Rule_Delete_Res
const __meta_Rule_Delete_Res = Ref{ProtoMeta}()
function meta(::Type{Rule_Delete_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Rule_Delete_Res)
            __meta_Rule_Delete_Res[] = target = ProtoMeta(Rule_Delete_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Rule_Delete_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Rule_Delete_Res[]
    end
end

mutable struct Rule_Delete <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Rule_Delete(; kwargs...)
        obj = new(meta(Rule_Delete), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Rule_Delete
const __meta_Rule_Delete = Ref{ProtoMeta}()
function meta(::Type{Rule_Delete})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Rule_Delete)
            __meta_Rule_Delete[] = target = ProtoMeta(Rule_Delete)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Rule_Delete, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Rule_Delete[]
    end
end

mutable struct Rule_SetLabel_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Rule_SetLabel_Req(; kwargs...)
        obj = new(meta(Rule_SetLabel_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Rule_SetLabel_Req
const __meta_Rule_SetLabel_Req = Ref{ProtoMeta}()
function meta(::Type{Rule_SetLabel_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Rule_SetLabel_Req)
            __meta_Rule_SetLabel_Req[] = target = ProtoMeta(Rule_SetLabel_Req)
            allflds = Pair{Symbol,Union{Type,String}}[:label => AbstractString]
            meta(target, Rule_SetLabel_Req, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Rule_SetLabel_Req[]
    end
end
function Base.getproperty(obj::Rule_SetLabel_Req, name::Symbol)
    if name === :label
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct Rule_Req <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Rule_Req(; kwargs...)
        obj = new(meta(Rule_Req), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Rule_Req
const __meta_Rule_Req = Ref{ProtoMeta}()
function meta(::Type{Rule_Req})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Rule_Req)
            __meta_Rule_Req[] = target = ProtoMeta(Rule_Req)
            fnum = Int[1,100,101]
            allflds = Pair{Symbol,Union{Type,String}}[:label => AbstractString, :rule_delete_req => Rule_Delete_Req, :rule_set_label_req => Rule_SetLabel_Req]
            oneofs = Int[0,1,1]
            oneof_names = Symbol[Symbol("req")]
            meta(target, Rule_Req, allflds, ProtoBuf.DEF_REQ, fnum, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Rule_Req[]
    end
end
function Base.getproperty(obj::Rule_Req, name::Symbol)
    if name === :label
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :rule_delete_req
        return (obj.__protobuf_jl_internal_values[name])::Rule_Delete_Req
    elseif name === :rule_set_label_req
        return (obj.__protobuf_jl_internal_values[name])::Rule_SetLabel_Req
    else
        getfield(obj, name)
    end
end

mutable struct Rule_SetLabel_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Rule_SetLabel_Res(; kwargs...)
        obj = new(meta(Rule_SetLabel_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Rule_SetLabel_Res
const __meta_Rule_SetLabel_Res = Ref{ProtoMeta}()
function meta(::Type{Rule_SetLabel_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Rule_SetLabel_Res)
            __meta_Rule_SetLabel_Res[] = target = ProtoMeta(Rule_SetLabel_Res)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Rule_SetLabel_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Rule_SetLabel_Res[]
    end
end

mutable struct Rule_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Rule_Res(; kwargs...)
        obj = new(meta(Rule_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Rule_Res
const __meta_Rule_Res = Ref{ProtoMeta}()
function meta(::Type{Rule_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Rule_Res)
            __meta_Rule_Res[] = target = ProtoMeta(Rule_Res)
            fnum = Int[100,101]
            allflds = Pair{Symbol,Union{Type,String}}[:rule_delete_res => Rule_Delete_Res, :rule_set_label_res => Rule_SetLabel_Res]
            oneofs = Int[1,1]
            oneof_names = Symbol[Symbol("res")]
            meta(target, Rule_Res, allflds, ProtoBuf.DEF_REQ, fnum, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_Rule_Res[]
    end
end
function Base.getproperty(obj::Rule_Res, name::Symbol)
    if name === :rule_delete_res
        return (obj.__protobuf_jl_internal_values[name])::Rule_Delete_Res
    elseif name === :rule_set_label_res
        return (obj.__protobuf_jl_internal_values[name])::Rule_SetLabel_Res
    else
        getfield(obj, name)
    end
end

mutable struct Rule_SetLabel <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Rule_SetLabel(; kwargs...)
        obj = new(meta(Rule_SetLabel), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Rule_SetLabel
const __meta_Rule_SetLabel = Ref{ProtoMeta}()
function meta(::Type{Rule_SetLabel})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Rule_SetLabel)
            __meta_Rule_SetLabel[] = target = ProtoMeta(Rule_SetLabel)
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Rule_SetLabel, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Rule_SetLabel[]
    end
end

mutable struct Rule <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Rule(; kwargs...)
        obj = new(meta(Rule), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Rule
const __meta_Rule = Ref{ProtoMeta}()
function meta(::Type{Rule})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Rule)
            __meta_Rule[] = target = ProtoMeta(Rule)
            allflds = Pair{Symbol,Union{Type,String}}[:label => AbstractString, :when => AbstractString, :then => AbstractString]
            meta(target, Rule, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Rule[]
    end
end
function Base.getproperty(obj::Rule, name::Symbol)
    if name === :label
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :when
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :then
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct LogicManager_GetRule_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function LogicManager_GetRule_Res(; kwargs...)
        obj = new(meta(LogicManager_GetRule_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct LogicManager_GetRule_Res
const __meta_LogicManager_GetRule_Res = Ref{ProtoMeta}()
function meta(::Type{LogicManager_GetRule_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_LogicManager_GetRule_Res)
            __meta_LogicManager_GetRule_Res[] = target = ProtoMeta(LogicManager_GetRule_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:rule => Rule]
            oneofs = Int[1]
            oneof_names = Symbol[Symbol("res")]
            meta(target, LogicManager_GetRule_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_LogicManager_GetRule_Res[]
    end
end
function Base.getproperty(obj::LogicManager_GetRule_Res, name::Symbol)
    if name === :rule
        return (obj.__protobuf_jl_internal_values[name])::Rule
    else
        getfield(obj, name)
    end
end

mutable struct LogicManager_PutRule_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function LogicManager_PutRule_Res(; kwargs...)
        obj = new(meta(LogicManager_PutRule_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct LogicManager_PutRule_Res
const __meta_LogicManager_PutRule_Res = Ref{ProtoMeta}()
function meta(::Type{LogicManager_PutRule_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_LogicManager_PutRule_Res)
            __meta_LogicManager_PutRule_Res[] = target = ProtoMeta(LogicManager_PutRule_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:rule => Rule]
            meta(target, LogicManager_PutRule_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_LogicManager_PutRule_Res[]
    end
end
function Base.getproperty(obj::LogicManager_PutRule_Res, name::Symbol)
    if name === :rule
        return (obj.__protobuf_jl_internal_values[name])::Rule
    else
        getfield(obj, name)
    end
end

mutable struct LogicManager_GetRules_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function LogicManager_GetRules_Res(; kwargs...)
        obj = new(meta(LogicManager_GetRules_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct LogicManager_GetRules_Res
const __meta_LogicManager_GetRules_Res = Ref{ProtoMeta}()
function meta(::Type{LogicManager_GetRules_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_LogicManager_GetRules_Res)
            __meta_LogicManager_GetRules_Res[] = target = ProtoMeta(LogicManager_GetRules_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:rules => Base.Vector{Rule}]
            meta(target, LogicManager_GetRules_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_LogicManager_GetRules_Res[]
    end
end
function Base.getproperty(obj::LogicManager_GetRules_Res, name::Symbol)
    if name === :rules
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{Rule}
    else
        getfield(obj, name)
    end
end

mutable struct LogicManager_Res <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function LogicManager_Res(; kwargs...)
        obj = new(meta(LogicManager_Res), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct LogicManager_Res
const __meta_LogicManager_Res = Ref{ProtoMeta}()
function meta(::Type{LogicManager_Res})
    ProtoBuf.metalock() do
        if !isassigned(__meta_LogicManager_Res)
            __meta_LogicManager_Res[] = target = ProtoMeta(LogicManager_Res)
            allflds = Pair{Symbol,Union{Type,String}}[:get_rule_res => LogicManager_GetRule_Res, :put_rule_res => LogicManager_PutRule_Res, :get_rules_res => LogicManager_GetRules_Res]
            oneofs = Int[1,1,1]
            oneof_names = Symbol[Symbol("res")]
            meta(target, LogicManager_Res, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_LogicManager_Res[]
    end
end
function Base.getproperty(obj::LogicManager_Res, name::Symbol)
    if name === :get_rule_res
        return (obj.__protobuf_jl_internal_values[name])::LogicManager_GetRule_Res
    elseif name === :put_rule_res
        return (obj.__protobuf_jl_internal_values[name])::LogicManager_PutRule_Res
    elseif name === :get_rules_res
        return (obj.__protobuf_jl_internal_values[name])::LogicManager_GetRules_Res
    else
        getfield(obj, name)
    end
end

export LogicManager_Req, LogicManager_Res, LogicManager_GetRule_Req, LogicManager_GetRule_Res, LogicManager_GetRule, LogicManager_PutRule_Req, LogicManager_PutRule_Res, LogicManager_PutRule, LogicManager_GetRules_Req, LogicManager_GetRules_Res, LogicManager_GetRules, LogicManager, Rule_Req, Rule_Res, Rule_Delete_Req, Rule_Delete_Res, Rule_Delete, Rule_SetLabel_Req, Rule_SetLabel_Res, Rule_SetLabel, Rule
