# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.concept;
# 
# import grakn.client.api.Transaction;
# import grakn.client.api.concept.ConceptManager;
# import grakn.client.api.concept.thing.Thing;
# import grakn.client.api.concept.type.AttributeType;
# import grakn.client.api.concept.type.EntityType;
# import grakn.client.api.concept.type.RelationType;
# import grakn.client.api.concept.type.ThingType;
# import grakn.client.common.Proto;
# import grakn.client.concept.thing.ThingImpl;
# import grakn.client.concept.type.AttributeTypeImpl;
# import grakn.client.concept.type.EntityTypeImpl;
# import grakn.client.concept.type.RelationTypeImpl;
# import grakn.client.concept.type.ThingTypeImpl;
# import grakn.protocol.ConceptProto;
# import grakn.protocol.TransactionProto;
# import graql.lang.common.GraqlToken;
# 
# import javax.annotation.Nullable;
# 
# public final class ConceptManagerImpl implements ConceptManager {
# 
#     private final Transaction.Extended transactionExt;
# 
#     public ConceptManagerImpl(Transaction.Extended transactionExt) {
#         this.transactionExt = transactionExt;
#     }
# 
#     @Override
#     public ThingType getRootThingType() {
#         return getThingType(GraqlToken.Type.THING.toString());
#     }
# 
#     @Override
#     public EntityType getRootEntityType() {
#         return getEntityType(GraqlToken.Type.ENTITY.toString());
#     }
# 
#     @Override
#     public RelationType getRootRelationType() {
#         return getRelationType(GraqlToken.Type.RELATION.toString());
#     }
# 
#     @Override
#     public AttributeType getRootAttributeType() {
#         return getAttributeType(GraqlToken.Type.ATTRIBUTE.toString());
#     }
# 
#     @Override
#     public EntityType putEntityType(String label) {
#         ConceptProto.ConceptManager.Res res = execute(Proto.ConceptManager.putEntityType(label));
#         return EntityTypeImpl.of(res.getPutEntityTypeRes().getEntityType());
#     }
# 
#     @Override
#     @Nullable
#     public EntityType getEntityType(String label) {
#         ThingType thingType = getThingType(label);
#         if (thingType != null && thingType.isEntityType()) return thingType.asEntityType();
#         else return null;
#     }
# 
#     @Override
#     public RelationType putRelationType(String label) {
#         ConceptProto.ConceptManager.Res res = execute(Proto.ConceptManager.putRelationType(label));
#         return RelationTypeImpl.of(res.getPutRelationTypeRes().getRelationType());
#     }
# 
#     @Override
#     @Nullable
#     public RelationType getRelationType(String label) {
#         ThingType thingType = getThingType(label);
#         if (thingType != null && thingType.isRelationType()) return thingType.asRelationType();
#         else return null;
#     }
# 
#     @Override
#     public AttributeType putAttributeType(String label, AttributeType.ValueType valueType) {
#         ConceptProto.ConceptManager.Res res = execute(Proto.ConceptManager.putAttributeType(label, valueType.proto()));
#         return AttributeTypeImpl.of(res.getPutAttributeTypeRes().getAttributeType());
#     }
# 
#     @Override
#     @Nullable
#     public AttributeType getAttributeType(String label) {
#         ThingType thingType = getThingType(label);
#         if (thingType != null && thingType.isAttributeType()) return thingType.asAttributeType();
#         else return null;
#     }
# 
#     @Override
#     @Nullable
#     public ThingType getThingType(String label) {
#         ConceptProto.ConceptManager.Res response = execute(Proto.ConceptManager.getThingType(label));
#         switch (response.getGetThingTypeRes().getResCase()) {
#             case THING_TYPE:
#                 return ThingTypeImpl.of(response.getGetThingTypeRes().getThingType());
#             default:
#             case RES_NOT_SET:
#                 return null;
#         }
#     }
# 
#     @Override
#     @Nullable
#     public Thing getThing(String iid) {
#         ConceptProto.ConceptManager.Res response = execute(Proto.ConceptManager.getThing(iid));
#         switch (response.getGetThingRes().getResCase()) {
#             case THING:
#                 return ThingImpl.of(response.getGetThingRes().getThing());
#             default:
#             case RES_NOT_SET:
#                 return null;
#         }
#     }
# 
#     private ConceptProto.ConceptManager.Res execute(TransactionProto.Transaction.Req.Builder req) {
#         return transactionExt.execute(req).getConceptManagerRes();
#     }
# }
