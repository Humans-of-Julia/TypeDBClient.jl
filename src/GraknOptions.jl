# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

abstract type AbstractGraknOptions end
abstract type AbstractGraknClusterOptions <: AbstractGraknOptions end

mutable struct GraknOptions <: AbstractGraknOptions
    infer::Union{Bool,Nothing}
    trace_inference::Union{Bool,Nothing}
    explain::Union{Bool,Nothing}
    batch_size::Union{Int,Nothing}
    session_idle_timeout_millis::Union{Int,Nothing}
end

mutable struct GraknClusterOptions <: AbstractGraknClusterOptions
    infer::Union{Bool,Nothing}
    trace_inference::Union{Bool,Nothing}
    explain::Union{Bool,Nothing}
    batch_size::Union{Int,Nothing}
    session_idle_timeout_millis::Union{Int,Nothing}
    read_any_replica::Union{Bool,Nothing}
end


function grakn_options_init(graknoption::Type{T},infer=nothing,trace_inference=nothing ,explain=nothing,batch_size=nothing,read_any_replica=nothing,session_idle_timeout_millis=0) where {T<:AbstractGraknOptions}
    if graknoption == GraknOptions
        result = graknoption(infer,trace_inference,explain,batch_size,session_idle_timeout_millis)
    else 
        result = graknoption(infer,trace_inference,explain,batch_size,session_idle_timeout_millis, read_any_replica)
    end
    result
end

GraknOptions() = grakn_options_init(GraknOptions)
GraknOptions(session_idle_timeout_millis::Int) = grakn_options_init(GraknOptions,nothing,nothing ,nothing,nothing,nothing,session_idle_timeout_millis)
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

############ Helper functions ##########

function copyFrom(fromOption::R, toOption::Type{T}) where {T<:grakn.protocol.Options} where {R<:AbstractGraknOptions}
    result_option = toOption()
    for fname in fieldnames(typeof(fromOption))
        if !hasproperty(result_option, Symbol(fname)) && getfield(fromOption,Symbol(fname)) !== nothing
            setproperty!(result_option,Symbol(fname),getfield(fromOption,Symbol(fname)))
        end
    end
    result_option
end