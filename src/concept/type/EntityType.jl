# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

struct EntityType <: AbstractEntityType
    label::Label
    is_root::Bool
end
