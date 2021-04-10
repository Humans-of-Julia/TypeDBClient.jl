import GraknClient.grakn.protocol as Proto
using GraknClient: Label, bytes
using UUIDs: uuid4

@testset "RequestBuilder" begin

no_option = Proto.Options()

let b = GraknClient.DatabaseManagerRequestBuilder
    @test b.create_req("a").name == "a"
    @test b.contains_req("a").name == "a"
    @test_nowarn b.all_req()
end

let b = GraknClient.DatabaseRequestBuilder
    @test b.schema_req("a").name == "a"
    @test b.delete_req("a").name == "a"
end

let b = GraknClient.SessionRequestBuilder
    let r = b.open_req("a", Int32(0), no_option)
        @test r.database == "a"
        @test r._type == Int32(0)
        @test r.options == no_option
    end
    @test b.pulse_req([0x01]).session_id == [0x01]
end

let b = GraknClient.TransactionRequestBuilder
    let ts = [Proto.Transaction_Req()]
        @test b.client_msg(ts).reqs == ts
    end
    let id = uuid4(), r = b.stream_req(id)
        @test r.req_id == string(id)
        @test hasproperty(r, :stream_req)
    end
    let id = [0x01], ty = Int32(0), options = no_option, ms = 0,
            r = b.open_req(id, ty, options, ms)
        @test r.open_req.session_id == id
        @test r.open_req._type == ty
        @test r.open_req.options == no_option
        @test r.open_req.network_latency_millis == ms
    end
end

let b = GraknClient.QueryManagerRequestBuilder
    for f in (
        :define_req, :undefine_req, :match_req, :match_aggregate_req,
        :match_group_req, :match_group_aggregate_req,
        :insert_req, :delete_req, :update_req,
    )
        func = getfield(b, f)
        let q = func("a").query_manager_req
            underlying_req = getproperty(q, f)
            @test underlying_req.query == "a"
        end
    end
end

let b = GraknClient.ConceptManagerRequestBuilder
    @test b.put_entity_type_req("a").concept_manager_req.put_entity_type_req.label == "a"
    @test b.put_relation_type_req("a").concept_manager_req.put_relation_type_req.label == "a"
    @test b.put_attribute_type_req("a", Int32(0)).concept_manager_req.put_attribute_type_req.label == "a"
    @test b.put_attribute_type_req("a", Int32(0)).concept_manager_req.put_attribute_type_req.value_type == Int32(0)
    @test b.get_thing_type_req("a").concept_manager_req.get_thing_type_req.label == "a"
    @test b.get_thing_req("a").concept_manager_req.get_thing_req.iid == bytes("a")
end

let b = GraknClient.LogicManagerRequestBuilder
    let r = b.put_rule_req("a", "b", "c")
        @test r.logic_manager_req.put_rule_req.label == "a"
        @test r.logic_manager_req.put_rule_req.when == "b"
        @test r.logic_manager_req.put_rule_req.then == "c"
    end
    @test b.get_rule_req("a").logic_manager_req.get_rule_req.label == "a"
    @test_nowarn b.get_rules_req()
end

let b = GraknClient.TypeRequestBuilder
    @test hasproperty(b.is_abstract_req(Label("a")).type_req, :type_is_abstract_req)
    @test b.is_abstract_req(Label("s","a")).type_req.scope == "s"
    @test b.is_abstract_req(Label("a")).type_req.label == "a"
    @test !hasproperty(b.is_abstract_req(Label("a")).type_req, :scope)
end

end # RequestBuilder
