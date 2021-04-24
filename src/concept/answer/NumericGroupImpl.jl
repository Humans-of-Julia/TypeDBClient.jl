# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.concept.answer;
# 
# import typedb.client.api.answer.Numeric;
# import typedb.client.api.answer.NumericGroup;
# import typedb.client.api.concept.Concept;
# import typedb.client.concept.ConceptImpl;
# import typedb.protocol.AnswerProto;
# 
# import java.util.Objects;
# 
# public class NumericGroupImpl implements NumericGroup {
# 
#     private final Concept owner;
#     private final Numeric numeric;
#     private final int hash;
# 
#     private NumericGroupImpl(Concept owner, Numeric numeric) {
#         this.owner = owner;
#         this.numeric = numeric;
#         this.hash = Objects.hash(this.owner, this.numeric);
#     }
# 
#     public static NumericGroup of(AnswerProto.NumericGroup numericGroup) {
#         return new NumericGroupImpl(ConceptImpl.of(numericGroup.getOwner()), NumericImpl.of(numericGroup.getNumber()));
#     }
# 
#     @Override
#     public Concept owner() {
#         return this.owner;
#     }
# 
#     @Override
#     public Numeric numeric() {
#         return this.numeric;
#     }
# 
#     @Override
#     public boolean equals(Object obj) {
#         if (obj == this) return true;
#         if (obj == null || getClass() != obj.getClass()) return false;
#         NumericGroupImpl a2 = (NumericGroupImpl) obj;
#         return this.owner.equals(a2.owner) &&
#                 this.numeric.equals(a2.numeric);
#     }
# 
#     @Override
#     public int hashCode() {
#         return hash;
#     }
# }
