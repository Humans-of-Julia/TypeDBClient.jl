
using Behavior
using Behavior.Gherkin

rootpath = joinpath(@__DIR__, "test/behaviour")
featurepath = joinpath(@__DIR__, "test/behaviour/features/connection")
stepspath = joinpath(@__DIR__,"test/behaviour/connection")
configpath = joinpath(@__DIR__,"test/behaviour/config/ConfigEnvironment.jl")

p = ParseOptions(allow_any_step_order = true)

runspec(rootpath; featurepath = featurepath, stepspath = stepspath,  parseoptions=p, execenvpath = configpath, tags="not @ignore-typedb-core")

runspec(rootpath; featurepath = featurepath, stepspath = stepspath,  parseoptions=p, execenvpath = configpath, tags="@actual")
