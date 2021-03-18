# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.cluster;
# 
# import grakn.client.api.GraknOptions;
# import grakn.client.api.GraknSession;
# import grakn.client.api.GraknTransaction;
# import grakn.client.api.database.Database;
# import grakn.client.core.CoreClient;
# import grakn.client.core.CoreSession;
# import org.slf4j.Logger;
# import org.slf4j.LoggerFactory;
# 
# public class ClusterSession implements GraknSession {
#     private static final Logger LOG = LoggerFactory.getLogger(GraknSession.class);
#     private final ClusterClient clusterClient;
#     private final GraknOptions.Cluster options;
#     private CoreClient coreClient;
#     private CoreSession coreSession;
# 
#     public ClusterSession(ClusterClient clusterClient, String serverAddress, String database, Type type, GraknOptions.Cluster options) {
#         this.clusterClient = clusterClient;
#         this.coreClient = clusterClient.coreClient(serverAddress);
#         LOG.debug("Opening a session to '{}'", serverAddress);
#         this.coreSession = coreClient.session(database, type, options);
#         this.options = options;
#     }
# 
#     @Override
#     public GraknTransaction transaction(GraknTransaction.Type type) {
#         return transaction(type, GraknOptions.cluster());
#     }
# 
#     @Override
#     public GraknTransaction transaction(GraknTransaction.Type type, GraknOptions options) {
#         GraknOptions.Cluster clusterOpt = options.asCluster();
#         if (clusterOpt.readAnyReplica().isPresent() && clusterOpt.readAnyReplica().get()) {
#             return transactionAnyReplica(type, clusterOpt);
#         } else {
#             return transactionPrimaryReplica(type, options);
#         }
#     }
# 
#     private GraknTransaction transactionPrimaryReplica(GraknTransaction.Type type, GraknOptions options) {
#         return transactionFailsafeTask(type, options).runPrimaryReplica();
#     }
# 
#     private GraknTransaction transactionAnyReplica(GraknTransaction.Type type, GraknOptions.Cluster options) {
#         return transactionFailsafeTask(type, options).runAnyReplica();
#     }
# 
#     private FailsafeTask<GraknTransaction> transactionFailsafeTask(GraknTransaction.Type type, GraknOptions options) {
#         return new FailsafeTask<GraknTransaction>(clusterClient, database().name()) {
# 
#             @Override
#             GraknTransaction run(ClusterDatabase.Replica replica) {
#                 return coreSession.transaction(type, options);
#             }
# 
#             @Override
#             GraknTransaction rerun(ClusterDatabase.Replica replica) {
#                 if (coreSession != null) coreSession.close();
#                 coreClient = clusterClient.coreClient(replica.address());
#                 coreSession = coreClient.session(database().name(), ClusterSession.this.type(), ClusterSession.this.options());
#                 return coreSession.transaction(type, options);
#             }
#         };
#     }
# 
#     @Override
#     public GraknSession.Type type() {
#         return coreSession.type();
#     }
# 
#     @Override
#     public GraknOptions.Cluster options() {
#         return options;
#     }
# 
#     @Override
#     public boolean isOpen() {
#         return coreSession.isOpen();
#     }
# 
#     @Override
#     public void close() {
#         coreSession.close();
#     }
# 
#     @Override
#     public Database database() {
#         return coreSession.database();
#     }
# }
