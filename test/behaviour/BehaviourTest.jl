# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.core.test.behaviour;
# 
# import grakn.common.test.server.GraknRunner;
# import grakn.common.test.server.GraknSingleton;
# import org.junit.AfterClass;
# 
# public abstract class BehaviourTest {
#     // The following code is for running the Grakn Core distribution imported as an artifact.
#     // If you wish to debug locally against an instance of Grakn that is already running in
#     // the background, comment out all the code in this file that references 'runner'
#     // and update ConnectionSteps to connect to GraknClient.DEFAULT_URI.
# 
#     @AfterClass
#     public static void afterAll() {
#         GraknRunner server = GraknSingleton.getGraknRunner();
#         assert server != null;
#         server.stop();
#     }
# }
