# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

# Devide the ErrorClassification Client, Concept, Query and Internal is possible
# with the following abstrat types.
abstract type AbstractGeneralError end
abstract type AbstractClientError <: AbstractGeneralError end
abstract type AbstractConceptError <: AbstractGeneralError end
abstract type AbstractQueryError <: AbstractGeneralError end
abstract type AbstractInternalError <: AbstractGeneralError end

# The Symbol left side is assigned to the struct which will be build bellow
# The right side of the Pair is assigned to the abstract type representing the section of error
const ERROR_STRUCTS = (
    :CLIENT_CLIENT_CLOSED=>:AbstractClientError,
    :CLIENT_SESSION_CLOSED=>:AbstractClientError,
    :CLIENT_TRANSACTION_CLOSED=>:AbstractClientError,
    :CLIENT_UNABLE_TO_CONNECT=>:AbstractClientError,
    :CLIENT_NEGATIVE_VALUE_NOT_ALLOWED=>:AbstractClientError,
    :CLIENT_MISSING_DB_NAME=>:AbstractClientError,
    :CLIENT_DB_DOES_NOT_EXIST=>:AbstractClientError,
    :CLIENT_MISSING_RESPONSE=>:AbstractClientError,
    :CLIENT_UNKNOWN_REQUEST_ID=>:AbstractClientError,
    :CLIENT_CLUSTER_NO_PRIMARY_REPLICA_YET=>:AbstractClientError,
    :CLIENT_CLUSTER_UNABLE_TO_CONNECT=>:AbstractClientError,
    :CLIENT_CLUSTER_REPLICA_NOT_PRIMARY=>:AbstractClientError,
    :CLIENT_CLUSTER_ALL_NODES_FAILED=>:AbstractClientError,
    :CONCEPT_INVALID_CONCEPT_CASTING=>:AbstractConceptError,
    :CONCEPT_MISSING_TRANSACTION=>:AbstractConceptError,
    :CONCEPT_MISSING_IID=>:AbstractConceptError,
    :CONCEPT_MISSING_LABEL=>:AbstractConceptError,
    :CONCEPT_BAD_ENCODING=>:AbstractConceptError,
    :CONCEPT_BAD_VALUE_TYPE=>:AbstractConceptError,
    :CONCEPT_BAD_ATTRIBUTE_VALUE=>:AbstractConceptError,
    :QUERY_VARIABLE_DOES_NOT_EXIST=>:AbstractQueryError,
    :QUERY_NO_EXPLANATION=>:AbstractQueryError,
    :QUERY_BAD_ANSWER_TYPE=>:AbstractQueryError,
    :QUERY_MISSING_ANSWER=>:AbstractQueryError,
    :INTERNAL_UNEXPECTED_INTERRUPTION=>:AbstractInternalError,
    :INTERNAL_ILLEGAL_STATE=>:AbstractInternalError,
    :INTERNAL_ILLEGAL_ARGUMENT=>:AbstractInternalError,
    :INTERNAL_ILLEGAL_CAST=>:AbstractInternalError,
    :GENERAL_UNKOWN_ERROR=>:AbstractInternalError)

# building the error structs according the Pairs above with some meta programming
for (T,A) in ERROR_STRUCTS
    @eval mutable struct $T <: $A
        code_prefix::String
        code_number::Int
        message_prefix::String
        message_body::String
    end
end

function Base.show(io::IO, err_struct::AbstractGeneralError)
    str = "[$(err_struct.code_prefix)$(lpad(err_struct.code_number,3,"0"))] $(err_struct.message_body)"
    print(io,str)
    return nothing
end

# All structs represent a unique number in a section of errors and the description. Both of them are
# assigned on the right side pair
const error_messages = Dict([
    #Client Error Section
    CLIENT_CLIENT_CLOSED=>(1, "The client has been closed and no further operation is allowed."),
    CLIENT_SESSION_CLOSED=>( 2, "The session has been closed and no further operation is allowed."),
    CLIENT_TRANSACTION_CLOSED=>( 3, "The transaction has been closed and no further operation is allowed."),
    CLIENT_UNABLE_TO_CONNECT=>(4, "Unable to connect to TypeDB server."),
    CLIENT_NEGATIVE_VALUE_NOT_ALLOWED=>(5, "Value cannot be less than 1, was: _error_item."),
    CLIENT_MISSING_DB_NAME=>(6,  "Database name cannot be null."),
    CLIENT_DB_DOES_NOT_EXIST=>(7,  "The database _error_item does not exist."),
    CLIENT_MISSING_RESPONSE=>(8,  "Unexpected empty response for request ID _error_item."),
    CLIENT_UNKNOWN_REQUEST_ID=>(9,  "Received a response with unknown request id _error_item."),
    CLIENT_CLUSTER_NO_PRIMARY_REPLICA_YET=>(10,  "No replica has been marked as the primary replica for latest known term _error_item."),
    CLIENT_CLUSTER_UNABLE_TO_CONNECT=>(11,  "Unable to connect to TypeDB Cluster. Attempted connecting to the cluster members, but none are available: _error_item."),
    CLIENT_CLUSTER_REPLICA_NOT_PRIMARY=>(12,  "The replica is not the primary replica."),
    CLIENT_CLUSTER_ALL_NODES_FAILED=>(13,  "Attempted connecting to all cluster members, but the following errors occurred: \n%s"),
    ### Conept Error Section
    CONCEPT_INVALID_CONCEPT_CASTING=>(1, "Invalid concept conversion from _error_item to _error_item."),
    CONCEPT_MISSING_TRANSACTION=>(2,  "Transaction cannot be null."),
    CONCEPT_MISSING_IID=>(3,  "IID cannot be null or empty."),
    CONCEPT_MISSING_LABEL=>(4,  "Label cannot be null or empty."),
    CONCEPT_BAD_ENCODING=>(5,  "The encoding _error_item was not recognised."),
    CONCEPT_BAD_VALUE_TYPE=>(6,  "The value type _error_item was not recognised."),
    CONCEPT_BAD_ATTRIBUTE_VALUE=>(7,  "The attribute value _error_item was not recognised."),
    # Query Error Section
    QUERY_VARIABLE_DOES_NOT_EXIST=>(1,  "The variable _error_item does not exist."),
    QUERY_NO_EXPLANATION=>(2,  "No explanation was found."),
    QUERY_BAD_ANSWER_TYPE=>(3,  "The answer type _error_item was not recognised."),
    QUERY_MISSING_ANSWER=>(4,  "The required field 'answer' of type _error_item was not set."),
    #Internal Error Section
    INTERNAL_UNEXPECTED_INTERRUPTION =>(1, "Unexpected thread interruption!"),
    INTERNAL_ILLEGAL_STATE =>(2, "Illegal state has been reached!"),
    INTERNAL_ILLEGAL_ARGUMENT =>(3, "Illegal argument provided: _error_item"),
    INTERNAL_ILLEGAL_CAST =>(4, "Illegal casting operation to _error_item."),
    #General Error Section included in the internal section
    GENERAL_UNKOWN_ERROR => (100, "_error_item")
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

function _build_error_messages(class::Type{T}) where {T<:AbstractInternalError}
    items = error_messages[class]
    class("INT",items[1], "Internal Error", items[2])
end




#
# package typedb.client.common.exception;
#
# public abstract class ErrorMessage extends typedb.common.exception.ErrorMessage {
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
#                 new Client(4, "Unable to connect to TypeDB server.");
#         public static final Client NEGATIVE_VALUE_NOT_ALLOWED =
#                 new Client(5, "Value cannot be less than 1, was: '%d'.");
#         public static final Client MISSING_DB_NAME =
#                 new Client(6, "Database name cannot be null.");
#         public static final Client DB_DOES_NOT_EXIST =
#                 new Client(7, "The database $error_item does not exist.");
#         public static final Client MISSING_RESPONSE =
#                 new Client(8, "Unexpected empty response for request ID $error_item.");
#         public static final Client UNKNOWN_REQUEST_ID =
#                 new Client(9, "Received a response with unknown request id $error_item.");
#         public static final Client CLUSTER_NO_PRIMARY_REPLICA_YET =
#                 new Client(10, "No replica has been marked as the primary replica for latest known term '%d'.");
#         public static final Client CLUSTER_UNABLE_TO_CONNECT =
#                 new Client(11, "Unable to connect to TypeDB Cluster. Attempted connecting to the cluster members, but none are available: $error_item.");
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
#                 new Concept(1, "Invalid concept conversion from $error_item to $error_item.");
#         public static final Concept MISSING_TRANSACTION =
#                 new Concept(2, "Transaction cannot be null.");
#         public static final Concept MISSING_IID =
#                 new Concept(3, "IID cannot be null or empty.");
#         public static final Concept MISSING_LABEL =
#                 new Concept(4, "Label cannot be null or empty.");
#         public static final Concept BAD_ENCODING =
#                 new Concept(5, "The encoding $error_item was not recognised.");
#         public static final Concept BAD_VALUE_TYPE =
#                 new Concept(6, "The value type $error_item was not recognised.");
#         public static final Concept BAD_ATTRIBUTE_VALUE =
#                 new Concept(7, "The attribute value $error_item was not recognised.");
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
#                 new Query(1, "The variable $error_item does not exist.");
#         public static final Query NO_EXPLANATION =
#                 new Query(2, "No explanation was found.");
#         public static final Query BAD_ANSWER_TYPE =
#                 new Query(3, "The answer type $error_item was not recognised.");
#         public static final Query MISSING_ANSWER =
#                 new Query(4, "The required field 'answer' of type $error_item was not set.");
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
#                 new Internal(3, "Illegal argument provided: $error_item");
#         public static final Internal ILLEGAL_CAST =
#                 new Internal(4, "Illegal casting operation to $error_item.");
#
#         private static final String codePrefix = "INT";
#         private static final String messagePrefix = "Internal Error";
#
#         Internal(int number, String message) {
#             super(codePrefix, number, messagePrefix, message);
#         }
#     }
# }
