# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE


# from typing import Mapping

# import grakn_protocol.protobuf.answer_pb2 as answer_proto

# from grakn.common.exception import GraknClientException
# from grakn.concept.proto import concept_proto_reader
# from grakn.concept.concept import Concept

import Base.==

mutable struct ConceptMap
    _map::Dict{String,Concept}
end

_THING = "thing"

function ConceptMap(mapping::Dict{String,Concept})
    ConceptMap(mapping)
end

function ConceptMap()
    ConceptMap(Dict{String,Concept}())
end

function map(conc_map::ConceptMap)
    conc_map._map
end

function concepts(conc_map::ConceptMap)
    values(conc_map._map)
end

function get(conc_map::ConceptMap, variable::String)
    !haskey(conc_map._map, variable) && throw(GraknClientException("The variable " * variable * " does not exist."))
    conc_map._map[variable]
end

function Base.print(iO::IO, conc_map::ConceptMap)
        # return "".join(map(lambda var: "[" + var + "/" + str(self._map[var]) + "]", sorted(self._map.keys())))
        str = join(["[$x / $(conc_map._map[x])]"  for x in keys(conc_map._map)],"\n","\n")
        Base.print(iO,str)
end

Base.show(io::IO, conc_map::ConceptMap) = Base.print(io,conc_map)

function Base.==(conc_map_one::ConceptMap, conc_map_two::ConceptMap)
    if conc_map_one === conc_map_two
        return true
    end
    conc_map_one._map == conc_map_two._map
end

function hash(conc_map::ConceptMap)
    hash(conc_map._map)
end


function _of(concept_map_proto::grakn.protocol.ConceptMap)
    variable_map = Dict{String,Concept}()
    throw(GraknClientException("concept_proto_reader is not implemented yet"))
    for res_var in concept_map_proto.map
        # TODO: implement the concept_proto_reader
        concept = concept_proto_reader.concept (concept_map_proto.map[res_var])
        variable_map[res_var] = concept
    end
    ConceptMap(variable_map)
end
