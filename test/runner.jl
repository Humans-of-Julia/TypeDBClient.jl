using Base: runtests

using Behavior
using Behavior.Gherkin
using TypeDBClient

g = TypeDBClient
client = g.CoreClient("localhost",1729)

rootpath = joinpath(@__DIR__,"behaviour")
featurepath = joinpath(@__DIR__,"behaviour/features")
stepspath = joinpath(@__DIR__,"behaviour")
configpath = joinpath(@__DIR__,"behaviour/config/ConfigEnvironment.jl")

p = ParseOptions(allow_any_step_order = true)

# runspec(rootpath; featurepath = featurepath, stepspath = stepspath,  parseoptions=p, execenvpath = configpath, tags="not @ignore-typedb-core")

function run_tests(tag::String = "")
    runspec(rootpath; featurepath = featurepath, stepspath = stepspath,  parseoptions=p, execenvpath = configpath, tags=tag)
    # runspec(rootpath; featurepath = featurepath, stepspath = stepspath,  parseoptions=p, execenvpath = configpath)
end


# run_tests("not @ignore-typedb-core")
# run_tests("@failure")
run_tests("@actual")
