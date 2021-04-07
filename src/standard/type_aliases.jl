# Convenient types

const Optional{T} = Union{T,Nothing}

# quick reference to commonly used modules
const P = grakn.protocol

# protobuf types
const EnumType = Int32
const Bytes = Array{UInt8,1}
