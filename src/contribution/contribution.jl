module Contribution

using ..TypeDBClient

const g = TypeDBClient

export entity_set_owns

function entity_set_owns(thing_type::Type{<:g.AbstractThingType},
                entity::AbstractString,
                attribute_type::AbstractString,
                transaction::g.AbstractCoreTransaction,
                is_key = false,
                overriden::g.Optional{<:AbstractString} = nothing)

    cm = ConceptManager(transaction)
    loc_entity = nothing
    rem_entitiy = nothing
    loc_attribute = nothing
     try
         loc_entity = get(cm, thing_type, entity)
         rem_entitiy = g.as_remote(loc_entity, transaction)
         loc_attribute = get(cm, AttributeType, attribute_type)

         if overriden !== nothing
             overriden_attr = get(cm, AttributeType, overriden)
         else
             overriden_attr = nothing
         end

         @assert loc_entity !== nothing &&
                 rem_entitiy !== nothing &&
                 loc_attribute !== nothing

         set_owns(rem_entitiy, loc_attribute, is_key, overriden_attr)
     catch ex
         if loc_entity !== nothing
             @debug loc_entity
         else
             @debug "get entity_type not successfull. Please check your input"
         end
         if loc_attribute !== nothing
             @debug loc_attribute
         else
             @debug "get attribute not successfull. Please check your input"
         end
         rethrow(ex)
     end
     return nothing
 end

 function entity_set_owns(entity::AbstractString,
            attribute_type::AbstractString,
            transaction,
            is_key = false,
            overriden::g.Optional{String} = nothing)

     entity_set_owns(EntityType, entity, attribute_type, transaction, is_key, overriden)
 end

end
