# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.test.behaviour.concept.thing.entity;
# 
# import grakn.client.api.concept.thing.Attribute;
# import grakn.client.api.concept.thing.Entity;
# import grakn.client.common.Label;
# import io.cucumber.java.en.Then;
# import io.cucumber.java.en.When;
# 
# import java.time.LocalDateTime;
# 
# import static grakn.client.test.behaviour.concept.thing.ThingSteps.get;
# import static grakn.client.test.behaviour.concept.thing.ThingSteps.put;
# import static grakn.client.test.behaviour.connection.ConnectionStepsBase.tx;
# import static grakn.client.test.behaviour.util.Util.assertThrows;
# import static org.junit.Assert.assertEquals;
# import static org.junit.Assert.assertTrue;
# 
# @SuppressWarnings("CheckReturnValue")
# public class EntitySteps {
# 
#     @When("{var} = entity\\( ?{type_label} ?) create new instance")
#     public void entity_type_create_new_instance(String var, String typeLabel) {
#         put(var, tx().concepts().getEntityType(typeLabel).asRemote(tx()).create());
#     }
# 
#     @When("entity\\( ?{type_label} ?) create new instance; throws exception")
#     public void entity_type_create_new_instance_throws_exception(String typeLabel) {
#         assertThrows(() -> tx().concepts().getEntityType(typeLabel).asRemote(tx()).create());
#     }
# 
#     @When("{var} = entity\\( ?{type_label} ?) create new instance with key\\( ?{type_label} ?): {int}")
#     public void entity_type_create_new_instance_with_key(String var, String type, String keyType, int keyValue) {
#         Attribute.Long key = tx().concepts().getAttributeType(keyType).asLong().asRemote(tx()).put(keyValue);
#         Entity entity = tx().concepts().getEntityType(type).asRemote(tx()).create();
#         entity.asRemote(tx()).setHas(key);
#         put(var, entity);
#     }
# 
#     @When("{var} = entity\\( ?{type_label} ?) create new instance with key\\( ?{type_label} ?): {word}")
#     public void entity_type_create_new_instance_with_key(String var, String type, String keyType, String keyValue) {
#         Attribute.String key = tx().concepts().getAttributeType(keyType).asString().asRemote(tx()).put(keyValue);
#         Entity entity = tx().concepts().getEntityType(type).asRemote(tx()).create();
#         entity.asRemote(tx()).setHas(key);
#         put(var, entity);
#     }
# 
#     @When("{var} = entity\\( ?{type_label} ?) create new instance with key\\( ?{type_label} ?): {datetime}")
#     public void entity_type_create_new_instance_with_key(String var, String type, String keyType, LocalDateTime keyValue) {
#         Attribute.DateTime key = tx().concepts().getAttributeType(keyType).asDateTime().asRemote(tx()).put(keyValue);
#         Entity entity = tx().concepts().getEntityType(type).asRemote(tx()).create();
#         entity.asRemote(tx()).setHas(key);
#         put(var, entity);
#     }
# 
#     @When("{var} = entity\\( ?{type_label} ?) get instance with key\\( ?{type_label} ?): {long}")
#     public void entity_type_get_instance_with_key(String var1, String type, String keyType, long keyValue) {
#         put(var1, tx().concepts().getAttributeType(keyType).asLong().asRemote(tx()).get(keyValue).asRemote(tx()).getOwners()
#                 .filter(owner -> owner.getType().getLabel().equals(Label.of(type))).findFirst().orElse(null));
#     }
# 
#     @When("{var} = entity\\( ?{type_label} ?) get instance with key\\( ?{type_label} ?): {word}")
#     public void entity_type_get_instance_with_key(String var1, String type, String keyType, String keyValue) {
#         put(var1, tx().concepts().getAttributeType(keyType).asString().asRemote(tx()).get(keyValue).asRemote(tx()).getOwners()
#                 .filter(owner -> owner.getType().getLabel().equals(Label.of(type))).findFirst().orElse(null));
#     }
# 
#     @When("{var} = entity\\( ?{type_label} ?) get instance with key\\( ?{type_label} ?): {datetime}")
#     public void entity_type_get_instance_with_key(String var1, String type, String keyType, LocalDateTime keyValue) {
#         put(var1, tx().concepts().getAttributeType(keyType).asDateTime().asRemote(tx()).get(keyValue).asRemote(tx()).getOwners()
#                 .filter(owner -> owner.getType().getLabel().equals(Label.of(type))).findFirst().orElse(null));
#     }
# 
#     @Then("entity\\( ?{type_label} ?) get instances contain: {var}")
#     public void entity_type_get_instances_contain(String typeLabel, String var) {
#         assertTrue(tx().concepts().getEntityType(typeLabel).asRemote(tx()).getInstances().anyMatch(i -> i.equals(get(var))));
#     }
# 
#     @Then("entity\\( ?{type_label} ?) get instances is empty")
#     public void entity_type_get_instances_is_empty(String typeLabel) {
#         assertEquals(0, tx().concepts().getEntityType(typeLabel).asRemote(tx()).getInstances().count());
#     }
# }
