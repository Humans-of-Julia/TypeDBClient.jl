
using Behavior
using Behavior.Gherkin
using TypeDBClient

rootpath = joinpath(@__DIR__, "test/behaviour")
featurepath = joinpath(@__DIR__,"test/behaviour/features/concept/thing")
stepspath = joinpath(@__DIR__,"test/behaviour/concept/thing")
configpath = joinpath(@__DIR__,"test/behaviour/config/ConfigEnvironment.jl")

p = ParseOptions(allow_any_step_order = true)

runspec(rootpath; featurepath = featurepath, stepspath = stepspath,  parseoptions=p, execenvpath = configpath, tags="not @ignore-typedb-core")

runspec(rootpath; featurepath = featurepath, stepspath = stepspath,  parseoptions=p, execenvpath = configpath, tags="@actual")


g = TypeDBClient

client = g.CoreClient("localhost",1729)
dbs = g.get_all_databases(client)
for db in dbs
   g.delete_database(client, db.name) 
end