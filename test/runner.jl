using Base: runtests

using Behavior
using Behavior.Gherkin
using TypeDBClient

g = TypeDBClient
client = g.CoreClient("localhost",1729)

rootpath = joinpath(@__DIR__, "test/behaviour")
featurepath = joinpath(@__DIR__,"test/behaviour/features/concept/thing")
stepspath = joinpath(@__DIR__,"test/behaviour/concept/thing")
configpath = joinpath(@__DIR__,"test/behaviour/config/ConfigEnvironment.jl")

p = ParseOptions(allow_any_step_order = true)

# runspec(rootpath; featurepath = featurepath, stepspath = stepspath,  parseoptions=p, execenvpath = configpath, tags="not @ignore-typedb-core")


function run_tests()
    runspec(rootpath; featurepath = featurepath, stepspath = stepspath,  parseoptions=p, execenvpath = configpath, tags="@actual")
    # runspec(rootpath; featurepath = featurepath, stepspath = stepspath,  parseoptions=p, execenvpath = configpath)
    dbs = g.get_all_databases(g.CoreClient("localhost",1729))
    for db in dbs
        g.delete_database(client, db.name)
    end
end


run_tests()
