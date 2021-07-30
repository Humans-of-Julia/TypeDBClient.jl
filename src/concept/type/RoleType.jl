# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

struct RoleType <: AbstractRoleType
    label::Label
    is_root::Bool
end

# Porting note: Java client calls into RequstBuilder but it really
# has nothing to do with requests... I think it's probably better
# migrating the function here.
function proto(t::AbstractRoleType)
    @assert t.label.scope !== nothing
    Proto._Type(
        label = t.label.name,
        scope = t.label.scope,
        encoding = encoding(t)
    )
end
