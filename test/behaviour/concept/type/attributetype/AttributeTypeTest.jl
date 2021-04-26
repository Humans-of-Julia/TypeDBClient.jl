# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.test.behaviour.concept.type.attributetype;
# 
# import typedb.core.test.behaviour.BehaviourTest;
# import io.cucumber.junit.Cucumber;
# import io.cucumber.junit.CucumberOptions;
# import org.junit.runner.RunWith;
# 
# @RunWith(Cucumber.class)
# @CucumberOptions(
#         strict = true,
#         plugin = "pretty",
#         glue = "typedb.client.test.behaviour",
#         features = "external/typedblabs_behaviour/concept/type/attributetype.feature",
#         tags = "not @ignore and not @ignore-typedb"
# )
# public class AttributeTypeTest extends BehaviourTest {
#     // ATTENTION:
#     // When you click RUN from within this class through Intellij IDE, it will fail.
#     // You can fix it by doing:
#     //
#     // 1) Go to 'Run'
#     // 2) Select 'Edit Configurations...'
#     // 3) Select 'Bazel test AttributeTypeTest'
#     //
#     // 4) Ensure 'Target Expression' is set correctly: '//<this>/<package>/<name>:test'
#     //
#     // 5) Update 'Bazel Flags':
#     //    a) Remove the line that says: '--test_filter=typedb.core.*'
#     //    b) Use the following Bazel flags:
#     //       --cache_test_results=no : to make sure you're not using cache
#     //       --test_output=streamed : to make sure all output is printed
#     //       --subcommands : to print the low-level commands and execution paths
#     //       --sandbox_debug : to keep the sandbox not deleted after test runs
#     //       --spawn_strategy=standalone : if you're on Mac and the tests need permission to access filesystem
#     //
#     // 6) Hit the RUN button by selecting the test from the dropdown menu on the top bar
# }
