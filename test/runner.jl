using Pkg
cd(@__DIR__)
cd("..")
Pkg.activate(".")

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

function run_tests(tag::String = "")
    runspec(rootpath; featurepath = featurepath, stepspath = stepspath,  parseoptions=p, execenvpath = configpath, tags=tag)
end

results = run_tests("not @ignore-typedb-core")
# results = run_tests("@failure")
# results = run_tests("@actual")

if !all(values(results))
    throw("TestSuite failed. Please review the results")
else
    @info "All tests passed. Well done! 😄 "
end
