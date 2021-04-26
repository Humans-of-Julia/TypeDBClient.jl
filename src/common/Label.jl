# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

# Porting note: no need to store `hash` as we can just use the standard hash function
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
