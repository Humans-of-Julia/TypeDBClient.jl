
using Behavior
using Behavior.Gherkin

rootpath = "/Users/ulzee/dev/GraknClient.jl/test/behaviour"
featurepath = "/Users/ulzee/dev/GraknClient.jl/test/behaviour/features/connection"
stepspath = "/Users/ulzee/dev/GraknClient.jl/test/behaviour/features/steps"

p = ParseOptions(allow_any_step_order = true)

runspec(rootpath; featurepath = featurepath, stepspath = stepspath, parseoptions=p)