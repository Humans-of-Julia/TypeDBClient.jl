# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

struct ConceptMap
    data::Dict{String, AbstractConcept}
end

# Java uses "unmodifiableMap" but if that's the case I would probably hide
# the implementation here and not expose the underlying Dict. Hence commenting
# out the following function.
# map(cm::ConceptMap) = cm.data

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
    return map(entry->ConceptMap(entry), array_concept_maps)
end
