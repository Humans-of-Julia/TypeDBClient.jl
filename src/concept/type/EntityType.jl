# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

struct EntityType <: AbstractEntityType
    label::Label
    is_root::Bool
end
