# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.core;
# 
# import grakn.client.api.database.Database;
# import grakn.client.common.Proto;
# import grakn.protocol.GraknGrpc;
# 
# import static grakn.client.core.CoreDatabaseManager.nonNull;
# 
# public class CoreDatabase implements Database {
# 
#     private final String name;
#     private final CoreClient client;
#     private final GraknGrpc.GraknBlockingStub blockingGrpcStub;
# 
#     public CoreDatabase(CoreDatabaseManager databaseManager, String name) {
#         this.name = nonNull((name));
#         this.client = databaseManager.client();
#         this.blockingGrpcStub = databaseManager.blockingGrpcStub();
#     }
# 
#     @Override
#     public String name() {
#         return name;
#     }
# 
#     @Override
#     public void delete() {
#         client.call(() -> blockingGrpcStub.databaseDelete(Proto.Database.delete(name)));
#     }
# 
#     @Override
#     public String toString() {
#         return name;
#     }
# }
