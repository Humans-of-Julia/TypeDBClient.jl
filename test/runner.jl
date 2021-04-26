
using Behavior
using Behavior.Gherkin

rootpath = joinpath(@__DIR__, "test/behaviour")
featurepath = joinpath(@__DIR__, "test/behaviour/features/connection")
stepspath = joinpath(@__DIR__,"test/behaviour/features/steps")

p = ParseOptions(allow_any_step_order = true)

runspec(rootpath; featurepath = featurepath, stepspath = stepspath, parseoptions=p)
