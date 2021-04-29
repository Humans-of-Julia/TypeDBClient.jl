# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

mutable struct CoreDatabase <: AbstractCoreDatabaseManager
    name::String
end

function schema_database(db::T, core_client::R) where {T<:AbstractCoreDatabaseManager, R<:AbstractCoreClient}
    return database_schema(core_client.core_stub, gRPCController(), DatabaseRequestBuilder.schema_req(db.name)).schema
end


#
# package typedb.client.core;
#
# import typedb.client.api.database.Database;
# import typedb.client.common.rpc.TypeDBStub;
#
# import static typedb.client.common.rpc.RequestBuilder.Core.Database.deleteReq;
# import static typedb.client.common.rpc.RequestBuilder.Core.Database.schemaReq;
# import static typedb.client.core.CoreDatabaseManager.nonNull;
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
#     private TypeDBStub.Core stub() {
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
