# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

# service methods for Grakn
const _Grakn_methods = MethodDescriptor[
        MethodDescriptor("database_contains", 1, grakn.protocol.Database_Contains_Req, grakn.protocol.Database_Contains_Res),
        MethodDescriptor("database_create", 2, grakn.protocol.Database_Create_Req, grakn.protocol.Database_Create_Res),
        MethodDescriptor("database_all", 3, grakn.protocol.Database_All_Req, grakn.protocol.Database_All_Res),
        MethodDescriptor("database_delete", 4, grakn.protocol.Database_Delete_Req, grakn.protocol.Database_Delete_Res),
        MethodDescriptor("session_open", 5, grakn.protocol.Session_Open_Req, grakn.protocol.Session_Open_Res),
        MethodDescriptor("session_close", 6, grakn.protocol.Session_Close_Req, grakn.protocol.Session_Close_Res),
        MethodDescriptor("session_pulse", 7, grakn.protocol.Session_Pulse_Req, grakn.protocol.Session_Pulse_Res),
        MethodDescriptor("transaction", 8, Channel{grakn.protocol.Transaction_Req}, Channel{grakn.protocol.Transaction_Res}),
        MethodDescriptor("transaction_open", 9, grakn.protocol.Transaction_Req, grakn.protocol.Transaction_Res)
    ] # const _Grakn_methods
const _Grakn_desc = ServiceDescriptor("grakn.protocol.Grakn", 1, _Grakn_methods)

Grakn(impl::Module) = ProtoService(_Grakn_desc, impl)

mutable struct GraknStub <: AbstractProtoServiceStub{false}
    impl::ProtoServiceStub
    GraknStub(channel::ProtoRpcChannel) = new(ProtoServiceStub(_Grakn_desc, channel))
end # mutable struct GraknStub

mutable struct GraknBlockingStub <: AbstractProtoServiceStub{true}
    impl::ProtoServiceBlockingStub
    GraknBlockingStub(channel::ProtoRpcChannel) = new(ProtoServiceBlockingStub(_Grakn_desc, channel))
end # mutable struct GraknBlockingStub

database_contains(stub::GraknStub, controller::ProtoRpcController, inp::grakn.protocol.Database_Contains_Req, done::Function) = call_method(stub.impl, _Grakn_methods[1], controller, inp, done)
database_contains(stub::GraknBlockingStub, controller::ProtoRpcController, inp::grakn.protocol.Database_Contains_Req) = call_method(stub.impl, _Grakn_methods[1], controller, inp)

database_create(stub::GraknStub, controller::ProtoRpcController, inp::grakn.protocol.Database_Create_Req, done::Function) = call_method(stub.impl, _Grakn_methods[2], controller, inp, done)
database_create(stub::GraknBlockingStub, controller::ProtoRpcController, inp::grakn.protocol.Database_Create_Req) = call_method(stub.impl, _Grakn_methods[2], controller, inp)

database_all(stub::GraknStub, controller::ProtoRpcController, inp::grakn.protocol.Database_All_Req, done::Function) = call_method(stub.impl, _Grakn_methods[3], controller, inp, done)
database_all(stub::GraknBlockingStub, controller::ProtoRpcController, inp::grakn.protocol.Database_All_Req) = call_method(stub.impl, _Grakn_methods[3], controller, inp)

database_delete(stub::GraknStub, controller::ProtoRpcController, inp::grakn.protocol.Database_Delete_Req, done::Function) = call_method(stub.impl, _Grakn_methods[4], controller, inp, done)
database_delete(stub::GraknBlockingStub, controller::ProtoRpcController, inp::grakn.protocol.Database_Delete_Req) = call_method(stub.impl, _Grakn_methods[4], controller, inp)

session_open(stub::GraknStub, controller::ProtoRpcController, inp::grakn.protocol.Session_Open_Req, done::Function) = call_method(stub.impl, _Grakn_methods[5], controller, inp, done)
session_open(stub::GraknBlockingStub, controller::ProtoRpcController, inp::grakn.protocol.Session_Open_Req) = call_method(stub.impl, _Grakn_methods[5], controller, inp)

session_close(stub::GraknStub, controller::ProtoRpcController, inp::grakn.protocol.Session_Close_Req, done::Function) = call_method(stub.impl, _Grakn_methods[6], controller, inp, done)
session_close(stub::GraknBlockingStub, controller::ProtoRpcController, inp::grakn.protocol.Session_Close_Req) = call_method(stub.impl, _Grakn_methods[6], controller, inp)

session_pulse(stub::GraknStub, controller::ProtoRpcController, inp::grakn.protocol.Session_Pulse_Req, done::Function) = call_method(stub.impl, _Grakn_methods[7], controller, inp, done)
session_pulse(stub::GraknBlockingStub, controller::ProtoRpcController, inp::grakn.protocol.Session_Pulse_Req) = call_method(stub.impl, _Grakn_methods[7], controller, inp)

transaction(stub::GraknStub, controller::ProtoRpcController, inp::Channel{grakn.protocol.Transaction_Req}, done::Function) = call_method(stub.impl, _Grakn_methods[8], controller, inp, done)
transaction(stub::GraknBlockingStub, controller::ProtoRpcController, inp::Channel{grakn.protocol.Transaction_Req}) = call_method(stub.impl, _Grakn_methods[8], controller, inp)

transaction_open(stub::GraknStub, controller::ProtoRpcController, inp::grakn.protocol.Transaction_Req, done::Function) = call_method(stub.impl, _Grakn_methods[9], controller, inp, done)
transaction_open(stub::GraknBlockingStub, controller::ProtoRpcController, inp::grakn.protocol.Transaction_Req) = call_method(stub.impl, _Grakn_methods[9], controller, inp)

export Grakn, GraknStub, GraknBlockingStub, database_contains, database_create, database_all, database_delete, session_open, session_close, session_pulse, transaction, transaction_open
