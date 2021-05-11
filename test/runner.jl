
using Behavior
using Behavior.Gherkin

rootpath = joinpath(@__DIR__, "test/behaviour")
featurepath = joinpath(@__DIR__, "test/behaviour/features/connection")
stepspath = joinpath(@__DIR__,"test/behaviour/connection")
configpath = joinpath(@__DIR__,"test/behaviour/config/ConfigEnvironment.jl")

p = ParseOptions(allow_any_step_order = true)

@enter runspec(rootpath; featurepath = featurepath, stepspath = stepspath,  parseoptions=p, execenvpath = configpath)
