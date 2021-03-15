# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.concept.thing;
# 
# import grakn.client.api.Transaction;
# import grakn.client.api.concept.thing.Entity;
# import grakn.client.concept.type.EntityTypeImpl;
# import grakn.common.collection.Bytes;
# import grakn.protocol.ConceptProto;
# 
# public class EntityImpl extends ThingImpl implements Entity {
# 
#     private final EntityTypeImpl type;
# 
#     EntityImpl(String iid, EntityTypeImpl type) {
#         super(iid);
#         this.type = type;
#     }
# 
#     public static EntityImpl of(ConceptProto.Thing protoThing) {
#         return new EntityImpl(Bytes.bytesToHexString(protoThing.getIid().toByteArray()), EntityTypeImpl.of(protoThing.getType()));
#     }
# 
#     @Override
#     public EntityTypeImpl getType() {
#         return type;
#     }
# 
#     @Override
#     public EntityImpl.Remote asRemote(Transaction transaction) {
#         return new EntityImpl.Remote(transaction, getIID(), type);
#     }
# 
#     @Override
#     public final EntityImpl asEntity() {
#         return this;
#     }
# 
#     public static class Remote extends ThingImpl.Remote implements Entity.Remote {
# 
#         private final EntityTypeImpl type;
# 
#         public Remote(Transaction transaction, String iid, EntityTypeImpl type) {
#             super(transaction, iid);
#             this.type = type;
#         }
# 
#         @Override
#         public EntityImpl.Remote asRemote(Transaction transaction) {
#             return new EntityImpl.Remote(transaction, getIID(), type);
#         }
# 
#         @Override
#         public EntityTypeImpl getType() {
#             return type;
#         }
# 
#         @Override
#         public final EntityImpl.Remote asEntity() {
#             return this;
#         }
#     }
# }
