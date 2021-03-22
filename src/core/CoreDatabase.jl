# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.core;
# 
# import grakn.client.api.database.Database;
# import grakn.client.common.rpc.GraknStub;
# 
# import static grakn.client.common.rpc.RequestBuilder.Core.Database.deleteReq;
# import static grakn.client.common.rpc.RequestBuilder.Core.Database.schemaReq;
# import static grakn.client.core.CoreDatabaseManager.nonNull;
# 
# public class CoreDatabase implements Database {
# 
#     private final String name;
#     private final CoreDatabaseManager databaseMgr;
# 
#     public CoreDatabase(CoreDatabaseManager databaseMgr, String name) {
#         this.databaseMgr = databaseMgr;
#         this.name = nonNull((name));
#     }
# 
#     private GraknStub.Core stub() {
#         return databaseMgr.stub();
#     }
# 
#     @Override
#     public String name() {
#         return name;
#     }
# 
#     @Override
#     public String schema() {
#         return stub().databaseSchema(schemaReq(name)).getSchema();
#     }
# 
#     @Override
#     public void delete() {
#         stub().databaseDelete(deleteReq(name));
#     }
# 
#     @Override
#     public String toString() {
#         return name;
#     }
# }
