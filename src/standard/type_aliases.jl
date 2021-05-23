
# quick reference to commonly used modules
const Proto = typedb.protocol

# Convenient types

const Optional{T} = Union{T,Nothing}
const Transaction_Res_All = Union{Proto.Transaction_Res, Proto.Transaction_ResPart}

# protobuf types
const EnumType = Int32
const Bytes = Array{UInt8,1}
