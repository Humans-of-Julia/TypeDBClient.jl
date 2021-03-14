# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

using gRPC
using .grakn

abstract type AbstractSession end
abstract type Session <: AbstractSession end

function _session_type_proto(session_type)
    return Int(session_type)
end

mutable struct _SessionRPC <: AbstractSession
    _pulse_frequency_seconds::Number
    _options
    _address
    _port
    _channel
    _database
    _session_type
    _session_id
    _grpc_stub
    _is_open
    _scheduler
end

mutable struct Scheduler
    session_run::Bool
    session_id::Array{UInt8,1}
    pulse_interval::Int
    grpc_stub::GraknBlockingStub
end

function Session(client::GraknBlockingClient, database::String, options::GraknOptions, session_type)
    init_Session(client, database, options, session_type)
end

function Session(client::GraknBlockingClient, database::String)
    init_Session(client, database, GraknOptions(), grakn.protocol.Session_Type[:DATA])
end

function _SessionRPC(client::GraknBlockingClient, database::String, options::GraknOptions, session_type)
    init_Session(client, database, options, session_type)
end

Base.show(io::IO, session::T) where {T<:AbstractSession} = print(io,"Session - database: $(session._database) server: $(session._address)")

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

    _scheduler = Scheduler(true, _session_id, _pulse_frequency_seconds, _grpc_stub)
    @async _transmit_pulse(_scheduler)

    _SessionRPC(_pulse_frequency_seconds, _options, _address, _port, _channel, _database , _session_type , _session_id,_grpc_stub, _is_open,_scheduler)
end

function transaction(session::T, transaction_type, options=GraknOptions()) where {T<:AbstractSession}
    _options = options === nothing && core()
    return Transaction(session, transaction_type, options)
end

function session_type(session::T) where {T<:AbstractSession}
    session._session_type
end

function database(session::T) where {T<:AbstractSession}
    session._database
end

function is_open(session::T) where {T<:AbstractSession}
    session._is_open
end

function close(session::T) where {T<:AbstractSession}
    if session._is_open
        session._is_open = false
        session._scheduler.session_run = false
        req = grakn.protocol.Session_Close_Req()
        req.session_id = session._session_id
        try
            result = session_close(session._grpc_stub,gRPCController(),req)
        catch ex
            rethrow(ex)
        finally
            close(session._channel)
        end
    end
end

"""
    function _transmit_pulse(scheduler::Scheduler) used to keep the session alive.
        The function meant to be called as @async
"""
function _transmit_pulse(scheduler::Scheduler)
    while scheduler.session_run
        sleep(scheduler.pulse_interval -1)
        pulse_req = grakn.protocol.Session_Pulse_Req()
        pulse_req.session_id = scheduler.session_id
        is_alive = session_pulse(scheduler.grpc_stub, gRPCController(), pulse_req).alive
    end
    @info "Session $(scheduler.session_id) no longer alive"
end
