# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.api.concept;
# 
# import typedb.client.api.concept.thing.Thing;
# import typedb.client.api.concept.type.AttributeType;
# import typedb.client.api.concept.type.EntityType;
# import typedb.client.api.concept.type.RelationType;
# import typedb.client.api.concept.type.ThingType;
# 
# import javax.annotation.CheckReturnValue;
# import javax.annotation.Nullable;
# 
# public interface ConceptManager {
# 
#     @CheckReturnValue
#     ThingType getRootThingType();
# 
#     @CheckReturnValue
#     EntityType getRootEntityType();
# 
#     @CheckReturnValue
#     RelationType getRootRelationType();
# 
#     @CheckReturnValue
#     AttributeType getRootAttributeType();
# 
#     @Nullable
#     @CheckReturnValue
#     ThingType getThingType(String label);
# 
#     @Nullable
#     @CheckReturnValue
#     Thing getThing(String iid);
# 
#     @Nullable
#     @CheckReturnValue
#     EntityType getEntityType(String label);
# 
#     EntityType putEntityType(String label);
# 
#     @Nullable
#     @CheckReturnValue
#     RelationType getRelationType(String label);
# 
#     RelationType putRelationType(String label);
# 
#     @Nullable
#     @CheckReturnValue
#     AttributeType getAttributeType(String label);
# 
#     AttributeType putAttributeType(String label, AttributeType.ValueType valueType);
# }
