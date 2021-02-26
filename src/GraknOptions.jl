
abstract type AbstractGraknOptions end
abstract type AbstractGraknClusterOptions <: AbstractGraknOptions end

mutable struct GraknOptions <: AbstractGraknOptions
    infer::Union{Bool,Nothing}
    trace_inference::Union{Bool,Nothing}
    explain::Union{Bool,Nothing}
    batch_size::Union{Int,Nothing}
end

mutable struct GraknClusterOptions <: AbstractGraknClusterOptions
    infer::Union{Bool,Nothing}
    trace_inference::Union{Bool,Nothing}
    explain::Union{Bool,Nothing}
    batch_size::Union{Int,Nothing}
    read_any_replica::Union{Bool,Nothing}
end


function grakn_options_init(graknoption::Type{T},infer=nothing,trace_inference=nothing ,explain=nothing,batch_size=nothing,read_any_replica=nothing) where {T<:AbstractGraknOptions}
    result = graknoption(infer,trace_inference,explain,batch_size)
    isdefined(result, :read_any_replica) ? result.read_any_replica = read_any_replica : nothing
    result
end

GraknOptions() = grakn_options_init(GraknOptions)
GraknClusterOptions() = grakn_options_init(GraknClusterOptions)

function core()
    GraknOptions()
end

function cluster()
    GraknClusterOptions()
end

function is_cluster(m::GraknOptions)
    false
end

function is_cluster(m::GraknClusterOptions)
    true
end