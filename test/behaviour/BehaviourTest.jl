# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.core.test.behaviour;
# 
# import typedb.common.test.server.TypeDBRunner;
# import typedb.common.test.server.TypeDBSingleton;
# import org.junit.AfterClass;
# 
# public abstract class BehaviourTest {
#     // The following code is for running the TypeDB Core distribution imported as an artifact.
#     // If you wish to debug locally against an instance of TypeDB that is already running in
#     // the background, comment out all the code in this file that references 'runner'
#     // and update ConnectionSteps to connect to TypeDBClient.DEFAULT_URI.
# 
#     @AfterClass
#     public static void afterAll() {
#         TypeDBRunner server = TypeDBSingleton.getTypeDBRunner();
#         assert server != null;
#         server.stop();
#     }
# }
