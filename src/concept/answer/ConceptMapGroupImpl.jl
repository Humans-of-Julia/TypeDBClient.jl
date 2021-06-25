# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.concept.answer;
# 
# import typedb.client.api.answer.ConceptMap;
# import typedb.client.api.answer.ConceptMapGroup;
# import typedb.client.api.concept.Concept;
# import typedb.client.concept.ConceptImpl;
# import typedb.protocol.AnswerProto;
# 
# import java.util.List;
# import java.util.Objects;
# 
# import static java.util.stream.Collectors.toList;
# 
# public class ConceptMapGroupImpl implements ConceptMapGroup {
#     private final Concept owner;
#     private final List<ConceptMap> conceptMaps;
#     private final int hash;
# 
#     public ConceptMapGroupImpl(Concept owner, List<ConceptMap> conceptMaps) {
#         this.owner = owner;
#         this.conceptMaps = conceptMaps;
#         this.hash = Objects.hash(this.owner, this.conceptMaps);
#     }
# 
#     public static ConceptMapGroup of(AnswerProto.ConceptMapGroup e) {
#         Concept owner = ConceptImpl.of(e.getOwner());
#         List<ConceptMap> conceptMaps = e.getConceptMapsList().stream().map(ConceptMapImpl::of).collect(toList());
#         return new ConceptMapGroupImpl(owner, conceptMaps);
#     }
# 
#     @Override
#     public Concept owner() {
#         return this.owner;
#     }
# 
#     @Override
#     public List<ConceptMap> conceptMaps() {
#         return this.conceptMaps;
#     }
# 
#     @Override
#     public boolean equals(Object obj) {
#         if (obj == this) return true;
#         if (obj == null || getClass() != obj.getClass()) return false;
#         ConceptMapGroupImpl a2 = (ConceptMapGroupImpl) obj;
#         return this.owner.equals(a2.owner) &&
#                 this.conceptMaps.equals(a2.conceptMaps);
#     }
# 
#     @Override
#     public int hashCode() {
#         return hash;
#     }
# }