# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.cluster;
# 
# import grakn.client.api.database.Database;
# import grakn.client.api.database.DatabaseManager;
# import grakn.client.common.GraknClientException;
# import grakn.client.core.CoreDatabaseManager;
# import grakn.protocol.cluster.DatabaseProto;
# 
# import java.util.List;
# import java.util.Map;
# import java.util.stream.Collectors;
# 
# import static grakn.client.common.ErrorMessage.Client.CLUSTER_ALL_NODES_FAILED;
# 
# public class ClusterDatabaseManager implements DatabaseManager.Cluster {
#     private final Map<String, CoreDatabaseManager> databaseManagers;
#     private final ClusterClient client;
# 
#     public ClusterDatabaseManager(ClusterClient client, Map<String, CoreDatabaseManager> databaseManagers) {
#         this.client = client;
#         this.databaseManagers = databaseManagers;
#     }
# 
#     @Override
#     public boolean contains(String name) {
#         StringBuilder errors = new StringBuilder();
#         for (String address : databaseManagers.keySet()) {
#             try {
#                 return databaseManagers.get(address).contains(name);
#             } catch (GraknClientException e) {
#                 errors.append("- ").append(address).append(": ").append(e).append("\n");
#             }
#         }
#         throw new GraknClientException(CLUSTER_ALL_NODES_FAILED.message(errors.toString()));
#     }
# 
#     @Override
#     public void create(String name) {
#         for (CoreDatabaseManager databaseManager : databaseManagers.values()) {
#             if (!databaseManager.contains(name)) {
#                 databaseManager.create(name);
#             }
#         }
#     }
# 
#     @Override
#     public Database.Cluster get(String name) {
#         StringBuilder errors = new StringBuilder();
#         for (String address : databaseManagers.keySet()) {
#             try {
#                 DatabaseProto.Database.Get.Res res = client.coreClient(address).call(
#                         () -> client.graknClusterRPC(address).databaseGet(DatabaseProto.Database.Get.Req.newBuilder().setName(name).build())
#                 );
#                 return ClusterDatabase.of(res.getDatabase(), this);
#             } catch (GraknClientException e) {
#                 errors.append("- ").append(address).append(": ").append(e).append("\n");
#             }
#         }
#         throw new GraknClientException(CLUSTER_ALL_NODES_FAILED.message(errors.toString()));
#     }
# 
#     @Override
#     public List<Database.Cluster> all() {
#         StringBuilder errors = new StringBuilder();
#         for (String address : databaseManagers.keySet()) {
#             try {
#                 DatabaseProto.Database.All.Res res = client.coreClient(address).call(() -> client.graknClusterRPC(address)
#                         .databaseAll(DatabaseProto.Database.All.Req.getDefaultInstance()));
#                 return res.getDatabasesList().stream().map(db -> ClusterDatabase.of(db, this)).collect(Collectors.toList());
#             } catch (GraknClientException e) {
#                 errors.append("- ").append(address).append(": ").append(e).append("\n");
#             }
#         }
#         throw new GraknClientException(CLUSTER_ALL_NODES_FAILED.message(errors.toString()));
#     }
# 
#     Map<String, CoreDatabaseManager> databaseManagers() {
#         return databaseManagers;
#     }
# }
