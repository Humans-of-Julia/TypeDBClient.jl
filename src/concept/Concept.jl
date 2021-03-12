# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

struct Concept <:AbstractConcept
end

is_type(m::Concept) = false
is_thing_type(m::Concept)= false
is_entity_type(m::Concept)= false
is_attribute_type(m::Concept) = false
is_relation_type(m::Concept)= false
is_role_type(m::Concept)= false
is_thing(m::Concept)= false
is_entity(m::Concept)= false
is_attribute(m::Concept)= false
is_relation(m::Concept)= false
is_remote(m::Concept)= false


struct RemoteConcept <:AbstractConcept
end

is_remote(m::RemoteConcept)= true
delete(m::RemoteConcept)= nothing
is_deleted(m::RemoteConcept)= false
is_type(m::RemoteConcept)= false
is_thing_type(m::RemoteConcept)= false
is_entity_type(m::RemoteConcept)= false
is_attribute_type(m::RemoteConcept)= false
is_relation_type(m::RemoteConcept)= false
is_role_type(m::RemoteConcept)= false
is_thing(m::RemoteConcept)= false
is_entity(m::RemoteConcept)= false
is_attribute(m::RemoteConcept)= false
is_relation(m::RemoteConcept)= false
