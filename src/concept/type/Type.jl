# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

function create(t::Proto._Type)
    if t.encoding == Proto.Type_Encoding.ROLE_TYPE
        return RoleType(t)
    else
        # TODO
        # return ThingType(t)
    end
end
