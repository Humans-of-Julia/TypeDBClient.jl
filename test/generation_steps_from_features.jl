using Behavior: suggestmissingsteps, ParseOptions

parseoptions = ParseOptions(allow_any_step_order=true)
suggestmissingsteps(joinpath(@__DIR__,
    "behaviour/features/connection/database.feature"),
    joinpath(@__DIR__, "behaviour/connection/database"),
    parseoptions=parseoptions)
