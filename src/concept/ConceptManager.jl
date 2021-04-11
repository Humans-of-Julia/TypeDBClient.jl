# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

# mutable struct ConceptManager <: AbstractConceptManager
# end

# function get_root_thing_type(concept_manager::T) where {T<:AbstractConceptManager}
#     throw("ConceptImpl.jl get_root_thing_type not implemented")
#     return get_thing_type(concept_manager, "thing")
# end

# function get_thing_type(concept_manager::T, label::String) where {T<:AbstractConceptManager}
#     throw("ConceptImpl.jl get_thing_type not implemented")
#     execute(concept_manager, concept_manager_get_thing_type_req(label))

#     result = concept_proto_reader.thing_type(res.get_thing_type_res.thing_type)
#     if result.get_thing_type_res.WhichOneof("res") == "thing_type"
#         return result
#     else
#         return nothing
#     end
# end
