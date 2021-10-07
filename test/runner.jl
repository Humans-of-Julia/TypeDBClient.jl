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

const test_features = [
                       "@attribute_type",
                       "@entity_type",
                       "@attribute",
                       "@entity",
                       "@relation",
                       "@relation_type"
                       ]

results = Dict{String, Bool}()
# result = run_tests("not @ignore-typedb-core")
# result = run_tests("@failure")
# result = run_tests("@actual")

for a_test in test_features
    res_test = run_tests(a_test)
    if !res_test
        @info "$a_test failed"
        results[a_test] = false
    else
        results[a_test] = true
    end
end

!all(values(results)) && @info "Second try to fullfill all tests"
for (a_test, success) in results
    if !success
        res_test = run_tests(a_test)
        if !res_test
            @info "$a_test second time failed"
            results[a_test] = false
        else
            results[a_test] = true
        end
    end
end


@info "All $(length(results)) Tests succeeded: $(all(values(results)))"

# if !result
#     throw("TestSuite failed. Please proof the results")
# else
#     @info "Well done!"
# end
