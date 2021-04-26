# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package application;
# 
# import typedb.client.TypeDB;
# import typedb.client.api.TypeDBClient;
# import typedb.client.api.TypeDBSession;
# import typedb.client.api.TypeDBTransaction;
# import typedb.client.api.concept.type.ThingType;
# import org.junit.Test;
# 
# import java.util.stream.Collectors;
# 
# import static org.junit.Assert.assertEquals;
# import static org.junit.Assert.assertNotNull;
# 
# // TODO: implement more advanced tests using Graql queries once TypeDB 2.0 supports them
# public class MavenApplicationTest {
# 
#     @Test
#     public void test() {
#         TypeDBClient client = TypeDB.coreClient(TypeDB.DEFAULT_ADDRESS);
#         client.databases().create("typedb");
#         TypeDBSession session = client.session("typedb", TypeDBSession.Type.DATA);
#         TypeDBTransaction tx = session.transaction(TypeDBTransaction.Type.WRITE);
#         ThingType root = tx.concepts().getRootThingType();
#         assertNotNull(root);
#         assertEquals(4, root.asRemote(tx).getSubtypes().collect(Collectors.toList()).size());
#         tx.close();
#         session.close();
#         client.close();
#     }
# }
