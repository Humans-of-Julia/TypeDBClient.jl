module GraknClient

import GRPC

# from grakn.options import GraknOptions
# from grakn.rpc.database_manager import DatabaseManager as _DatabaseManager
# from grakn.rpc.session import Session as _Session, SessionType

# # Repackaging these symbols allows users to import everything they (most likely) need from "grakn.client"
# from grakn.common.exception import GraknClientException  # noqa # pylint: disable=unused-import
# from grakn.concept.type.attribute_type import ValueType  # noqa # pylint: disable=unused-import
# from grakn.rpc.transaction import TransactionType  # noqa # pylint: disable=unused-import

DEFAULT_URI = "localhost:1729"

mutable struct grakn_Client 
    _channel
    _databses
    _is_open
end

grakn_Client() = grakn_Client(;adress=DEFAULT_URI,defaultChannel(),true)

function defaultChannel()
    gRPC.
end
    # def __init__(self, address=DEFAULT_URI):
    #     self._channel = grpc.insecure_channel(address)
    #     self._databases = _DatabaseManager(self._channel)
    #     self._is_open = True

    # def session(self, database: str, session_type: SessionType, options=GraknOptions()):
    #     return _Session(self, database, session_type, options)

    # def databases(self):
    #     return self._databases

    # def close(self):
    #     self._channel.close()
    #     self._is_open = False

    # def is_open(self):
    #     return self._is_open

    # def __enter__(self):
    #     return self

    # def __exit__(self, exc_type, exc_val, exc_tb):
    #     self.close()
    #     if exc_tb is None:
    #         pass
    #     else:
    #         return False
end



