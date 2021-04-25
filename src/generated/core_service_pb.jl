# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

# service methods for GraknCore
const _GraknCore_methods = MethodDescriptor[
        MethodDescriptor("databases_contains", 1, grakn.protocol.CoreDatabaseManager_Contains_Req, grakn.protocol.CoreDatabaseManager_Contains_Res),
        MethodDescriptor("databases_create", 2, grakn.protocol.CoreDatabaseManager_Create_Req, grakn.protocol.CoreDatabaseManager_Create_Res),
        MethodDescriptor("databases_all", 3, grakn.protocol.CoreDatabaseManager_All_Req, grakn.protocol.CoreDatabaseManager_All_Res),
        MethodDescriptor("database_schema", 4, grakn.protocol.CoreDatabase_Schema_Req, grakn.protocol.CoreDatabase_Schema_Res),
        MethodDescriptor("database_delete", 5, grakn.protocol.CoreDatabase_Delete_Req, grakn.protocol.CoreDatabase_Delete_Res),
        MethodDescriptor("session_open", 6, grakn.protocol.Session_Open_Req, grakn.protocol.Session_Open_Res),
        MethodDescriptor("session_close", 7, grakn.protocol.Session_Close_Req, grakn.protocol.Session_Close_Res),
        MethodDescriptor("session_pulse", 8, grakn.protocol.Session_Pulse_Req, grakn.protocol.Session_Pulse_Res),
        MethodDescriptor("transaction", 9, Channel{grakn.protocol.Transaction_Client}, Channel{grakn.protocol.Transaction_Server})
    ] # const _GraknCore_methods
const _GraknCore_desc = ServiceDescriptor("grakn.protocol.GraknCore", 1, _GraknCore_methods)

GraknCore(impl::Module) = ProtoService(_GraknCore_desc, impl)

mutable struct GraknCoreStub <: AbstractProtoServiceStub{false}
    impl::ProtoServiceStub
    GraknCoreStub(channel::ProtoRpcChannel) = new(ProtoServiceStub(_GraknCore_desc, channel))
end # mutable struct GraknCoreStub

mutable struct GraknCoreBlockingStub <: AbstractProtoServiceStub{true}
    impl::ProtoServiceBlockingStub
    GraknCoreBlockingStub(channel::ProtoRpcChannel) = new(ProtoServiceBlockingStub(_GraknCore_desc, channel))
end # mutable struct GraknCoreBlockingStub

databases_contains(stub::GraknCoreStub, controller::ProtoRpcController, inp::grakn.protocol.CoreDatabaseManager_Contains_Req, done::Function) = call_method(stub.impl, _GraknCore_methods[1], controller, inp, done)
databases_contains(stub::GraknCoreBlockingStub, controller::ProtoRpcController, inp::grakn.protocol.CoreDatabaseManager_Contains_Req) = call_method(stub.impl, _GraknCore_methods[1], controller, inp)

databases_create(stub::GraknCoreStub, controller::ProtoRpcController, inp::grakn.protocol.CoreDatabaseManager_Create_Req, done::Function) = call_method(stub.impl, _GraknCore_methods[2], controller, inp, done)
databases_create(stub::GraknCoreBlockingStub, controller::ProtoRpcController, inp::grakn.protocol.CoreDatabaseManager_Create_Req) = call_method(stub.impl, _GraknCore_methods[2], controller, inp)

databases_all(stub::GraknCoreStub, controller::ProtoRpcController, inp::grakn.protocol.CoreDatabaseManager_All_Req, done::Function) = call_method(stub.impl, _GraknCore_methods[3], controller, inp, done)
databases_all(stub::GraknCoreBlockingStub, controller::ProtoRpcController, inp::grakn.protocol.CoreDatabaseManager_All_Req) = call_method(stub.impl, _GraknCore_methods[3], controller, inp)

database_schema(stub::GraknCoreStub, controller::ProtoRpcController, inp::grakn.protocol.CoreDatabase_Schema_Req, done::Function) = call_method(stub.impl, _GraknCore_methods[4], controller, inp, done)
database_schema(stub::GraknCoreBlockingStub, controller::ProtoRpcController, inp::grakn.protocol.CoreDatabase_Schema_Req) = call_method(stub.impl, _GraknCore_methods[4], controller, inp)

database_delete(stub::GraknCoreStub, controller::ProtoRpcController, inp::grakn.protocol.CoreDatabase_Delete_Req, done::Function) = call_method(stub.impl, _GraknCore_methods[5], controller, inp, done)
database_delete(stub::GraknCoreBlockingStub, controller::ProtoRpcController, inp::grakn.protocol.CoreDatabase_Delete_Req) = call_method(stub.impl, _GraknCore_methods[5], controller, inp)

session_open(stub::GraknCoreStub, controller::ProtoRpcController, inp::grakn.protocol.Session_Open_Req, done::Function) = call_method(stub.impl, _GraknCore_methods[6], controller, inp, done)
session_open(stub::GraknCoreBlockingStub, controller::ProtoRpcController, inp::grakn.protocol.Session_Open_Req) = call_method(stub.impl, _GraknCore_methods[6], controller, inp)

session_close(stub::GraknCoreStub, controller::ProtoRpcController, inp::grakn.protocol.Session_Close_Req, done::Function) = call_method(stub.impl, _GraknCore_methods[7], controller, inp, done)
session_close(stub::GraknCoreBlockingStub, controller::ProtoRpcController, inp::grakn.protocol.Session_Close_Req) = call_method(stub.impl, _GraknCore_methods[7], controller, inp)

session_pulse(stub::GraknCoreStub, controller::ProtoRpcController, inp::grakn.protocol.Session_Pulse_Req, done::Function) = call_method(stub.impl, _GraknCore_methods[8], controller, inp, done)
session_pulse(stub::GraknCoreBlockingStub, controller::ProtoRpcController, inp::grakn.protocol.Session_Pulse_Req) = call_method(stub.impl, _GraknCore_methods[8], controller, inp)

transaction(stub::GraknCoreStub, controller::ProtoRpcController, inp::Channel{grakn.protocol.Transaction_Client}, done::Function) = call_method(stub.impl, _GraknCore_methods[9], controller, inp, done)
transaction(stub::GraknCoreBlockingStub, controller::ProtoRpcController, inp::Channel{grakn.protocol.Transaction_Client}) = call_method(stub.impl, _GraknCore_methods[9], controller, inp)

export GraknCore, GraknCoreStub, GraknCoreBlockingStub, databases_contains, databases_create, databases_all, database_schema, database_delete, session_open, session_close, session_pulse, transaction
