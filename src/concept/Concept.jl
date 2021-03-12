# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

struct Concept 
end

is_type(Concept) = false
is_thing_type(Concept)= false
is_entity_type(Concept)= false
is_attribute_type(Concept) = false
is_relation_type(Concept)= false
is_role_type(Concept)= false
is_thing(Concept)= false
is_entity(Concept)= false
is_attribute(Concept)= false
is_relation(Concept)= false
is_remote(Concept)= false


struct RemoteConcept
end

is_remote(RemoteConcept)= true
delete(RemoteConcept)= nothing
is_deleted(RemoteConcept)= false
is_type(RemoteConcept)= false
is_thing_type(RemoteConcept)= false
is_entity_type(RemoteConcept)= false
is_attribute_type(RemoteConcept)= false
is_relation_type(RemoteConcept)= false
is_role_type(RemoteConcept)= false
is_thing(RemoteConcept)= false
is_entity(RemoteConcept)= false
is_attribute(RemoteConcept)= false
is_relation(RemoteConcept)= false
