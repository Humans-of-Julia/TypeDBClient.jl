# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

mutable struct LogicManager <:AbstractLogicManager
    _transation::Union{T,Nothing} where {T<:AbstractTransaction}
end

LogicManager() = LogicManager(nothing)

#     def put_rule(self, label: str, when: str, then: str):
#         req = logic_proto.LogicManager.Req()
#         put_rule_req = logic_proto.LogicManager.PutRule.Req()
#         put_rule_req.label = label
#         put_rule_req.when = when
#         put_rule_req.then = then
#         req.put_rule_req.CopyFrom(put_rule_req)
#         res = self._execute(req)
#         return Rule._of(res.put_rule_res.rule)

#     def get_rule(self, label: str):
#         req = logic_proto.LogicManager.Req()
#         get_rule_req = logic_proto.LogicManager.GetRule.Req()
#         get_rule_req.label = label
#         req.get_rule_req.CopyFrom(get_rule_req)

#         response = self._execute(req)
#         return Rule._of(response.get_rule_res.rule) if response.get_rule_res.WhichOneof("res") == "rule" else None

#     def get_rules(self):
#         method = logic_proto.LogicManager.Req()
#         method.get_rules_req.CopyFrom(logic_proto.LogicManager.GetRules.Req())
#         return self._rule_stream(method, lambda res: res.get_rules_res.rules)

#     def _execute(self, request: logic_proto.LogicManager.Req):
#         req = transaction_proto.Transaction.Req()
#         req.logic_manager_req.CopyFrom(request)
#         return self._transaction._execute(req).logic_manager_res

#     def _rule_stream(self, method: logic_proto.LogicManager.Req, rule_list_getter: Callable[[logic_proto.LogicManager.Res], List[logic_proto.Rule]]):
#         request = transaction_proto.Transaction.Req()
#         request.logic_manager_req.CopyFrom(method)
#         return map(Rule._of, self._transaction._stream(request, lambda res: rule_list_getter(res.logic_manager_res)))
