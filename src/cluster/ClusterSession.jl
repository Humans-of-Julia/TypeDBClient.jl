# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.cluster;
# 
# import typedb.client.api.TypeDBOptions;
# import typedb.client.api.TypeDBSession;
# import typedb.client.api.TypeDBTransaction;
# import typedb.client.api.database.Database;
# import typedb.client.core.CoreClient;
# import typedb.client.core.CoreSession;
# import org.slf4j.Logger;
# import org.slf4j.LoggerFactory;
# 
# public class ClusterSession implements TypeDBSession {
#     private static final Logger LOG = LoggerFactory.getLogger(TypeDBSession.class);
#     private final ClusterClient clusterClient;
#     private final TypeDBOptions.Cluster options;
#     private CoreClient coreClient;
#     private CoreSession coreSession;
# 
#     public ClusterSession(ClusterClient clusterClient, String serverAddress, String database, Type type, TypeDBOptions.Cluster options) {
#         this.clusterClient = clusterClient;
#         this.coreClient = clusterClient.coreClient(serverAddress);
#         LOG.debug("Opening a session to '{}'", serverAddress);
#         this.coreSession = coreClient.session(database, type, options);
#         this.options = options;
#     }
# 
#     @Override
#     public TypeDBTransaction transaction(TypeDBTransaction.Type type) {
#         return transaction(type, TypeDBOptions.cluster());
#     }
# 
#     @Override
#     public TypeDBTransaction transaction(TypeDBTransaction.Type type, TypeDBOptions options) {
#         TypeDBOptions.Cluster clusterOpt = options.asCluster();
#         if (clusterOpt.readAnyReplica().isPresent() && clusterOpt.readAnyReplica().get()) {
#             return transactionAnyReplica(type, clusterOpt);
#         } else {
#             return transactionPrimaryReplica(type, options);
#         }
#     }
# 
#     private TypeDBTransaction transactionPrimaryReplica(TypeDBTransaction.Type type, TypeDBOptions options) {
#         return transactionFailsafeTask(type, options).runPrimaryReplica();
#     }
# 
#     private TypeDBTransaction transactionAnyReplica(TypeDBTransaction.Type type, TypeDBOptions.Cluster options) {
#         return transactionFailsafeTask(type, options).runAnyReplica();
#     }
# 
#     private FailsafeTask<TypeDBTransaction> transactionFailsafeTask(TypeDBTransaction.Type type, TypeDBOptions options) {
#         return new FailsafeTask<TypeDBTransaction>(clusterClient, database().name()) {
# 
#             @Override
#             TypeDBTransaction run(ClusterDatabase.Replica replica) {
#                 return coreSession.transaction(type, options);
#             }
# 
#             @Override
#             TypeDBTransaction rerun(ClusterDatabase.Replica replica) {
#                 if (coreSession != null) coreSession.close();
#                 coreClient = clusterClient.coreClient(replica.address());
#                 coreSession = coreClient.session(database().name(), ClusterSession.this.type(), ClusterSession.this.options());
#                 return coreSession.transaction(type, options);
#             }
#         };
#     }
# 
#     @Override
#     public TypeDBSession.Type type() {
#         return coreSession.type();
#     }
# 
#     @Override
#     public TypeDBOptions.Cluster options() {
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
