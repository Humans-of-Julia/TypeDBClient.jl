# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.concept.type;
# 
# import grakn.client.api.GraknTransaction;
# import grakn.client.api.concept.type.RelationType;
# import grakn.client.api.concept.type.RoleType;
# import grakn.client.common.Label;
# import grakn.client.common.RequestBuilder;
# import grakn.protocol.ConceptProto;
# 
# import javax.annotation.Nullable;
# import java.util.stream.Stream;
# 
# import static grakn.client.common.RequestBuilder.Type.RoleType.getPlayersReq;
# import static grakn.client.common.RequestBuilder.Type.RoleType.getRelationTypesReq;
# 
# public class RoleTypeImpl extends TypeImpl implements RoleType {
# 
#     RoleTypeImpl(String scope, String label, boolean root) {
#         super(Label.of(scope, label), root);
#     }
# 
#     public static RoleTypeImpl of(ConceptProto.Type typeProto) {
#         return new RoleTypeImpl(typeProto.getScope(), typeProto.getLabel(), typeProto.getRoot());
#     }
# 
#     public static ConceptProto.Type protoRoleTypes(RoleType roleType) {
#         return RequestBuilder.Type.RoleType.protoRoleType(roleType.getLabel(), TypeImpl.encoding(roleType));
#     }
# 
#     @Override
#     public RoleTypeImpl.Remote asRemote(GraknTransaction transaction) {
#         return new RoleTypeImpl.Remote(transaction, getLabel(), isRoot());
#     }
# 
#     @Override
#     public RoleTypeImpl asRoleType() {
#         return this;
#     }
# 
#     public static class Remote extends TypeImpl.Remote implements RoleType.Remote {
# 
#         public Remote(GraknTransaction transaction, Label label, boolean isRoot) {
#             super(transaction, label, isRoot);
#         }
# 
#         @Nullable
#         @Override
#         public RoleTypeImpl getSupertype() {
#             TypeImpl supertype = super.getSupertype();
#             return supertype != null ? supertype.asRoleType() : null;
#         }
# 
#         @Override
#         public final Stream<RoleTypeImpl> getSupertypes() {
#             return super.getSupertypes().map(TypeImpl::asRoleType);
#         }
# 
#         @Override
#         public final Stream<RoleTypeImpl> getSubtypes() {
#             return super.getSubtypes().map(TypeImpl::asRoleType);
#         }
# 
#         @Override
#         public RoleType.Remote asRemote(GraknTransaction transaction) {
#             return new RoleTypeImpl.Remote(transaction, getLabel(), isRoot());
#         }
# 
#         @Nullable
#         @Override
#         public final RelationType getRelationType() {
#             assert getLabel().scope().isPresent();
#             return transactionRPC.concepts().getRelationType(getLabel().scope().get());
#         }
# 
#         @Override
#         public final Stream<RelationTypeImpl> getRelationTypes() {
#             return stream(getRelationTypesReq(getLabel()))
#                     .flatMap(rp -> rp.getRoleTypeGetRelationTypesResPart().getRelationTypesList().stream())
#                     .map(RelationTypeImpl::of);
#         }
# 
#         @Override
#         public final Stream<ThingTypeImpl> getPlayers() {
#             return stream(getPlayersReq(getLabel()))
#                     .flatMap(rp -> rp.getRoleTypeGetPlayersResPart().getThingTypesList().stream())
#                     .map(ThingTypeImpl::of);
#         }
# 
#         @Override
#         public final boolean isDeleted() {
#             return getRelationType() == null ||
#                     getRelationType().asRemote(transactionRPC).getRelates(getLabel().name()) == null;
#         }
# 
#         @Override
#         public RoleTypeImpl.Remote asRoleType() {
#             return this;
#         }
#     }
# }
