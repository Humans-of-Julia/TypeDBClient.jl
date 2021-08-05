# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

function _set_supertype_for_type(context, abstract_type::Type{<:g.AbstractThingType}, norm_type::String, super_type::String)
    attr = g.get(ConceptManager(context[:transaction]), abstract_type, norm_type)
    super_type = g.get(ConceptManager(context[:transaction]), abstract_type, super_type)
    g.set_supertype(g.as_remote(attr, context[:transaction]),
                    super_type)
end

function _is_supertype_for_type(context, abstract_type::Type{<:g.AbstractThingType}, attr_name::String, super_type_name::String)
    attr = g.get(ConceptManager(context[:transaction]), abstract_type, attr_name)
    super_type = g.get_supertype(g.as_remote(attr, context[:transaction]))

    return super_type.label.name == super_type_name
end

function _supertypes_contain(context, abstract_type::Type{<:g.AbstractThingType}, attr_name::String)
    super_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), abstract_type, attr_name)
    res_types = g.get_supertypes(g.as_remote(attr, context[:transaction]))
    res_array = Bool[]
    for attr in res_types
        push!(res_array, in(attr.label.name, super_types))
    end
    return res_array
end

function _subtypes_contain(context, abstract_type::Type{<:g.AbstractThingType}, attr_name::String)
    super_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), abstract_type, attr_name)
    res_types = g.get_subtypes(g.as_remote(attr, context[:transaction]))
    res_array = Bool[]
    for attr in res_types
        push!(res_array, in(attr.label.name, super_types))
    end

    return res_array
end

function _get_owns_contain(context, abstract_type::Type{<:g.AbstractThingType}, owner::String, is_key::Bool=false)
    key_types = [db[1] for db in context.datatable]
    attr = g.get(ConceptManager(context[:transaction]), abstract_type, owner)
    types_owns = g.get_owns(g.as_remote(attr, context[:transaction]),
                                nothing,
                                is_key)
    res_array = Bool[]
    for i in 1:length(key_types)
        key_type = g.get(ConceptManager(context[:transaction]),
                            ThingType,
                            key_types[i])
        push!(res_array, in(key_type, types_owns))
    end

    return res_array
end
