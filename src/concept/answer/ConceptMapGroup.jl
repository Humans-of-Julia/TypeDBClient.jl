# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

struct ConceptMapGroup
    owner::AbstractConcept
    concept_maps::Vector{ConceptMap}
end

function ConceptMapGroup(res::Proto.ConceptMapGroup)
    _owner = instantiate(res.owner)
    _concept_maps = ConceptMap(res.concept_maps)
    return ConceptMapGroup(_owner, _concept_maps)
end

function ConceptMapGroup(res::Vector{Proto.ConceptMapGroup})
    _owner = instantiate(res.owner)
    _concept_maps = ConceptMap(res.concept_maps)
    return ConceptMapGroup(_owner, _concept_maps)
end
