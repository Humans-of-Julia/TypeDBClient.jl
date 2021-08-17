using Pretend: Pretend, apply, @mockable
using Test

using TypeDBClient:
    AbstractCoreTransaction, EntityType, RelationType, RoleType, AttributeType,
    Label, AbstractEntity, AbstractRoleType,
    ConceptMap,
    as_remote, create, execute, instantiate, proto, is_writable, is_keyable

import TypeDBClient.typedb.protocol as Proto
import TypeDBClient: execute

# reduce the writing
g = TypeDBClient

# Turn on mocking framework
Pretend.activate()
@mockable execute(trans::AbstractCoreTransaction, request::Proto.ProtoType) = g.execute(trans, request)

# Fake types
struct FakeTransaction <: AbstractCoreTransaction end

@testset "Concepts" begin

@testset "Instantiating concepts" begin

    # Instantiate a thing e.g. Entity
    let c = Proto.Concept(
            thing = Proto.Thing(
                _type = Proto._Type(
                    root = false,
                    label = "a",
                    encoding = Proto.Type_Encoding.ENTITY_TYPE),
                iid = [0x01]))
        entity = @test_nowarn instantiate(c)
        @test entity isa AbstractEntity
        @test entity.iid == "01"
        @test entity.type == EntityType(Label("a"), false)
    end

    # Instantiate a type e.g. RoleType
    let c = Proto.Concept(
            _type = Proto._Type(
                root = false,
                label = "a",
                encoding = Proto.Type_Encoding.ROLE_TYPE))
        type = @test_nowarn instantiate(c)
        @test type isa AbstractRoleType
        @test type.label == Label("a")
        @test type.is_root == false
    end
end

@testset "Concept maps" begin
    let cm = @test_nowarn ConceptMap(
            Proto.ConceptMap(
                map = Dict(
                    "hey" => Proto.Concept(
                        thing = Proto.Thing(
                            _type = Proto._Type(
                                    root = false,
                                    label = "a",
                                    encoding = Proto.Type_Encoding.ENTITY_TYPE
                            ),
                            iid = [0x01])))))
        entity = @test_nowarn cm["hey"]
        @test entity isa AbstractEntity
        @test entity.iid == "01"
        @test entity.type == EntityType(Label("a"), false)
    end
end

@testset "RoleType" begin

    # Instantiating `RoleType` from ProtoBuf object
    let r = instantiate(Proto._Type(
            label = "b", root = false, encoding = Proto.Type_Encoding.ROLE_TYPE))
        @test r.label.name == "b"
        @test r.label.scope === nothing
        @test r.is_root == false
    end

    let r = instantiate(Proto._Type(
            scope = "a", label = "b", root = false, encoding = Proto.Type_Encoding.ROLE_TYPE))
        @test r.label.name == "b"
        @test r.label.scope === "a"
        @test r.is_root == false
    end
end

@testset "RelationType" begin

    # Instantiating `RelationType` from ProtoBuf object
    @test_nowarn instantiate(Proto._Type(
        label ="a", root = false, encoding = Proto.Type_Encoding.RELATION_TYPE))

    # Create relation type.
    # Use Pretend framework to mock the `execute` function.
    label = "Relation"
    iid = g.bytes(uuid4())
    root = false
    encoding = Proto.Type_Encoding.RELATION_TYPE

    fake_execute = (trans::AbstractCoreTransaction , request::Proto.ProtoType) ->
                    Proto.Transaction_Res(type_res = Proto.Type_Res(
                        relation_type_create_res = Proto.RelationType_Create_Res(
                            relation = Proto.Thing(; iid,
                                _type = Proto._Type(; label, root, encoding)))))
    apply(execute => fake_execute) do
        relation_type = as_remote(RelationType(g.Label(label), root), FakeTransaction())
        @test_nowarn create(relation_type)
    end;
end

@testset "AttributeType" begin
    let t = AttributeType(g.Label("a"), true, VALUE_TYPE.BOOLEAN)
        @info proto(t)
        @test proto(t) == Proto._Type(label="a", encoding=Proto.Type_Encoding.ATTRIBUTE_TYPE)
        @test is_writable(t) == true
        @test is_keyable(t) == false
    end
    let t = AttributeType(g.Label("a"), true, VALUE_TYPE.LONG)
        @test proto(t) == Proto._Type(label="a", encoding=Proto.Type_Encoding.ATTRIBUTE_TYPE)
        @test is_writable(t) == true
        @test is_keyable(t) == true
    end
    let t = AttributeType(g.Label("a"), true, VALUE_TYPE.OBJECT)
        @test proto(t) == Proto._Type(label="a", encoding=Proto.Type_Encoding.ATTRIBUTE_TYPE)
        @test is_writable(t) == false
        @test is_keyable(t) == false
    end
end

end
