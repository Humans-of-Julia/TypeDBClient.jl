using GraknClient: RoleType
import GraknClient.grakn.protocol as Proto

@testset "Concepts" begin

let r = RoleType(Proto._Type(label = "b", root = false))
    @test r.label.name == "b"
    @test r.label.scope === nothing
    @test r.is_root == false
end

let r = RoleType(Proto._Type(scope = "a", label = "b", root = false))
    @test r.label.name == "b"
    @test r.label.scope === "a"
    @test r.is_root == false
end

end
