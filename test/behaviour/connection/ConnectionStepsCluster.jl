# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.test.behaviour.connection;
# 
# import grakn.client.Grakn;
# import grakn.client.api.GraknClient;
# import grakn.common.test.server.GraknClusterRunner;
# import grakn.common.test.server.GraknSingleton;
# import io.cucumber.java.After;
# import io.cucumber.java.Before;
# import io.cucumber.java.en.Given;
# 
# import java.io.IOException;
# import java.util.concurrent.TimeoutException;
# 
# public class ConnectionStepsCluster extends ConnectionStepsBase {
#     private GraknClusterRunner server;
# 
#     @Override
#     void beforeAll() {
#         try {
#             server = new GraknClusterRunner();
#         } catch (InterruptedException | TimeoutException | IOException e) {
#             throw new RuntimeException(e);
#         }
#         server.start();
#         GraknSingleton.setGraknRunner(server);
#     }
# 
#     @Before
#     public synchronized void before() {
#         super.before();
#     }
# 
#     @After
#     public synchronized void after() {
#         super.after();
#     }
# 
#     @Override
#     GraknClient createGraknClient(String address) {
#         return Grakn.coreClient(address);
#     }
# 
#     @Given("connection has been opened")
#     public void connection_has_been_opened() {
#         super.connection_has_been_opened();
#     }
# 
#     @Given("connection does not have any database")
#     public void connection_does_not_have_any_database() {
#         super.connection_does_not_have_any_database();
#     }
# 
# }
