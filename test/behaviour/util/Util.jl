# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.test.behaviour.util;
# 
# import static org.junit.Assert.assertTrue;
# import static org.junit.Assert.fail;
# 
# public class Util {
# 
#     public static void assertThrows(Runnable function) {
#         try {
#             function.run();
#             fail();
#         } catch (RuntimeException e) {
#             assertTrue(true);
#         }
#     }
# 
#     public static void assertThrowsWithMessage(Runnable function, String message) {
#         try {
#             function.run();
#             fail();
#         } catch (RuntimeException e) {
#             System.out.println(e.toString());
#             assert (e.toString().contains(message));
#         }
#     }
# }
