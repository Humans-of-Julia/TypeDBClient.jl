# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

import enum

from datetime import datetime
from typing import Union


@enum ValueType begin
    # This lives here to avoid circular imports.
    OBJECT = 0
    BOOLEAN = 1
    LONG = 2
    DOUBLE = 3
    STRING = 4
    DATETIME = 5
end


ValueClass = Union{Bool, Int, T , String, DateTime} where {T<:AbstractFloat}