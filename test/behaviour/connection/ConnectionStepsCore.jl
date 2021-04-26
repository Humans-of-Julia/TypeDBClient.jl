# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.test.behaviour.connection;
# 
# import typedb.client.TypeDB;
# import typedb.client.api.TypeDBClient;
# import typedb.common.test.server.TypeDBRunner;
# import typedb.common.test.server.TypeDBSingleton;
# import io.cucumber.java.After;
# import io.cucumber.java.Before;
# import io.cucumber.java.en.Given;
# 
# import java.io.IOException;
# import java.util.concurrent.TimeoutException;
# 
# public class ConnectionStepsCore extends ConnectionStepsBase {
#     private TypeDBRunner server;
# 
#     @Override
#     void beforeAll() {
#         try {
#             server = new TypeDBRunner();
#         } catch (InterruptedException | TimeoutException | IOException e) {
#             throw new RuntimeException(e);
#         }
#         server.start();
#         TypeDBSingleton.setTypeDBRunner(server);
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
#     TypeDBClient createTypeDBClient(String address) {
#         return TypeDB.coreClient(address);
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
