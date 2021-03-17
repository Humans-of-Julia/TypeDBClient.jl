# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.logic;
# 
# import grakn.client.api.Transaction;
# import grakn.client.api.logic.LogicManager;
# import grakn.client.api.logic.Rule;
# import grakn.protocol.LogicProto;
# import grakn.protocol.TransactionProto;
# import graql.lang.pattern.Pattern;
# 
# import javax.annotation.Nullable;
# import java.util.stream.Stream;
# 
# import static grakn.client.common.RequestBuilder.LogicManager.getRuleReq;
# import static grakn.client.common.RequestBuilder.LogicManager.getRulesReq;
# import static grakn.client.common.RequestBuilder.LogicManager.putRuleReq;
# 
# public final class LogicManagerImpl implements LogicManager {
# 
#     private final Transaction.Extended transactionRPC;
# 
#     public LogicManagerImpl(Transaction.Extended transactionRPC) {
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
