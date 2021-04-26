using TypeDBClient: Label, scoped_name, RelationType, Remote
using TypeDBClient.typedb.protocol: _Type
using Test

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

@testset "RelationType" begin
    type_proto = _Type(label = "a", root = false)
    relation_type = RelationType(type_proto)
end
