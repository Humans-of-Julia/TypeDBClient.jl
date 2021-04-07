# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

# Migratin note: no need to store `hash` so we just use the standard hash function
struct Label
    scope::Optional{String}
    name::String
end

Label(name::AbstractString) = Label(nothing, name)
Label(scope::AbstractString, name::AbstractString) = Label(scope, name)

function scoped_name(label::Label)
    return label.scope === nothing ?
        label.name :
        string(label.scope, ":", label.name)
end

Base.show(io::IO, label::Label) = print(io, scoped_name(label))

# Base.propertynames(::Label) = (:scope, :name, :scoped_name)

# function Base.getproperty(label::Label, s::Symbol)
#     if s === :scoped_name
#         return scoped_name(label)
#     elseif s in (:scope, :name)
#         return getfield(label, s)
#     else
#         throw(ArgumentError("Invalid property name: $s"))
#     end
# end
