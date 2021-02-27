 
using gRPC
using .grakn.protocol
# import grakn_protocol.protobuf.session_pb2 as session_proto
# import grpc
# from grakn_protocol.protobuf.grakn_pb2_grpc import GraknStub
# from grpc import RpcError

# from grakn import grakn_proto_builder
# from grakn.common.exception import GraknClientException
# from grakn.options import GraknOptions
# from grakn.rpc.transaction import Transaction, TransactionType

abstract type AbstractSession end
abstract type Session <: AbstractSession end


function _session_type_proto(session_type)
    return Int(session_type)
end

#     @abstractmethod
#     def transaction(self, transaction_type: TransactionType, options=None) -> Transaction:
#         pass

#     @abstractmethod
#     def session_type(self) -> SessionType:
#         pass

#     @abstractmethod
#     def is_open(self) -> bool:
#         pass

#     @abstractmethod
#     def close(self) -> None:
#         pass

#     @abstractmethod
#     def database(self) -> str:
#         pass

#     @abstractmethod
#     def __enter__(self):
#         pass

#     @abstractmethod
#     def __exit__(self, exc_type, exc_val, exc_tb):
#         pass


struct _SessionRPC <: Session    
    _pulse_frequency_seconds::Number
    _options
    _address
    _port
    _channel
    #_scheduler
    _database
    _session_type
    _grpc_stub
end

Session(client::GraknBlockingClient, database::String, options::GraknOptions, session_type) = init_Session(client, database, options, session_type) 
_SessionRPC(client::GraknBlockingClient, database::String, options::GraknOptions, session_type) = init_Session(client, database, options, session_type)

function init_Session(client::GraknBlockingClient, database::String, options::Union{GraknOptions,Nothing}, session_type)
    _pulse_frequency_seconds = 5
    options === nothing ? _options = core() : _options = options
    _address = client.address
    _port = client.port
    _channel = grpc_channel(GraknBlockingClient(_address,_port))
    # _scheduler = sched.scheduler(time.time, time.sleep)
    _database = database
    _session_type = session_type
    _grpc_stub = GraknBlockingStub(_channel)

    open_req = grakn.protocol.Session_Open_Req()
    open_req.database = database
    open_req._type = _session_type_proto(session_type)
    open_req.options = copyFrom(options ,grakn.protocol.Options)

    _session_id = session_open(_grpc_stub, gRPCController(), open_req).session_id
    _is_open = true
#         self._pulse = self._scheduler.enter(delay=self._PULSE_FREQUENCY_SECONDS, priority=1, action=self._transmit_pulse, argument=())
#         Thread(target=self._scheduler.run, name="session_pulse_{}".format(self._session_id.hex()), daemon=True).start()
    _SessionRPC(_pulse_frequency_seconds, _options, _address, _port, _channel, _database , _session_type , _grpc_stub)
end

function transaction(session::T, transaction_type, options=nothing) where {T<:Session}
    _options = options === nothing && core()
    return Transaction(session, transaction_type, options)
end

#     def session_type(self) -> SessionType: return self._session_type

#     def is_open(self) -> bool: return self._is_open

#     def close(self) -> None:
#         if self._is_open:
#             self._is_open = False
#             self._scheduler.cancel(self._pulse)
#             self._scheduler.empty()
#             req = session_proto.Session.Close.Req()
#             req.session_id = self._session_id
#             try:
#                 self._grpc_stub.session_close(req)
#             except RpcError as e:
#                 raise GraknClientException(e)
#             finally:
#                 self._channel.close()

#     def database(self) -> str: return self._database

#     def _transmit_pulse(self) -> None:
#         if not self._is_open:
#             return
#         pulse_req = session_proto.Session.Pulse.Req()
#         pulse_req.session_id = self._session_id
#         res = self._grpc_stub.session_pulse(pulse_req)
#         if res.alive:
#             self._pulse = self._scheduler.enter(delay=self._PULSE_FREQUENCY_SECONDS, priority=1, action=self._transmit_pulse, argument=())
#             Thread(target=self._scheduler.run, name="session_pulse_{}".format(self._session_id.hex()), daemon=True).start()

#     def __enter__(self):
#         return self

#     def __exit__(self, exc_type, exc_val, exc_tb):
#         self.close()
#         if exc_tb is None:
#             pass
#         else:
#             return False

#### helper functions  ############

function copyFrom(fromOption::R, toOption::Type{T}) where {T<:Options} where {R<:AbstractGraknOptions}
    result_option = toOption()
    for fname in fieldnames(typeof(fromOption))
        if hasproperty(result_option, Symbol(fname))
            setproperty!(result_option,Symbol(fname),getfield(fromOption,Symbol(fname)))
            @info "innere Schleife copyFrom"
        end
    end
    result_option
end
