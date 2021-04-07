using Pretend: Pretend, apply
using Test

using GraknClient:
    AbstractCoreTransaction, RelationType, RoleType,
    as_remote, create, execute, instantiate

import GraknClient.grakn.protocol as Proto

# Turn on mocking framework
Pretend.activate()

# Fake types
struct FakeTransaction <: AbstractCoreTransaction end

@testset "Concepts" begin

@testset "RoleType" begin

    # Instantiating `RoleType` from ProtoBuf object
    let r = instantiate(Proto._Type(
            label = "b", root = false, encoding = Proto.Type_Encoding.ROLE_TYPE
    ))
        @test r.label.name == "b"
        @test r.label.scope === nothing
        @test r.is_root == false
    end
    let r = instantiate(Proto._Type(
            scope = "a", label = "b", root = false, encoding = Proto.Type_Encoding.ROLE_TYPE
    ))
        @test r.label.name == "b"
        @test r.label.scope === "a"
        @test r.is_root == false
    end
end

@testset "RelationType" begin

    # Instantiating `RelationType` from ProtoBuf object
    @test_nowarn instantiate(Proto._Type(
        label ="a", root = false, encoding = Proto.Type_Encoding.RELATION_TYPE
    ))

    # Create relation type.
    # Use Pretend framework to mock the `execute` function.
    let iid = [0x01], label = "a", root = true, encoding = Proto.Type_Encoding.RELATION_TYPE,
        fake_execute = (request::Proto.Transaction_Req) ->
            Proto.Type_Res(
                relation_type_create_res = Proto.RelationType_Create_Res(
                    relation = Proto.Thing(; iid,
                        _type = Proto._Type(; label, root, encoding)
                    )
                )
            )
        apply(execute => fake_execute) do
            relation_type = as_remote(RelationType(Label(label), root), FakeTransaction())
            @test_nowarn create(relation_type)
        end
    end

end

end
