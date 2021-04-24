# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

struct ThingType <: AbstractThingType
    label::Label
    is_root::Bool
end

# Porting note: Java client calls into RequstBuilder but it really
# has nothing to to with requests... I think it's probably better
# migrating the function here.
function proto(t::AbstractThingType)
    Proto._Type(
        label = t.label.name,
        encoding = encoding(t)
    )
    # return ThingTypeRequestBuilder.proto_thing_type(t.label, encoding(t))
end
