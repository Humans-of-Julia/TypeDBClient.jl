# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package application;
# 
# import grakn.client.Grakn;
# import grakn.client.api.GraknClient;
# import grakn.client.api.GraknSession;
# import grakn.client.api.GraknTransaction;
# import grakn.client.api.concept.type.ThingType;
# import org.junit.Test;
# 
# import java.util.stream.Collectors;
# 
# import static org.junit.Assert.assertEquals;
# import static org.junit.Assert.assertNotNull;
# 
# // TODO: implement more advanced tests using Graql queries once Grakn 2.0 supports them
# public class MavenApplicationTest {
# 
#     @Test
#     public void test() {
#         GraknClient client = Grakn.coreClient(Grakn.DEFAULT_ADDRESS);
#         client.databases().create("grakn");
#         GraknSession session = client.session("grakn", GraknSession.Type.DATA);
#         GraknTransaction tx = session.transaction(GraknTransaction.Type.WRITE);
#         ThingType root = tx.concepts().getRootThingType();
#         assertNotNull(root);
#         assertEquals(4, root.asRemote(tx).getSubtypes().collect(Collectors.toList()).size());
#         tx.close();
#         session.close();
#         client.close();
#     }
# }
