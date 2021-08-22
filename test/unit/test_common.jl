using TypeDBClient: Label, scoped_name, RelationType
using TypeDBClient.typedb.protocol: _Type
using Test

@testset "Common" begin

@testset "Label" begin

    let x = Label("a")
        @test x.name == "a"
        @test x.scope === nothing
        @test scoped_name(x) == "a"
    end

    let y = Label("s", "a")
        @test y.name == "a"
        @test y.scope === "s"
        @test scoped_name(y) == "s:a"
    end

end

end # Common
