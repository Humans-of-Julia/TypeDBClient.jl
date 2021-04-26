# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.api.concept.type;
# 
# import typedb.client.api.TypeDBTransaction;
# import typedb.client.api.concept.thing.Thing;
# import typedb.client.api.concept.type.AttributeType.ValueType;
# 
# import javax.annotation.CheckReturnValue;
# import java.util.stream.Stream;
# 
# public interface ThingType extends Type {
# 
#     @Override
#     @CheckReturnValue
#     default boolean isThingType() {
#         return true;
#     }
# 
#     @Override
#     ThingType.Remote asRemote(TypeDBTransaction transaction);
# 
#     interface Remote extends Type.Remote, ThingType {
# 
#         @Override
#         @CheckReturnValue
#         ThingType getSupertype();
# 
#         @Override
#         @CheckReturnValue
#         Stream<? extends ThingType> getSupertypes();
# 
#         @Override
#         @CheckReturnValue
#         Stream<? extends ThingType> getSubtypes();
# 
#         @CheckReturnValue
#         Stream<? extends Thing> getInstances();
# 
#         void setAbstract();
# 
#         void unsetAbstract();
# 
#         void setPlays(RoleType roleType);
# 
#         void setPlays(RoleType roleType, RoleType overriddenType);
# 
#         void setOwns(AttributeType attributeType, AttributeType overriddenType, boolean isKey);
# 
#         void setOwns(AttributeType attributeType, AttributeType overriddenType);
# 
#         void setOwns(AttributeType attributeType, boolean isKey);
# 
#         void setOwns(AttributeType attributeType);
# 
#         @CheckReturnValue
#         Stream<? extends RoleType> getPlays();
# 
#         @CheckReturnValue
#         Stream<? extends AttributeType> getOwns();
# 
#         @CheckReturnValue
#         Stream<? extends AttributeType> getOwns(ValueType valueType);
# 
#         @CheckReturnValue
#         Stream<? extends AttributeType> getOwns(boolean keysOnly);
# 
#         @CheckReturnValue
#         Stream<? extends AttributeType> getOwns(ValueType valueType, boolean keysOnly);
# 
#         void unsetPlays(RoleType roleType);
# 
#         void unsetOwns(AttributeType attributeType);
#     }
# }
