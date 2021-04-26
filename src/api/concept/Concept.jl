# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.api.concept;
# 
# import typedb.client.api.TypeDBTransaction;
# import typedb.client.api.concept.thing.Attribute;
# import typedb.client.api.concept.thing.Entity;
# import typedb.client.api.concept.thing.Relation;
# import typedb.client.api.concept.thing.Thing;
# import typedb.client.api.concept.type.AttributeType;
# import typedb.client.api.concept.type.EntityType;
# import typedb.client.api.concept.type.RelationType;
# import typedb.client.api.concept.type.RoleType;
# import typedb.client.api.concept.type.ThingType;
# import typedb.client.api.concept.type.Type;
# 
# import javax.annotation.CheckReturnValue;
# 
# public interface Concept {
# 
#     @CheckReturnValue
#     default boolean isType() {
#         return false;
#     }
# 
#     @CheckReturnValue
#     default boolean isThingType() {
#         return false;
#     }
# 
#     @CheckReturnValue
#     default boolean isEntityType() {
#         return false;
#     }
# 
#     @CheckReturnValue
#     default boolean isAttributeType() {
#         return false;
#     }
# 
#     @CheckReturnValue
#     default boolean isRelationType() {
#         return false;
#     }
# 
#     @CheckReturnValue
#     default boolean isRoleType() {
#         return false;
#     }
# 
#     @CheckReturnValue
#     default boolean isThing() {
#         return false;
#     }
# 
#     @CheckReturnValue
#     default boolean isEntity() {
#         return false;
#     }
# 
#     @CheckReturnValue
#     default boolean isAttribute() {
#         return false;
#     }
# 
#     @CheckReturnValue
#     default boolean isRelation() {
#         return false;
#     }
# 
#     @CheckReturnValue
#     Type asType();
# 
#     @CheckReturnValue
#     ThingType asThingType();
# 
#     @CheckReturnValue
#     EntityType asEntityType();
# 
#     @CheckReturnValue
#     AttributeType asAttributeType();
# 
#     @CheckReturnValue
#     RelationType asRelationType();
# 
#     @CheckReturnValue
#     RoleType asRoleType();
# 
#     @CheckReturnValue
#     Thing asThing();
# 
#     @CheckReturnValue
#     Entity asEntity();
# 
#     @CheckReturnValue
#     Attribute<?> asAttribute();
# 
#     @CheckReturnValue
#     Relation asRelation();
# 
#     @CheckReturnValue
#     Remote asRemote(TypeDBTransaction transaction);
# 
#     @CheckReturnValue
#     boolean isRemote();
# 
#     interface Remote extends Concept {
# 
#         void delete();
# 
#         @CheckReturnValue
#         boolean isDeleted();
# 
#         @Override
#         @CheckReturnValue
#         Type.Remote asType();
# 
#         @Override
#         @CheckReturnValue
#         ThingType.Remote asThingType();
# 
#         @Override
#         @CheckReturnValue
#         EntityType.Remote asEntityType();
# 
#         @Override
#         @CheckReturnValue
#         RelationType.Remote asRelationType();
# 
#         @Override
#         @CheckReturnValue
#         AttributeType.Remote asAttributeType();
# 
#         @Override
#         @CheckReturnValue
#         RoleType.Remote asRoleType();
# 
#         @Override
#         @CheckReturnValue
#         Thing.Remote asThing();
# 
#         @Override
#         @CheckReturnValue
#         Entity.Remote asEntity();
# 
#         @Override
#         @CheckReturnValue
#         Relation.Remote asRelation();
# 
#         @Override
#         @CheckReturnValue
#         Attribute.Remote<?> asAttribute();
#     }
# }
