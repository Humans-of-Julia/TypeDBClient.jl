# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

# service methods for TypeDB
const _TypeDB_methods = MethodDescriptor[
        MethodDescriptor("databases_contains", 1, typedb.protocol.CoreDatabaseManager_Contains_Req, typedb.protocol.CoreDatabaseManager_Contains_Res),
        MethodDescriptor("databases_create", 2, typedb.protocol.CoreDatabaseManager_Create_Req, typedb.protocol.CoreDatabaseManager_Create_Res),
        MethodDescriptor("databases_all", 3, typedb.protocol.CoreDatabaseManager_All_Req, typedb.protocol.CoreDatabaseManager_All_Res),
        MethodDescriptor("database_schema", 4, typedb.protocol.CoreDatabase_Schema_Req, typedb.protocol.CoreDatabase_Schema_Res),
        MethodDescriptor("database_delete", 5, typedb.protocol.CoreDatabase_Delete_Req, typedb.protocol.CoreDatabase_Delete_Res),
        MethodDescriptor("session_open", 6, typedb.protocol.Session_Open_Req, typedb.protocol.Session_Open_Res),
        MethodDescriptor("session_close", 7, typedb.protocol.Session_Close_Req, typedb.protocol.Session_Close_Res),
        MethodDescriptor("session_pulse", 8, typedb.protocol.Session_Pulse_Req, typedb.protocol.Session_Pulse_Res),
        MethodDescriptor("transaction", 9, Channel{typedb.protocol.Transaction_Client}, Channel{typedb.protocol.Transaction_Server})
    ] # const _TypeDB_methods
const _TypeDB_desc = ServiceDescriptor("typedb.protocol.TypeDB", 1, _TypeDB_methods)

TypeDB(impl::Module) = ProtoService(_TypeDB_desc, impl)

mutable struct TypeDBStub <: AbstractProtoServiceStub{false}
    impl::ProtoServiceStub
    TypeDBStub(channel::ProtoRpcChannel) = new(ProtoServiceStub(_TypeDB_desc, channel))
end # mutable struct TypeDBStub

mutable struct TypeDBBlockingStub <: AbstractProtoServiceStub{true}
    impl::ProtoServiceBlockingStub
    TypeDBBlockingStub(channel::ProtoRpcChannel) = new(ProtoServiceBlockingStub(_TypeDB_desc, channel))
end # mutable struct TypeDBBlockingStub

databases_contains(stub::TypeDBStub, controller::ProtoRpcController, inp::typedb.protocol.CoreDatabaseManager_Contains_Req, done::Function) = call_method(stub.impl, _TypeDB_methods[1], controller, inp, done)
databases_contains(stub::TypeDBBlockingStub, controller::ProtoRpcController, inp::typedb.protocol.CoreDatabaseManager_Contains_Req) = call_method(stub.impl, _TypeDB_methods[1], controller, inp)

databases_create(stub::TypeDBStub, controller::ProtoRpcController, inp::typedb.protocol.CoreDatabaseManager_Create_Req, done::Function) = call_method(stub.impl, _TypeDB_methods[2], controller, inp, done)
databases_create(stub::TypeDBBlockingStub, controller::ProtoRpcController, inp::typedb.protocol.CoreDatabaseManager_Create_Req) = call_method(stub.impl, _TypeDB_methods[2], controller, inp)

databases_all(stub::TypeDBStub, controller::ProtoRpcController, inp::typedb.protocol.CoreDatabaseManager_All_Req, done::Function) = call_method(stub.impl, _TypeDB_methods[3], controller, inp, done)
databases_all(stub::TypeDBBlockingStub, controller::ProtoRpcController, inp::typedb.protocol.CoreDatabaseManager_All_Req) = call_method(stub.impl, _TypeDB_methods[3], controller, inp)

database_schema(stub::TypeDBStub, controller::ProtoRpcController, inp::typedb.protocol.CoreDatabase_Schema_Req, done::Function) = call_method(stub.impl, _TypeDB_methods[4], controller, inp, done)
database_schema(stub::TypeDBBlockingStub, controller::ProtoRpcController, inp::typedb.protocol.CoreDatabase_Schema_Req) = call_method(stub.impl, _TypeDB_methods[4], controller, inp)

database_delete(stub::TypeDBStub, controller::ProtoRpcController, inp::typedb.protocol.CoreDatabase_Delete_Req, done::Function) = call_method(stub.impl, _TypeDB_methods[5], controller, inp, done)
database_delete(stub::TypeDBBlockingStub, controller::ProtoRpcController, inp::typedb.protocol.CoreDatabase_Delete_Req) = call_method(stub.impl, _TypeDB_methods[5], controller, inp)

session_open(stub::TypeDBStub, controller::ProtoRpcController, inp::typedb.protocol.Session_Open_Req, done::Function) = call_method(stub.impl, _TypeDB_methods[6], controller, inp, done)
session_open(stub::TypeDBBlockingStub, controller::ProtoRpcController, inp::typedb.protocol.Session_Open_Req) = call_method(stub.impl, _TypeDB_methods[6], controller, inp)

session_close(stub::TypeDBStub, controller::ProtoRpcController, inp::typedb.protocol.Session_Close_Req, done::Function) = call_method(stub.impl, _TypeDB_methods[7], controller, inp, done)
session_close(stub::TypeDBBlockingStub, controller::ProtoRpcController, inp::typedb.protocol.Session_Close_Req) = call_method(stub.impl, _TypeDB_methods[7], controller, inp)

session_pulse(stub::TypeDBStub, controller::ProtoRpcController, inp::typedb.protocol.Session_Pulse_Req, done::Function) = call_method(stub.impl, _TypeDB_methods[8], controller, inp, done)
session_pulse(stub::TypeDBBlockingStub, controller::ProtoRpcController, inp::typedb.protocol.Session_Pulse_Req) = call_method(stub.impl, _TypeDB_methods[8], controller, inp)

transaction(stub::TypeDBStub, controller::ProtoRpcController, inp::Channel{typedb.protocol.Transaction_Client}, done::Function) = call_method(stub.impl, _TypeDB_methods[9], controller, inp, done)
transaction(stub::TypeDBBlockingStub, controller::ProtoRpcController, inp::Channel{typedb.protocol.Transaction_Client}) = call_method(stub.impl, _TypeDB_methods[9], controller, inp)

export TypeDB, TypeDBStub, TypeDBBlockingStub, databases_contains, databases_create, databases_all, database_schema, database_delete, session_open, session_close, session_pulse, transaction
