# import enum
# from typing import Callable, List

# import grpc
# import time
# import uuid

# import queue

# from grakn_protocol.protobuf.grakn_pb2_grpc import GraknStub
# import grakn_protocol.protobuf.transaction_pb2 as transaction_proto

# from grakn import grakn_proto_builder
# from grakn.common.exception import GraknClientException
# from grakn.concept.concept_manager import ConceptManager
# from grakn.options import GraknOptions
# from grakn.query.query_manager import QueryManager
# from grakn.rpc.stream import Stream
# from grakn.logic.logic_manager import LogicManager

CLOSE_STREAM = "CLOSE_STREAM"

mutable struct RequestIterator
        _request_queue
end

RequestIterator() = RequestIterator(nothing)

mutable struct Transaction <: AbstractTransaction
        _options
        _transaction_type::Union{Any,Nothing}
        _concept_manager::Union{T,Nothing} where {T<:AbstractConceptManager}
        _query_manager::Union{T,Nothing} where {T<:AbstractQueryManager}
        _logic_manager::Union{T,Nothing} where {T<:AbstractLogicManager}
        _response_queues 
        _grpc_stub::Union{GraknStub,Nothing}
        _request_iterator::Union{RequestIterator,Nothing}
        _response_iterator 
        _transaction_was_closed::Bool
end

Base.show(io::IO, transaction::T) where {T<:AbstractTransaction} = print(io,"Transaction - session-id: $(transaction._session_id)")


function Transaction(session::T, transaction_type::R, options= nothing) where {T<:Session, R<:Number}
        _options = options === nothing ? core() : options
        _transaction_type = transaction_type
        _concept_manager = ConceptManager()
        _query_manager = QueryManager()
        _logic_manager = LogicManager()
        _response_queues = Dict{String,Any}()

        _channel = grpc_channel(GraknBlockingClient(session._address,session._port))
        _grpc_stub = GraknBlockingStub(_channel)
        _request_iterator = Channel{Transaction_Req}(4)
        _response_iterator = transaction(_grpc_stub, gRPCController(), _request_iterator)
        _transaction_was_closed = false

        # open_req = Transaction_Open_Req()
        # open_req.session_id = session._session_id
        # open_req.type = _transaction_type_proto(transaction_type)
        # open_req.options = copyFrom(options ,grakn.protocol.Options)
        # req = Transaction_Req()
        # req.open_req.CopyFrom(open_req)

#         start_time = time.time() * 1000.0
#         res = self._execute(req)
#         end_time = time.time() * 1000.0
#         self._network_latency_millis = end_time - start_time - res.open_res.processing_time_millis

        Transaction(options, _transaction_type, nothing, nothing, nothing, nothing, nothing, nothing, nothing, false)
end

#     def transaction_type(self):
#         return self._transaction_type

#     def is_open(self):
#         return not self._transaction_was_closed

#     def concepts(self):
#         return self._concept_manager

#     def query(self):
#         return self._query_manager

#     def logic(self):
#         return self._logic_manager

#     def commit(self):
#         req = transaction_proto.Transaction.Req()
#         commit_req = transaction_proto.Transaction.Commit.Req()
#         req.commit_req.CopyFrom(commit_req)
#         try:
#             self._execute(req)
#         finally:
#             self.close()

#     def rollback(self):
#         req = transaction_proto.Transaction.Req()
#         rollback_req = transaction_proto.Transaction.Rollback.Req()
#         req.rollback_req.CopyFrom(rollback_req)
#         self._execute(req)

#     def close(self):
#         self._transaction_was_closed = True
#         self._request_iterator.close()

#     def _execute(self, request: transaction_proto.Transaction.Req):
#         response_queue = queue.Queue()
#         request_id = str(uuid.uuid4())
#         request.id = request_id
#         if self._transaction_was_closed:
#             raise GraknClientException("The transaction has been closed and no further operation is allowed.")
#         self._response_queues[request_id] = response_queue
#         self._request_iterator.put(request)
#         return self._fetch(request_id)

#     def _stream(self, request: transaction_proto.Transaction.Req, transform_response: Callable[[transaction_proto.Transaction.Res], List] = None):
#         response_queue = queue.Queue()
#         request_id = str(uuid.uuid4())
#         request.id = request_id
#         if self._transaction_was_closed:
#             raise GraknClientException("The transaction has been closed and no further operation is allowed.")
#         self._response_queues[request_id] = response_queue
#         self._request_iterator.put(request)
#         return Stream(self, request_id, transform_response)

#     def _fetch(self, request_id: str):
#         try:
#             return self._response_queues[request_id].get(block=False)
#         except queue.Empty:
#             pass

#         # Keep taking responses until we get one that matches the request ID
#         while True:
#             try:
#                 response = next(self._response_iterator)
#             except grpc.RpcError as e:
#                 self._transaction_was_closed = True
#                 grakn_exception = GraknClientException(e.details())
#                 for response_queue in self._response_queues.values():
#                     response_queue.put(grakn_exception)
#                 # noinspection PyUnresolvedReferences
#                 raise grakn_exception
#             except StopIteration:
#                 raise GraknClientException("The transaction has been closed and no further operation is allowed.")

#             if isinstance(response, GraknClientException):
#                 raise response
#             elif response.id == request_id:
#                 return response
#             else:
#                 response_queue = self._response_queues[response.id]
#                 if response_queue is None:
#                     raise GraknClientException("Received a response with unknown request id '" + response.id + "'.")
#                 response_queue.put(response)

#     def __enter__(self):
#         return self

#     def __exit__(self, exc_type, exc_val, exc_tb):
#         self.close()
#         if exc_tb is None:
#             pass
#         else:
#             return False

#     @staticmethod
#     def _transaction_type_proto(transaction_type):
#         if transaction_type == TransactionType.READ:
#             return transaction_proto.Transaction.Type.Value("READ")
#         if transaction_type == TransactionType.WRITE:
#             return transaction_proto.Transaction.Type.Value("WRITE")


    # Essentially the gRPC stream is constantly polling this iterator. When we issue a new request, it gets put into
    # the back of the queue and gRPC will pick it up when it gets round to it (this is usually instantaneous)
#     def __next__(self):
#         request = self._request_queue.get(block=True)
#         if request is RequestIterator.CLOSE_STREAM:
#             # Close the stream.
#             raise StopIteration()
#         return request

#     def put(self, request: transaction_proto.Transaction.Req):
#         self._request_queue.put(request)

#     def close(self):
#         self._request_queue.put(RequestIterator.CLOSE_STREAM)