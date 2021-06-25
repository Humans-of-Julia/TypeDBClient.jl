# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.logic;
# 
# import typedb.client.api.TypeDBTransaction;
# import typedb.client.api.logic.Rule;
# import typedb.client.common.exception.TypeDBClientException;
# import typedb.protocol.LogicProto;
# import graql.lang.Graql;
# import graql.lang.pattern.Conjunction;
# import graql.lang.pattern.Pattern;
# import graql.lang.pattern.variable.ThingVariable;
# 
# import java.util.Objects;
# 
# import static typedb.client.common.exception.ErrorMessage.Concept.MISSING_LABEL;
# import static typedb.client.common.exception.ErrorMessage.Concept.MISSING_TRANSACTION;
# import static typedb.client.common.rpc.RequestBuilder.Rule.deleteReq;
# import static typedb.client.common.rpc.RequestBuilder.Rule.setLabelReq;
# import static typedb.common.util.Objects.className;
# 
# public class RuleImpl implements Rule {
# 
#     private final String label;
#     private final Conjunction<? extends Pattern> when;
#     private final ThingVariable<?> then;
#     private final int hash;
# 
#     RuleImpl(String label, Conjunction<? extends Pattern> when, ThingVariable<?> then) {
#         if (label == null || label.isEmpty()) throw new TypeDBClientException(MISSING_LABEL);
#         this.label = label;
#         this.when = when;
#         this.then = then;
#         this.hash = Objects.hash(this.label);
#     }
# 
#     public static RuleImpl of(LogicProto.Rule ruleProto) {
#         return new RuleImpl(
#                 ruleProto.getLabel(),
#                 Graql.parsePattern(ruleProto.getWhen()).asConjunction(),
#                 Graql.parseVariable(ruleProto.getThen()).asThing()
#         );
#     }
# 
#     @Override
#     public String getLabel() {
#         return label;
#     }
# 
#     @Override
#     public Conjunction<? extends Pattern> getWhen() {
#         return when;
#     }
# 
#     @Override
#     public ThingVariable<?> getThen() {
#         return then;
#     }
# 
#     @Override
#     public RuleImpl.Remote asRemote(TypeDBTransaction transaction) {
#         return new RuleImpl.Remote(transaction, getLabel(), getWhen(), getThen());
#     }
# 
#     @Override
#     public boolean isRemote() {
#         return false;
#     }
# 
#     @Override
#     public String toString() {
#         return className(this.getClass()) + "[label: " + label + "]";
#     }
# 
#     @Override
#     public boolean equals(Object o) {
#         if (this == o) return true;
#         if (o == null || getClass() != o.getClass()) return false;
# 
#         RuleImpl that = (RuleImpl) o;
#         return this.label.equals(that.label);
#     }
# 
#     @Override
#     public int hashCode() {
#         return hash;
#     }
# 
#     public static class Remote implements Rule.Remote {
# 
#         final TypeDBTransaction.Extended transactionRPC;
#         private String label;
#         private final Conjunction<? extends Pattern> when;
#         private final ThingVariable<?> then;
#         private final int hash;
# 
#         public Remote(TypeDBTransaction transaction, String label, Conjunction<? extends Pattern> when, ThingVariable<?> then) {
#             if (transaction == null) throw new TypeDBClientException(MISSING_TRANSACTION);
#             if (label == null || label.isEmpty()) throw new TypeDBClientException(MISSING_LABEL);
#             this.transactionRPC = (TypeDBTransaction.Extended) transaction;
#             this.label = label;
#             this.when = when;
#             this.then = then;
#             this.hash = Objects.hash(transaction, label);
#         }
# 
#         @Override
#         public String getLabel() {
#             return label;
#         }
# 
#         @Override
#         public Conjunction<? extends Pattern> getWhen() {
#             return when;
#         }
# 
#         @Override
#         public ThingVariable<?> getThen() {
#             return then;
#         }
# 
#         @Override
#         public void setLabel(String newLabel) {
#             transactionRPC.execute(setLabelReq(label, newLabel));
#             this.label = newLabel;
#         }
# 
#         @Override
#         public void delete() {
#             transactionRPC.execute(deleteReq(label));
#         }
# 
#         @Override
#         public final boolean isDeleted() {
#             return transactionRPC.logic().getRule(label) != null;
#         }
# 
#         @Override
#         public Remote asRemote(TypeDBTransaction transaction) {
#             return new RuleImpl.Remote(transaction, getLabel(), getWhen(), getThen());
#         }
# 
#         @Override
#         public boolean isRemote() {
#             return true;
#         }
# 
#         @Override
#         public String toString() {
#             return className(this.getClass()) + "[label: " + label + "]";
#         }
# 
#         @Override
#         public boolean equals(Object o) {
#             if (this == o) return true;
#             if (o == null || getClass() != o.getClass()) return false;
# 
#             RuleImpl.Remote that = (RuleImpl.Remote) o;
#             return this.transactionRPC.equals(that.transactionRPC) && this.label.equals(that.label);
#         }
# 
#         @Override
#         public int hashCode() {
#             return hash;
#         }
#     }
# }