using GraknClient
using Test

@testset "GraknClient" begin
include("unit/test_common.jl")
include("unit/test_request_builder.jl")
include("unit/test_concepts.jl")

end
