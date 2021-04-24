# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

mutable struct CoreDatabaseManager <: AbstractCoreDatabaseManager

end

function get_database(client::T, name::String)::CoreDatabase where {T<:AbstractCoreClient}
    isempty(name) && throw(GraknClientException(CLIENT_MISSING_DB_NAME))
    if contains_database(client, name)
        return CoreDatabase(name)
    else
        throw(GraknClientException(CLIENT_DB_DOES_NOT_EXIST, name))
    end
end

function contains_database(client::T, name::String) where {T<:AbstractCoreClient}
    isempty(name) && throw(GraknClientException(CLIENT_MISSING_DB_NAME))
    let db = DatabaseManagerRequestBuilder
        req_result, status = databases_contains(client.core_stub.blockingStub, gRPCController() , db.contains_req(name))
        return grpc_result_or_error(req_result, status, result->result.contains)
    end
end

function get_all_databases(client::T)::Vector{CoreDatabase} where {T<:AbstractCoreClient}
    let db = DatabaseManagerRequestBuilder
        req_result, status = databases_all(client.core_stub.blockingStub, gRPCController(), db.all_req())
        return grpc_result_or_error(req_result, status, result -> [CoreDatabase(db_name) for db_name in result.names])
    end
end

function create_database(client::T, name::String) where {T<:AbstractCoreClient}
    isempty(name) && throw(GraknClientException(CLIENT_MISSING_DB_NAME))
    let db = DatabaseManagerRequestBuilder
        req_result, status =  databases_create(client.core_stub.blockingStub, gRPCController(), db.create_req(name))
        return grpc_result_or_error(req_result, status, result->true)
    end
end

function delete_database(client::T, name::String) where {T<:AbstractCoreClient}
    db = get_database(client, name)
    let db = DatabaseRequestBuilder
        req_result, status =  database_delete(client.core_stub.blockingStub, gRPCController(), db.delete_req(name))
        return grpc_result_or_error(req_result, status, result->true)
    end
end
# package grakn.client.core;
#
# import grakn.client.api.database.Database;
# import grakn.client.api.database.DatabaseManager;
# import grakn.client.common.exception.GraknClientException;
# import grakn.client.common.rpc.GraknStub;
#
# import java.util.List;
#
# import static grakn.client.common.exception.ErrorMessage.Client.DB_DOES_NOT_EXIST;
# import static grakn.client.common.exception.ErrorMessage.Client.MISSING_DB_NAME;
# import static grakn.client.common.rpc.RequestBuilder.Core.DatabaseManager.allReq;
# import static grakn.client.common.rpc.RequestBuilder.Core.DatabaseManager.containsReq;
# import static grakn.client.common.rpc.RequestBuilder.Core.DatabaseManager.createReq;
# import static java.util.stream.Collectors.toList;
#
# public class CoreDatabaseManager implements DatabaseManager {
#
#     private final CoreClenit client;
#
#     public CoreDatabaseManager(CoreClient client) {
#         this.client = client;
#     }
#
#     @Override
#     public Database get(String name) {
#         if (contains(name)) return new CoreDatabase(this, name);
#         else throw new GraknClientException(DB_DOES_NOT_EXIST, name);
#     }
#
#     @Override
#     public boolean contains(String name) {
#         return stub().databasesContains(containsReq(nonNull(name))).getContains();
#     }
#
#     @Override
#     public void create(String name) {
#         stub().databasesCreate(createReq(nonNull(name)));
#     }
#
#     @Override
#     public List<CoreDatabase> all() {
#         List<String> databases = stub().databasesAll(allReq()).getNamesList();
#         return databases.stream().map(name -> new CoreDatabase(this, name)).collect(toList());
#     }
#
#     GraknStub.Core stub() {
#         return client.stub();
#     }
#
#     static String nonNull(String name) {
#         if (name == null) throw new GraknClientException(MISSING_DB_NAME);
#         return name;
#     }
# }
