# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

mutable struct LogicManagerImpl
end

#
# package typedb.client.logic;
#
# import typedb.client.api.TypeDBTransaction;
# import typedb.client.api.logic.LogicManager;
# import typedb.client.api.logic.Rule;
# import typedb.protocol.LogicProto;
# import typedb.protocol.TransactionProto;
# import graql.lang.pattern.Pattern;
#
# import javax.annotation.Nullable;
# import java.util.stream.Stream;
#
# import static typedb.client.common.rpc.RequestBuilder.LogicManager.getRuleReq;
# import static typedb.client.common.rpc.RequestBuilder.LogicManager.getRulesReq;
# import static typedb.client.common.rpc.RequestBuilder.LogicManager.putRuleReq;
#
# public final class LogicManagerImpl implements LogicManager {
#
#     private final TypeDBTransaction.Extended transactionRPC;
#
#     public LogicManagerImpl(TypeDBTransaction.Extended transactionRPC) {
#         this.transactionRPC = transactionRPC;
#     }
#
#     @Override
#     @Nullable
#     public Rule getRule(String label) {
#         LogicProto.LogicManager.GetRule.Res res = execute(getRuleReq(label)).getGetRuleRes();
#         switch (res.getResCase()) {
#             case RULE:
#                 return RuleImpl.of(res.getRule());
#             default:
#             case RES_NOT_SET:
#                 return null;
#         }
#     }
#
#     @Override
#     public Stream<RuleImpl> getRules() {
#         return stream(getRulesReq()).flatMap(res -> res.getGetRulesResPart().getRulesList().stream()).map(RuleImpl::of);
#     }
#
#     @Override
#     public Rule putRule(String label, Pattern when, Pattern then) {
#         LogicProto.LogicManager.Res res = execute(putRuleReq(label, when.toString(), then.toString()));
#         return RuleImpl.of(res.getPutRuleRes().getRule());
#     }
#
#     private LogicProto.LogicManager.Res execute(TransactionProto.Transaction.Req.Builder req) {
#         return transactionRPC.execute(req).getLogicManagerRes();
#     }
#
#     private Stream<LogicProto.LogicManager.ResPart> stream(TransactionProto.Transaction.Req.Builder req) {
#         return transactionRPC.stream(req).map(TransactionProto.Transaction.ResPart::getLogicManagerResPart);
#     }
# }
