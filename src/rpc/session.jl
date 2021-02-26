 
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

@enum SessionType DATA=0 SCHEMA=1


function _session_type_proto(session_type::SessionType)
    if session_type == SessionType.DATA
        return session_proto.Session.Type.Value("DATA")
    elseif  session_type == SessionType.SCHEMA
        return session_proto.Session.Type.Value("SCHEMA")
    end
end


# class Session(ABC):

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


struct _SessionRPC    
    _PULSE_FREQUENCY_SECONDS::Number
    options
    _address
    _channel
    #_scheduler
    _database
    _session_type
    _grpc_stub
end
_SessionRPC(client::GraknBlockingClient, database::String, options::GraknOptions, session_type::SessionType) = init_Session(client, database, options, session_type)

function init_Session(client::GraknBlockingClient, database::String, options::GraknOptions, session_type::SessionType)
        options === nothing && _options = graknOptions_core()
        _address = client.addresss
        _port = client.port
        _channel = grpc_channel(GraknBlockingClient(address,port))
        # _scheduler = sched.scheduler(time.time, time.sleep)
        _database = database
        _session_type = session_type
        _grpc_stub = GraknStub(_channel)

        open_req = grakn.protocol.Session_Open_Req()
        open_req.database = database
        open_req.type = _session_type_proto(session_type)
        open_req.options.CopyFrom(grakn.protocol.Options()(options))

#         self._session_id = self._grpc_stub.session_open(open_req).session_id
#         self._is_open = True
#         self._pulse = self._scheduler.enter(delay=self._PULSE_FREQUENCY_SECONDS, priority=1, action=self._transmit_pulse, argument=())
#         Thread(target=self._scheduler.run, name="session_pulse_{}".format(self._session_id.hex()), daemon=True).start()
end

#     def transaction(self, transaction_type: TransactionType, options=None) -> Transaction:
#         if not options:
#             options = GraknOptions.core()
#         return Transaction(self._address, self._session_id, transaction_type, options)

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