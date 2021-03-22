# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# Devide the ErrorClassification Client, Concept, Query and Internal is possible
# with the following abstrat types. 
abstract type AbstractGeneralError end
abstract type AbstractClientError <: AbstractGeneralError end
abstract type AbstractConceptError <: AbstractGeneralError end
abstract type AbstractQueryError <: AbstractGeneralError end
abstract type AbstractInternalError <: AbstractGeneralError end

# The Symbol left side is assigned to the struct which will be build bellow
# The right side of the Pair is assigned to the abstract type representing the section of error
const error_structs = (
    :Client_CLIENT_CLOSED=>:AbstractClientError,
    :Client_SESSION_CLOSED=>:AbstractClientError, 
    :Client_TRANSACTION_CLOSED=>:AbstractClientError, 
    :Client_UNABLE_TO_CONNECT=>:AbstractClientError, 
    :Client_NEGATIVE_VALUE_NOT_ALLOWED=>:AbstractClientError,  
    :Client_MISSING_DB_NAME=>:AbstractClientError, 
    :Client_DB_DOES_NOT_EXIST=>:AbstractClientError, 
    :Client_MISSING_RESPONSE=>:AbstractClientError, 
    :Client_UNKNOWN_REQUEST_ID=>:AbstractClientError, 
    :Client_CLUSTER_NO_PRIMARY_REPLICA_YET=>:AbstractClientError, 
    :Client_CLUSTER_UNABLE_TO_CONNECT=>:AbstractClientError, 
    :Client_CLUSTER_REPLICA_NOT_PRIMARY=>:AbstractClientError, 
    :Client_CLUSTER_ALL_NODES_FAILED=>:AbstractClientError, 
    :Concept_INVALID_CONCEPT_CASTING=>:AbstractConceptError, 
    :Concept_MISSING_TRANSACTION=>:AbstractConceptError,  
    :Concept_MISSING_IID=>:AbstractConceptError, 
    :Concept_MISSING_LABEL=>:AbstractConceptError, 
    :Concept_BAD_ENCODING=>:AbstractConceptError, 
    :Concept_BAD_VALUE_TYPE=>:AbstractConceptError, 
    :Concept_BAD_ATTRIBUTE_VALUE=>:AbstractConceptError, 
    :Query_VARIABLE_DOES_NOT_EXIST=>:AbstractQueryError, 
    :Query_NO_EXPLANATION=>:AbstractQueryError,  
    :Query_BAD_ANSWER_TYPE=>:AbstractQueryError,  
    :Query_MISSING_ANSWER=>:AbstractQueryError,  
    :Internal_UNEXPECTED_INTERRUPTION=>:AbstractInternalError, 
    :Internal_ILLEGAL_STATE=>:AbstractInternalError, 
    :Internal_ILLEGAL_ARGUMENT=>:AbstractInternalError, 
    :Internal_ILLEGAL_CAST=>:AbstractInternalError)

# building the error structs according the Pairs above with some meta programming
for (T,A) in error_structs
    @eval mutable struct $T <: $A
        code_prefix::String  
        code_number::Int 
        message_prefix::String   
        message_body::String
    end
end

# All structs represent a unique number in a section of errors and the description. Both of them are 
# assigned on the right side pair
const error_messages = Dict([
        Client_CLIENT_CLOSED=>( 1, "The client has been closed and no further operation is allowed."),
        Client_SESSION_CLOSED=>( 2, "The session has been closed and no further operation is allowed."),
        Client_TRANSACTION_CLOSED=>( 3, "The transaction has been closed and no further operation is allowed."),
        Client_UNABLE_TO_CONNECT=>(4, "Unable to connect to Grakn server."),
        Client_NEGATIVE_VALUE_NOT_ALLOWED=>(5, "Value cannot be less than 1, was: '%d'."),
        Client_MISSING_DB_NAME=>(6,  "Database name cannot be null."),
        Client_DB_DOES_NOT_EXIST=>(7,  "The database '%s' does not exist."),
        Client_MISSING_RESPONSE=>(8,  "Unexpected empty response for request ID '%s'."),
        Client_UNKNOWN_REQUEST_ID=>(9,  "Received a response with unknown request id '%s'."),
        Client_CLUSTER_NO_PRIMARY_REPLICA_YET=>(10,  "No replica has been marked as the primary replica for latest known term '%d'."),
        Client_CLUSTER_UNABLE_TO_CONNECT=>(11,  "Unable to connect to Grakn Cluster. Attempted connecting to the cluster members, but none are available: '%s'."),
        Client_CLUSTER_REPLICA_NOT_PRIMARY=>(12,  "The replica is not the primary replica."),
        Client_CLUSTER_ALL_NODES_FAILED=>(13,  "Attempted connecting to all cluster members, but the following errors occurred: \n%s"),
    
        ### Conept Error Section
        Concept_INVALID_CONCEPT_CASTING=>(1, "Invalid concept conversion from '%s' to '%s'."),
        Concept_MISSING_TRANSACTION=>(2,  "Transaction cannot be null."),
        Concept_MISSING_IID=>(3,  "IID cannot be null or empty."),
        Concept_MISSING_LABEL=>(4,  "Label cannot be null or empty."),
        Concept_BAD_ENCODING=>(5,  "The encoding '%s' was not recognised."),
        Concept_BAD_VALUE_TYPE=>(6,  "The value type '%s' was not recognised."),
        Concept_BAD_ATTRIBUTE_VALUE=>(7,  "The attribute value '%s' was not recognised."),

        # Query Error Section
        Query_VARIABLE_DOES_NOT_EXIST=>(1,  "The variable '%s' does not exist."),
        Query_NO_EXPLANATION=>(2,  "No explanation was found."),
        Query_BAD_ANSWER_TYPE=>(3,  "The answer type '%s' was not recognised."),
        Query_MISSING_ANSWER=>(4,  "The required field 'answer' of type '%s' was not set."),

        #Internal Error Section
        Internal_UNEXPECTED_INTERRUPTION =>(1, "Unexpected thread interruption!"),
        Internal_ILLEGAL_STATE =>(2, "Illegal state has been reached!"),
        Internal_ILLEGAL_ARGUMENT =>(3, "Illegal argument provided: '%s'"),
        Internal_ILLEGAL_CAST =>(4, "Illegal casting operation to '%s'.")
])    


# Build the error massage according the section of errors represented by the 
# abstract type of each section of errors
function _build_error_messages(class::Type{T}) where {T<:AbstractClientError}
    items = error_messages[class]
    class("CLI",items[1], "Client Error", items[2])
end

function _build_error_messages(class::Type{T}) where {T<:AbstractConceptError}
    items = error_messages[class]
    class("CON",items[1], "Concept Error", items[2])
end

function _build_error_messages(class::Type{T}) where {T<:AbstractQueryError}
    items = error_messages[class]
    class("QRY",items[1], "Query Error", items[2])
end

function _build_error_messages(class::Type{T}) where {T<:AbstractQueryError}
    items = error_messages[class]
    class("INT",items[1], "Internal Error", items[2])
end


# 
# package grakn.client.common.exception;
# 
# public abstract class ErrorMessage extends grakn.common.exception.ErrorMessage {
# 
#     private ErrorMessage(String codePrefix, int codeNumber, String messagePrefix, String messageBody) {
#         super(codePrefix, codeNumber, messagePrefix, messageBody);
#     }
# 
#     public static class Client extends ErrorMessage {
#         public static final Client CLIENT_CLOSED =
#                 new Client(1, "The client has been closed and no further operation is allowed.");
#         public static final Client SESSION_CLOSED =
#                 new Client(2, "The session has been closed and no further operation is allowed.");
#         public static final Client TRANSACTION_CLOSED =
#                 new Client(3, "The transaction has been closed and no further operation is allowed.");
#         public static final Client UNABLE_TO_CONNECT =
#                 new Client(4, "Unable to connect to Grakn server.");
#         public static final Client NEGATIVE_VALUE_NOT_ALLOWED =
#                 new Client(5, "Value cannot be less than 1, was: '%d'.");
#         public static final Client MISSING_DB_NAME =
#                 new Client(6, "Database name cannot be null.");
#         public static final Client DB_DOES_NOT_EXIST =
#                 new Client(7, "The database '%s' does not exist.");
#         public static final Client MISSING_RESPONSE =
#                 new Client(8, "Unexpected empty response for request ID '%s'.");
#         public static final Client UNKNOWN_REQUEST_ID =
#                 new Client(9, "Received a response with unknown request id '%s'.");
#         public static final Client CLUSTER_NO_PRIMARY_REPLICA_YET =
#                 new Client(10, "No replica has been marked as the primary replica for latest known term '%d'.");
#         public static final Client CLUSTER_UNABLE_TO_CONNECT =
#                 new Client(11, "Unable to connect to Grakn Cluster. Attempted connecting to the cluster members, but none are available: '%s'.");
#         public static final Client CLUSTER_REPLICA_NOT_PRIMARY =
#                 new Client(12, "The replica is not the primary replica.");
#         public static final Client CLUSTER_ALL_NODES_FAILED =
#                 new Client(13, "Attempted connecting to all cluster members, but the following errors occurred: \n%s");
# 
#         private static final String codePrefix = "CLI";
#         private static final String messagePrefix = "Client Error";
# 
#         Client(int number, String message) {
#             super(codePrefix, number, messagePrefix, message);
#         }
#     }
# 
#     public static class Concept extends ErrorMessage {
#         public static final Concept INVALID_CONCEPT_CASTING =
#                 new Concept(1, "Invalid concept conversion from '%s' to '%s'.");
#         public static final Concept MISSING_TRANSACTION =
#                 new Concept(2, "Transaction cannot be null.");
#         public static final Concept MISSING_IID =
#                 new Concept(3, "IID cannot be null or empty.");
#         public static final Concept MISSING_LABEL =
#                 new Concept(4, "Label cannot be null or empty.");
#         public static final Concept BAD_ENCODING =
#                 new Concept(5, "The encoding '%s' was not recognised.");
#         public static final Concept BAD_VALUE_TYPE =
#                 new Concept(6, "The value type '%s' was not recognised.");
#         public static final Concept BAD_ATTRIBUTE_VALUE =
#                 new Concept(7, "The attribute value '%s' was not recognised.");
# 
#         private static final String codePrefix = "CON";
#         private static final String messagePrefix = "Concept Error";
# 
#         Concept(int number, String message) {
#             super(codePrefix, number, messagePrefix, message);
#         }
#     }
# 
#     public static class Query extends ErrorMessage {
#         public static final Query VARIABLE_DOES_NOT_EXIST =
#                 new Query(1, "The variable '%s' does not exist.");
#         public static final Query NO_EXPLANATION =
#                 new Query(2, "No explanation was found.");
#         public static final Query BAD_ANSWER_TYPE =
#                 new Query(3, "The answer type '%s' was not recognised.");
#         public static final Query MISSING_ANSWER =
#                 new Query(4, "The required field 'answer' of type '%s' was not set.");
# 
#         private static final String codePrefix = "QRY";
#         private static final String messagePrefix = "Query Error";
# 
#         Query(int number, String message) {
#             super(codePrefix, number, messagePrefix, message);
#         }
#     }
# 
#     public static class Internal extends ErrorMessage {
#         public static final Internal UNEXPECTED_INTERRUPTION =
#                 new Internal(1, "Unexpected thread interruption!");
#         public static final Internal ILLEGAL_STATE =
#                 new Internal(2, "Illegal state has been reached!");
#         public static final Internal ILLEGAL_ARGUMENT =
#                 new Internal(3, "Illegal argument provided: '%s'");
#         public static final Internal ILLEGAL_CAST =
#                 new Internal(4, "Illegal casting operation to '%s'.");
# 
#         private static final String codePrefix = "INT";
#         private static final String messagePrefix = "Internal Error";
# 
#         Internal(int number, String message) {
#             super(codePrefix, number, messagePrefix, message);
#         }
#     }
# }
