# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.api.concept;
# 
# import grakn.client.api.concept.thing.Thing;
# import grakn.client.api.concept.type.AttributeType;
# import grakn.client.api.concept.type.EntityType;
# import grakn.client.api.concept.type.RelationType;
# import grakn.client.api.concept.type.ThingType;
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
