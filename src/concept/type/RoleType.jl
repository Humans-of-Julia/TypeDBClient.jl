# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

struct RoleType <: AbstractType
    label::Label
    is_root::Bool
end

function RoleType(t::Proto._Type)
    return hasproperty(t, :scope) ?
        RoleType(Label(t.scope, t.label), t.root) :
        RoleType(Label(t.label), t.root)
end
