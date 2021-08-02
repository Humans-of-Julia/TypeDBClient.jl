# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

const PULSE_INTERVAL_MILLIS = 5000

mutable struct  CoreSession <: AbstractCoreSession
    client::CoreClient
    database::CoreDatabase
    sessionID::Bytes
    transactions::Dict{UUID,T} where {T<:Union{Nothing,<:AbstractCoreTransaction}}
    type::Int32
    accessLock::ReentrantLock
    options::TypeDBOptions
    isOpen::Bool
    networkLatencyMillis::Int
    timer::Optional{Controller}
    request_timeout::Real
end

Base.show(io::IO, session::T) where {T<:AbstractCoreSession} = print(io, "Session(ID: $(bytes2hex(session.sessionID)))")

function CoreSession(client::T,
                     database::String,
                     type::Int32,
                     options::TypeDBOptions = TypeDBOptions();
                     request_timout::Real=6) where {T<:AbstractCoreClient}
    try
        #building open_request
        open_req = SessionRequestBuilder.open_req(
            database, type , copy_to_proto(options, Proto.Options)
        )
        # open the session
        startTime = now()
        grpc_controller = gRPCController()
        req_result, status  = Proto.session_open(client.core_stub.blockingStub, grpc_controller, open_req)
        res_id = grpc_result_or_error(req_result, status, result->result.session_id)
        endTime = now()

        database = CoreDatabase(database)
        networkLatencyMillis = (endTime - startTime).value
        session_id =  res_id
        transactions = Dict{UUID,AbstractCoreTransaction}()
        is_open = true

        t = Controller(true, 0.5)

        result = CoreSession(client, database, session_id, transactions, type, ReentrantLock() ,options, is_open, networkLatencyMillis, t, request_timout)

        # initialize the ongoing pulse request
        make_pulse_request(result, t)

        # add the session to the client
        client.sessions[session_id] = result

        # the following transaction is useless for the construction of the the Session
        # and is only to initialize the first compilation of the ProtoBuf machinary
        # underneath the transaction. In the environment here it is possible to control
        # the tick of the pulse request a close as can be. If somebody find a way to
        # avoid the long starting time of the transaction this can be removed.
        trans = nothing
        try
            trans = transaction(result, Proto.Transaction_Type[:READ])
        catch ex
            @debug "First attempt for transaction done and not successful"
        end
        trans !== nothing && close(trans)

        t.duration_in_seconds =  (PULSE_INTERVAL_MILLIS / 1000) - 0.5

        return result
    catch ex
        throw(TypeDBClientException("Error construct a CoreSession",ex))
    end
end

"""
    make_pulse_request(session::T) where {T<:AbstractCoreSession}

This function make a pulse request to keep the session alive.
"""
function make_pulse_request(session::AbstractCoreSession, controller::Controller)
    @async begin
        while controller.running
            try
                pulsreq = SessionRequestBuilder.pulse_req(session.sessionID)
                req_result, status = Proto.session_pulse(session.client.core_stub.blockingStub, gRPCController() , pulsreq)
                result = grpc_result_or_error(req_result,status, result->result)
                @debug "Time: $(Dates.now())"

                if result.alive === false
                    close(session, false)
                    @debug "$session is closed"
                end
            catch ex
                close(session)
                throw(ex)
            end
            sleep(controller.duration_in_seconds)
        end
    end
end

transaction(session::AbstractCoreSession, type::EnumType) = transaction(session, type, typedb_options_core())
function transaction(session::AbstractCoreSession, type::EnumType, options::TypeDBOptions)
    try
        lock(session.accessLock)
        if !session.isOpen
            throw(TypeDBClientException(CLIENT_SESSION_CLOSED, bytes2hex(session.sessionID)))
        end

        transactionRPC = CoreTransaction(session, session.sessionID, type, options)
        session.transactions[transactionRPC.transaction_id] = transactionRPC

        return transactionRPC
    finally
       unlock(session.accessLock)
    end
end

function close(session::AbstractCoreSession, session_alive::Bool=true)
    try
        lock(session.accessLock)
        if session.isOpen
            for (_,trans) in session.transactions
                safe_close(trans)
            end
            remove_session(session.client, session)
            safe_close(session.timer)

            if session_alive === true
                req = SessionRequestBuilder.close_req(session.sessionID)
                stub = session.client.core_stub.blockingStub
                Proto.session_close(stub, gRPCController(), req )
            end

            session.isOpen = false
        end
    catch ex
        if ex isa gRPCServiceCallException
            @info "Session with id: $(session.sessionID) isn't open on the server"
        else
            @error TypeDBClientException("Unexpected error while closing session ID: $(session.sessionID)",ex)
        end
    finally
        unlock(session.accessLock)
    end
    return true
end

function Base.delete!(session::AbstractCoreSession, trans_id::UUID)
    try
        lock(session.accessLock)
        delete!(session.transactions, trans_id)
    finally
        unlock(session.accessLock)
    end
end

function is_open(session::AbstractCoreSession)
    return session.isOpen
end
