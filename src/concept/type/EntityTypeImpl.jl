# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.concept.type;
# 
# import grakn.client.api.Transaction;
# import grakn.client.api.concept.type.EntityType;
# import grakn.client.common.Label;
# import grakn.client.concept.thing.EntityImpl;
# import grakn.client.concept.thing.ThingImpl;
# import grakn.protocol.ConceptProto;
# 
# import java.util.stream.Stream;
# 
# import static grakn.client.common.RequestBuilder.Type.EntityType.createReq;
# 
# public class EntityTypeImpl extends ThingTypeImpl implements EntityType {
# 
#     EntityTypeImpl(String label, boolean isRoot) {
#         super(label, isRoot);
#     }
# 
#     public static EntityTypeImpl of(ConceptProto.Type typeProto) {
#         return new EntityTypeImpl(typeProto.getLabel(), typeProto.getRoot());
#     }
# 
#     @Override
#     public EntityTypeImpl.Remote asRemote(Transaction transaction) {
#         return new EntityTypeImpl.Remote(transaction, getLabel(), isRoot());
#     }
# 
#     @Override
#     public EntityTypeImpl asEntityType() {
#         return this;
#     }
# 
#     public static class Remote extends ThingTypeImpl.Remote implements EntityType.Remote {
# 
#         Remote(Transaction transaction, Label label, boolean isRoot) {
#             super(transaction, label, isRoot);
#         }
# 
#         @Override
#         public EntityTypeImpl.Remote asRemote(Transaction transaction) {
#             return new EntityTypeImpl.Remote(transaction, getLabel(), isRoot());
#         }
# 
#         @Override
#         public final EntityImpl create() {
#             return EntityImpl.of(execute(createReq(getLabel())).getEntityTypeCreateRes().getEntity());
#         }
# 
#         @Override
#         public final void setSupertype(EntityType entityType) {
#             super.setSupertype(entityType);
#         }
# 
#         @Override
#         public final Stream<EntityTypeImpl> getSubtypes() {
#             return super.getSubtypes().map(ThingTypeImpl::asEntityType);
#         }
# 
#         @Override
#         public final Stream<EntityImpl> getInstances() {
#             return super.getInstances().map(ThingImpl::asEntity);
#         }
# 
#         @Override
#         public EntityTypeImpl.Remote asEntityType() {
#             return this;
#         }
#     }
# }
