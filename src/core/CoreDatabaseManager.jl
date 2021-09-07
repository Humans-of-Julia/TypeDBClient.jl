# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

mutable struct CoreDatabaseManager <: AbstractCoreDatabaseManager

end

function get_database(client::AbstractCoreClient, name::String)::CoreDatabase
    isempty(name) && throw(TypeDBClientException(CLIENT_MISSING_DB_NAME))
    if contains_database(client, name)
        return CoreDatabase(name)
    else
        throw(TypeDBClientException(CLIENT_DB_DOES_NOT_EXIST, name))
    end
end

function contains_database(client::AbstractCoreClient, name::String)
    isempty(name) && throw(TypeDBClientException(CLIENT_MISSING_DB_NAME))
    db = DatabaseManagerRequestBuilder
    req_result, status = Proto.databases_contains(client.core_stub.blockingStub, gRPCController() , db.contains_req(name))
    return grpc_result_or_error(req_result, status, result->result.contains)
end

function get_all_databases(client::AbstractCoreClient)::Vector{CoreDatabase}
    db = DatabaseManagerRequestBuilder
    req_result, status = Proto.databases_all(client.core_stub.blockingStub, gRPCController(), db.all_req())
    return grpc_result_or_error(req_result, status, result -> [CoreDatabase(db_name) for db_name in result.names])
end

function create_database(client::AbstractCoreClient, name::String)
    isempty(name) && throw(TypeDBClientException(CLIENT_MISSING_DB_NAME))
    db = DatabaseManagerRequestBuilder
    req_result, status =  Proto.databases_create(client.core_stub.blockingStub, gRPCController(), db.create_req(name))
    return grpc_result_or_error(req_result, status, result->true)
end

"""

    delete_database(client::AbstractCoreClient, name::String)

Delete the database for the given name without any question. Be carful. There is no
recovery function within this call.
"""
function delete_database(client::AbstractCoreClient, name::String)
    database = get_database(client, name)
    db = DatabaseRequestBuilder
    req_result, status =  Proto.database_delete(client.core_stub.blockingStub, gRPCController(), db.delete_req(database.name))
    return grpc_result_or_error(req_result, status, result->true)
end
