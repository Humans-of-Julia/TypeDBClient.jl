# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.cluster;
# 
# import typedb.client.common.exception.TypeDBClientException;
# import typedb.protocol.ClusterDatabaseProto;
# import io.grpc.StatusRuntimeException;
# import org.slf4j.Logger;
# import org.slf4j.LoggerFactory;
# 
# import java.util.ArrayList;
# import java.util.List;
# 
# import static typedb.client.common.exception.ErrorMessage.Client.CLUSTER_REPLICA_NOT_PRIMARY;
# import static typedb.client.common.exception.ErrorMessage.Client.CLUSTER_UNABLE_TO_CONNECT;
# import static typedb.client.common.exception.ErrorMessage.Client.UNABLE_TO_CONNECT;
# import static typedb.client.common.exception.ErrorMessage.Internal.UNEXPECTED_INTERRUPTION;
# import static typedb.client.common.rpc.RequestBuilder.Cluster.DatabaseManager.getReq;
# 
# abstract class FailsafeTask<RESULT> {
# 
#     private static final Logger LOG = LoggerFactory.getLogger(FailsafeTask.class);
#     private static final int PRIMARY_REPLICA_TASK_MAX_RETRIES = 10;
#     private static final int FETCH_REPLICAS_MAX_RETRIES = 10;
#     private static final int WAIT_FOR_PRIMARY_REPLICA_SELECTION_MS = 2000;
# 
#     private final ClusterClient client;
#     private final String database;
# 
#     FailsafeTask(ClusterClient client, String database) {
#         this.client = client;
#         this.database = database;
#     }
# 
#     abstract RESULT run(ClusterDatabase.Replica replica);
# 
#     RESULT rerun(ClusterDatabase.Replica replica) {
#         return run(replica);
#     }
# 
#     RESULT runPrimaryReplica() {
#         if (!client.databaseByName().containsKey(database)
#                 || !client.databaseByName().get(database).primaryReplica().isPresent()) {
#             seekPrimaryReplica();
#         }
#         ClusterDatabase.Replica replica = client.databaseByName().get(database).primaryReplica().get();
#         int retries = 0;
#         while (true) {
#             try {
#                 return retries == 0 ? run(replica) : rerun(replica);
#             } catch (TypeDBClientException e) {
#                 if (CLUSTER_REPLICA_NOT_PRIMARY.equals(e.getErrorMessage())
#                         || UNABLE_TO_CONNECT.equals(e.getErrorMessage())) {
#                     LOG.debug("Unable to open a session or transaction, retrying in 2s...", e);
#                     waitForPrimaryReplicaSelection();
#                     replica = seekPrimaryReplica();
#                 } else throw e;
#             }
#             if (++retries > PRIMARY_REPLICA_TASK_MAX_RETRIES) throw clusterNotAvailableException();
#         }
#     }
# 
#     RESULT runAnyReplica() {
#         ClusterDatabase databaseClusterRPC = client.databaseByName().get(database);
#         if (databaseClusterRPC == null) databaseClusterRPC = fetchDatabaseReplicas();
# 
#         // Try the preferred secondary replica first, then go through the others
#         List<ClusterDatabase.Replica> replicas = new ArrayList<>();
#         replicas.add(databaseClusterRPC.preferredReplica());
#         for (ClusterDatabase.Replica replica : databaseClusterRPC.replicas()) {
#             if (!replica.isPreferred()) replicas.add(replica);
#         }
# 
#         int retries = 0;
#         for (ClusterDatabase.Replica replica : replicas) {
#             try {
#                 return retries == 0 ? run(replica) : rerun(replica);
#             } catch (TypeDBClientException e) {
#                 if (UNABLE_TO_CONNECT.equals(e.getErrorMessage())) {
#                     LOG.debug("Unable to open a session or transaction to " + replica.id() +
#                                       ". Attempting next replica.", e);
#                 } else {
#                     throw e;
#                 }
#             }
#             retries++;
#         }
#         throw clusterNotAvailableException();
#     }
# 
#     private ClusterDatabase.Replica seekPrimaryReplica() {
#         int retries = 0;
#         while (retries < FETCH_REPLICAS_MAX_RETRIES) {
#             ClusterDatabase databaseClusterRPC = fetchDatabaseReplicas();
#             if (databaseClusterRPC.primaryReplica().isPresent()) {
#                 return databaseClusterRPC.primaryReplica().get();
#             } else {
#                 waitForPrimaryReplicaSelection();
#                 retries++;
#             }
#         }
#         throw clusterNotAvailableException();
#     }
# 
#     private ClusterDatabase fetchDatabaseReplicas() {
#         for (String serverAddress : client.clusterMembers()) {
#             try {
#                 LOG.debug("Fetching replica info from {}", serverAddress);
#                 ClusterDatabaseProto.ClusterDatabaseManager.Get.Res res = client.stub(serverAddress).databasesGet(getReq(database));
#                 ClusterDatabase databaseClusterRPC = ClusterDatabase.of(res.getDatabase(), client.databases());
#                 client.databaseByName().put(database, databaseClusterRPC);
#                 return databaseClusterRPC;
#             } catch (TypeDBClientException e) {
#                 if (e.getErrorMessage().equals(UNABLE_TO_CONNECT)) {
#                     LOG.debug("Failed to fetch replica info for database '" + database + "' from " +
#                             serverAddress + ". Attempting next server.", e);
#                 } else {
#                     throw e;
#                 }
#             }
#         }
#         throw clusterNotAvailableException();
#     }
# 
#     private void waitForPrimaryReplicaSelection() {
#         try {
#             Thread.sleep(WAIT_FOR_PRIMARY_REPLICA_SELECTION_MS);
#         } catch (InterruptedException e) {
#             throw new TypeDBClientException(UNEXPECTED_INTERRUPTION);
#         }
#     }
# 
#     private TypeDBClientException clusterNotAvailableException() {
#         return new TypeDBClientException(CLUSTER_UNABLE_TO_CONNECT, String.join(",", client.clusterMembers()));
#     }
# }
