"""
    bytes(x)

Convert `x` to `Vector{UInt8}`.
"""
bytes(x::UUID) = collect(reinterpret(UInt8, [hton(x.value)]))

function bytes(s::String)
    chunks = (s[i:i+1] for i in 1:2:length(s)-1)  # 2-char chunks
    parse.(UInt8, chunks; base = 16)
end

# Tracing data is a feature of grabl. No implementation for now.
tracing_data() = Dict{AbstractString, AbstractString}()
