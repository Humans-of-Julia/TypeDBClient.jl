# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.concept.type;
# 
# import grakn.client.api.Transaction;
# import grakn.client.api.concept.type.RelationType;
# import grakn.client.common.Label;
# import grakn.client.concept.thing.RelationImpl;
# import grakn.client.concept.thing.ThingImpl;
# import grakn.protocol.ConceptProto;
# 
# import java.util.stream.Stream;
# 
# import static grakn.client.common.RequestBuilder.Type.RelationType.createReq;
# import static grakn.client.common.RequestBuilder.Type.RelationType.getRelatesReq;
# import static grakn.client.common.RequestBuilder.Type.RelationType.setRelatesReq;
# import static grakn.client.common.RequestBuilder.Type.RelationType.unsetRelatesReq;
# 
# public class RelationTypeImpl extends ThingTypeImpl implements RelationType {
# 
#     RelationTypeImpl(String label, boolean isRoot) {
#         super(label, isRoot);
#     }
# 
#     public static RelationTypeImpl of(ConceptProto.Type typeProto) {
#         return new RelationTypeImpl(typeProto.getLabel(), typeProto.getRoot());
#     }
# 
#     @Override
#     public RelationTypeImpl.Remote asRemote(Transaction transaction) {
#         return new RelationTypeImpl.Remote(transaction, getLabel(), isRoot());
#     }
# 
#     @Override
#     public RelationTypeImpl asRelationType() {
#         return this;
#     }
# 
#     public static class Remote extends ThingTypeImpl.Remote implements RelationType.Remote {
# 
#         public Remote(Transaction transaction, Label label, boolean isRoot) {
#             super(transaction, label, isRoot);
#         }
# 
#         @Override
#         public RelationTypeImpl.Remote asRemote(Transaction transaction) {
#             return new RelationTypeImpl.Remote(transaction, getLabel(), isRoot());
#         }
# 
#         @Override
#         public final RelationImpl create() {
#             ConceptProto.Type.Res res = execute(createReq(getLabel()));
#             return RelationImpl.of(res.getRelationTypeCreateRes().getRelation());
#         }
# 
#         @Override
#         public final void setSupertype(RelationType relationType) {
#             super.setSupertype(relationType);
#         }
# 
#         @Override
#         public final RoleTypeImpl getRelates(String roleLabel) {
#             ConceptProto.RelationType.GetRelatesForRoleLabel.Res res =
#                     execute(getRelatesReq(getLabel(), roleLabel)).getRelationTypeGetRelatesForRoleLabelRes();
#             if (res.hasRoleType()) return RoleTypeImpl.of(res.getRoleType());
#             else return null;
#         }
# 
#         @Override
#         public final Stream<RoleTypeImpl> getRelates() {
#             return stream(getRelatesReq(getLabel()))
#                     .flatMap(rp -> rp.getRelationTypeGetRelatesResPart().getRolesList().stream())
#                     .map(RoleTypeImpl::of);
#         }
# 
#         @Override
#         public final void setRelates(String roleLabel) {
#             execute(setRelatesReq(getLabel(), roleLabel));
#         }
# 
#         @Override
#         public final void setRelates(String roleLabel, String overriddenLabel) {
#             execute(setRelatesReq(getLabel(), roleLabel, overriddenLabel));
#         }
# 
#         @Override
#         public final void unsetRelates(String roleLabel) {
#             execute(unsetRelatesReq(getLabel(), roleLabel));
#         }
# 
#         @Override
#         public final Stream<RelationTypeImpl> getSubtypes() {
#             return super.getSubtypes().map(ThingTypeImpl::asRelationType);
#         }
# 
#         @Override
#         public final Stream<RelationImpl> getInstances() {
#             return super.getInstances().map(ThingImpl::asRelation);
#         }
# 
#         @Override
#         public RelationTypeImpl.Remote asRelationType() {
#             return this;
#         }
#     }
# }
