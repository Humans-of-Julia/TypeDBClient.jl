# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

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
        i != num_entries && print(io, "\n")
        print(io, lpad("$i", 5), ". ", k, " => ", cm.data[k])
    end
end

function ConceptMap(res::Proto.ConceptMap)
    return ConceptMap(Dict(key => instantiate(concept) for (key, concept) in res.map))
end
