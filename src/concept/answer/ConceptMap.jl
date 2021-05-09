# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

struct ConceptMap
    data::Dict{String, AbstractConcept}
end

struct Explainable
    conjunction::String
    explainable_id::Int64
end

struct Explainables
    relations::Optional{Dict{String,Explainable}}
    attributes::Optional{Dict{String,Explainable}}
    ownerships::Optional{Dict{Tuple{String},Explainable}}
end

function Explainable(explainable::Proto.Explainable)
   return Explainable(explainable.conjunction, explainable.id)
end

Explainable() = Explainables(nothing, nothing, nothing)

function Explainables(explainables::Proto.Explainables)
    relations = Dict{String,Explainable}()
    for (var, explainable) in explainables.relations.items
        relations[var] = Explainable(explainable)
    end
    attributes = Dict{String,Explainable}()
    for (var, explainable) in explainables.attributes.items
        attributes[var] = Explainable(explainable)
    end
    ownerships = Dict{String,Explainable}()
    for (var, owned_map) in explainables.ownerships.items
        for (owned, explainable) in owned_map.owned.items
            ownerships[(var, owned)] = Explainable(explainable)
        end
    end
    return Explainables(relations, attributes, ownerships)
end

concepts(cm::ConceptMap) = values(cm.data)

Base.getindex(cm::ConceptMap, key::String) = cm.data[key]

function Base.show(io::IO, cm::ConceptMap)
    num_entries = length(cm.data)
    print(io, "ConceptMap:\n")
    for (i, k) in enumerate(sort(collect(keys(cm.data))))
        #TODO: decide which type of printing looks better. For me (Frank) it looks better
        #with a line break after each line.
        #i != num_entries && print(io, "\n")
        print(io, lpad("$i", 5), ". ", k, " => ", cm.data[k], "\n")
    end
end

function ConceptMap(res::Proto.ConceptMap)
    return ConceptMap(Dict(key => instantiate(concept) for (key, concept) in res.map))
end

function ConceptMap(array_concept_maps::Vector{Proto.ConceptMap})
    # return map(entry->ConceptMap(entry), array_concept_maps)
    return ConceptMap.(array_concept_maps)
end
