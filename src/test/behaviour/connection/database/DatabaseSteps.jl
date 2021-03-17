# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.test.behaviour.connection.database;
# 
# import grakn.client.api.database.Database;
# import io.cucumber.java.en.Then;
# import io.cucumber.java.en.When;
# 
# import java.util.List;
# import java.util.Set;
# import java.util.concurrent.CompletableFuture;
# import java.util.stream.Collectors;
# 
# import static grakn.client.test.behaviour.connection.ConnectionStepsBase.THREAD_POOL_SIZE;
# import static grakn.client.test.behaviour.connection.ConnectionStepsBase.client;
# import static grakn.client.test.behaviour.connection.ConnectionStepsBase.threadPool;
# import static grakn.common.collection.Collections.list;
# import static grakn.common.collection.Collections.set;
# import static org.junit.Assert.assertEquals;
# import static org.junit.Assert.assertFalse;
# import static org.junit.Assert.assertTrue;
# import static org.junit.Assert.fail;
# 
# public class DatabaseSteps {
#     @When("connection create database: {word}")
#     public void connection_create_database(String name) {
#         connection_create_databases(list(name));
#     }
# 
#     @When("connection create database(s):")
#     public void connection_create_databases(List<String> names) {
#         for (String name : names) {
#             client.databases().create(name);
#         }
#     }
# 
#     @When("connection create databases in parallel:")
#     public void connection_create_databases_in_parallel(List<String> names) {
#         assertTrue(THREAD_POOL_SIZE >= names.size());
# 
#         CompletableFuture[] creations = names.stream()
#                 .map(name -> CompletableFuture.runAsync(() -> client.databases().create(name), threadPool))
#                 .toArray(CompletableFuture[]::new);
# 
#         CompletableFuture.allOf(creations).join();
#     }
# 
#     @When("connection delete database: {word}")
#     public void connection_delete_database(String name) {
#         connection_delete_databases(list(name));
#     }
# 
#     @When("connection delete database(s):")
#     public void connection_delete_databases(List<String> names) {
#         for (String databaseName : names) {
#             client.databases().get(databaseName).delete();
#         }
#     }
# 
#     @Then("connection delete database; throws exception: {word}")
#     public void connection_delete_database_throws_exception(String name) {
#         connection_delete_databases_throws_exception(list(name));
#     }
# 
#     @Then("connection delete database(s); throws exception")
#     public void connection_delete_databases_throws_exception(List<String> names) {
#         for (String databaseName : names) {
#             try {
#                 client.databases().get(databaseName).delete();
#                 fail();
#             } catch (Exception e) {
#                 // successfully failed
#             }
#         }
#     }
# 
#     @When("connection delete databases in parallel:")
#     public void connection_delete_databases_in_parallel(List<String> names) {
#         assertTrue(THREAD_POOL_SIZE >= names.size());
# 
#         CompletableFuture[] deletions = names.stream()
#                 .map(name -> CompletableFuture.runAsync(() -> client.databases().get(name).delete(), threadPool))
#                 .toArray(CompletableFuture[]::new);
# 
#         CompletableFuture.allOf(deletions).join();
#     }
# 
#     @When("connection has database: {word}")
#     public void connection_has_database(String name) {
#         connection_has_databases(list(name));
#     }
# 
#     @Then("connection has database(s):")
#     public void connection_has_databases(List<String> names) {
#         assertEquals(set(names), client.databases().all().stream().map(Database::name).collect(Collectors.toSet()));
#     }
# 
#     @Then("connection does not have database: {word}")
#     public void connection_does_not_have_database(String name) {
#         connection_does_not_have_databases(list(name));
#     }
# 
# 
#     @Then("connection does not have database(s):")
#     public void connection_does_not_have_databases(List<String> names) {
#         Set<String> databases = client.databases().all().stream().map(Database::name).collect(Collectors.toSet());
#         for (String databaseName : names) {
#             assertFalse(databases.contains(databaseName));
#         }
#     }
# }