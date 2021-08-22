# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

mutable struct TypeDBOptions
    infer::Optional{Bool}
    trace_inference::Optional{Bool}
    explain::Optional{Bool}
    parallel::Optional{Bool}
    batch_size::Optional{Int}
    prefetch::Optional{Bool}
    session_idle_timeout_millis::Optional{Int}
    schema_lock_acquire_timeout_millis::Optional{Int}
end

function TypeDBOptions()
    return TypeDBOptions(nothing,nothing,nothing,nothing,nothing,nothing,nothing,nothing)
end

function typedb_options_core()
    return TypeDBOptions()
end
