# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE
using UUIDs

CLOSE_STREAM = "CLOSE_STREAM"

mutable struct RequestIterator
        _request_queue
end

RequestIterator() = RequestIterator(nothing)

mutable struct Transaction <: AbstractTransaction
        _options
        _transaction_type::Union{Any,Nothing}
        _concept_manager::T where {T<:Union{<:AbstractConceptManager, Nothing}}
        _query_manager::T where {T<:Union{<:AbstractQueryManager, Nothing}}
        _logic_manager::T where {T<:Union{<:AbstractLogicManager, Nothing}}
        _response_queues::Dict{String,Any} 
        _grpc_stub::Union{GraknBlockingStub,Nothing}
        _request_iterator::Union{Channel{grakn.protocol.Transaction_Req},Nothing}
        _response_iterator::Union{Channel{grakn.protocol.Transaction_Res},Nothing} 
        _transaction_was_closed::Bool
        _network_latency_millis::Number
end

Base.show(io::IO, transaction::T) where {T<:AbstractTransaction} = print(io,"Transaction - first attempt")


function Transaction(session::T, transaction_type::W, options::R) where {T<:AbstractSession} where {W<:Number} where {R<:AbstractGraknOptions}
        _options = options === nothing ? core() : options
        _transaction_type = transaction_type
        _concept_manager = ConceptManager()
        _query_manager = QueryManager()
        _logic_manager = LogicManager()
        _response_queues = Dict{String,Any}()

        channel = grpc_channel(GraknBlockingClient(session._address,session._port))
        _grpc_stub = GraknBlockingStub(channel)
        _request_iterator = Channel{grakn.protocol.Transaction_Req}(20)
        _response_iterator = Channel{grakn.protocol.Transaction_Res}(20)
        _transaction_was_closed = false

        open_req = grakn.protocol.Transaction_Open_Req()
        open_req.session_id = session._session_id
        open_req._type = _transaction_type_proto(transaction_type)
        open_req.options = copyFrom(options ,grakn.protocol.Options)
        req = grakn.protocol.Transaction_Req()
        req.id = string(UUIDs.uuid4())
        req.open_req = open_req
        res = @timed transaction(_grpc_stub, gRPCController(), req)
        _network_latency_millis = (res.time * 1000) - res.value.open_res.processing_time_millis
        
        Transaction(options, _transaction_type, _concept_manager, _query_manager, _logic_manager, _response_queues, _grpc_stub, _request_iterator, _response_iterator, _transaction_was_closed, _network_latency_millis )
end

const __meta_Channel_Transaction_Req = Ref{ProtoMeta}()
function meta(::Type{Channel{grakn.protocol.Transaction_Req}})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Channel_Transaction_Req)
                __meta_Channel_Transaction_Req[] = target = ProtoMeta(Channel{grakn.protocol.Transaction_Req})
            allflds = Pair{Symbol,Union{Type,String}}[]
            meta(target, Channel{grakn.protocol.Transaction_Req}, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES)
        end
        __meta_Channel_Transaction_Req[]
    end
end

function _transaction_type_proto(transaction_type)
        Int32(transaction_type)
end


function transaction_type(trans::T) where {T<:AbstractTransaction}
        findfirst(x-> x == trans._transaction_type, grakn.protocol.Transaction_Type)
end

function is_open(trans::T) where {T<:AbstractTransaction}
         !trans._transaction_was_closed
end

function concepts(trans::T) where {T<:AbstractTransaction}
        trans._concept_manager
end

function query(trans::T) where {T<:AbstractTransaction}
        trans._query_manager
end

function logic(trans::T) where {T<:AbstractTransaction}
        trans._logic_manager
end

function _execute(trans::T, request::grakn.protocol.Transaction_Req) where {T<:AbstractTransaction}
        request_id = string(UUIDs.uuid4())
        request.id = request_id
        if trans._transaction_was_closed
                throw(GraknClientException("The transaction has been closed and no further operation is allowed."))
        end
        res = transaction(trans._grpc_stub, gRPCController(), request)
end

function commit(trans::T) where {T<:AbstractTransaction}
        req = grakn.protocol.Transaction_Req()
        commit_req = grakn.protocol.Transaction_Commit_Req()
        req.commit_req = commit_req
        try
            _execute(trans,req)
        catch ex
           throw(GraknClientException("Transaction commit failed \n reason: $ex"))
        finally
            close(trans)
        end
end

function close(trans::T) where {T<:AbstractTransaction}
        trans_transaction_was_closed = true
        close(trans._request_iterator)
        close(trans._response_iterator)
end

function rollback(trans::T) where {T<:AbstractTransaction}
        req = grakn.protocol.Transaction_Req()
        rollback_req = grakn.protocol.Transaction_Rollback_Req()
        req.rollback_req = rollback_req
        _execute(trans, req)
end





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