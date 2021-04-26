# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

const PULSE_INTERVAL_MILLIS = 5000

mutable struct  CoreSession <: AbstractCoreSession
    client::CoreClient
    database::CoreDatabase
    sessionID::Bytes
    transactions::Dict{UUID,T} where {T<:Union{Nothing,<:AbstractCoreTransaction}}
    type::Int
    accessLock::ReentrantLock
    options::TypeDBOptions
    isOpen::Bool
    networkLatencyMillis::Int
    timer::Optional{Controller}
    request_timeout::Real
end

Base.show(io::IO, session::T) where {T<:AbstractCoreSession} = print(io, session)
Base.print(io::IO, session::T) where {T<:AbstractCoreSession} = print(io, "Session(ID: $(bytes2hex(session.sessionID)))")

function CoreSession(client::T,
                     database::String,
                     type::Int32,
                     options::TypeDBOptions = TypeDBOptions();
                     request_timout::Real=6) where {T<:AbstractCoreClient}
   # try
        #options.session_idle_timeout_millis = PULSE_INTERVAL_MILLIS + 1000
        #building open_request
        open_req = SessionRequestBuilder.open_req(
            database, type , copy_to_proto(options, Proto.Options)
        )
        # open the session
        startTime = now()
        grpc_controller = gRPCController()
        req_result, status  = session_open(client.core_stub.blockingStub, grpc_controller, open_req)
        res_id = grpc_result_or_error(req_result, status, result->result.session_id)
        endTime = now()

        database = CoreDatabase(database)
        networkLatencyMillis = (endTime - startTime).value
        session_id =  res_id
        transactions = Dict{UUID,AbstractCoreTransaction}()
        is_open = true

        t = Controller(true, 0.5)

        result = CoreSession(client, database, session_id, transactions, type, ReentrantLock() ,options, is_open, networkLatencyMillis, t, request_timout)

        make_pulse_request(result, t)

        # the following transaction is useless for the construction of the the Session
        # and is only to initialize the first compilation of the ProtoBuf machinary
        # underneath the transaction. In the environment here it is possible to control
        # the tick of the pulse request a close as can be. If somebody find a way to
        # avoid the long starting time of the transaction this can be removed.
        trans = nothing
        try
            trans = transaction(result, Proto.Transaction_Type[:READ])
        catch ex
            @info "First attempt for transaction done and not successful"
        finally
        end
        if trans !== nothing
            close(trans)
        end

        t.duration_in_seconds =  (PULSE_INTERVAL_MILLIS / 1000) - 0.5

        return result
    # catch ex
    #     throw(TypeDBClientException("Error construct a CoreSession",ex))
    # end
end

"""
function make_pulse_request(session::T) where {T<:AbstractCoreSession}
    This function make a pulse request to keep the session alive.
"""
function make_pulse_request(session::T, controller::Controller) where {T<:AbstractCoreSession}

    @async begin
            while controller.running
                    try
                        pulsreq = SessionRequestBuilder.pulse_req(session.sessionID)
                        req_result, status = session_pulse(session.client.core_stub.blockingStub, gRPCController() , pulsreq)
                        result = grpc_result_or_error(req_result,status, result->result)
                        @debug "Time: $(Dates.now())"

                        if result.alive === false
                            close(session)
                            @info "$session is closed"
                        end
                    catch ex
                        @info "make_pulse_request show's an error \n
                        $ex "
                        close(session)
                    finally
                    end
                    sleep(controller.duration_in_seconds)
            end
        end
end


function transaction(session::T, type::Int32) where {T<:AbstractCoreSession}
    return transaction(session, type, typedb_options_core())
end

function transaction(session::T, type::Int32, options::TypeDBOptions) where {T<:AbstractCoreSession}
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

function close(session::T) where {T<:AbstractCoreSession}
    try
        lock(session.accessLock)
        if session.isOpen
            for (uuid,trans) in session.transactions
                close(trans)
                delete!(session.transactions, trans.transaction_id)
            end
            remove_session(session.client, session)
            close(session.timer)

            req = SessionRequestBuilder.close_req(session.sessionID)
            stub = session.client.core_stub.blockingStub
            session_close(stub, gRPCController(), req )

            session.isOpen = false
        end
    catch  ex
        throw(TypeDBClientException("Unexpected error while closing session ID: $(session.sessionID)",ex))
        @info ex
    finally
        unlock(session.accessLock)
    end
end



#
# package typedb.client.core;
#
# import com.google.protobuf.ByteString;
# import typedb.client.api.TypeDBOptions;
# import typedb.client.api.TypeDBSession;
# import typedb.client.api.TypeDBTransaction;
# import typedb.client.common.exception.TypeDBClientException;
# import typedb.client.common.rpc.TypeDBStub;
# import typedb.client.stream.RequestTransmitter;
# import typedb.common.collection.ConcurrentSet;
# import typedb.protocol.SessionProto;
# import io.grpc.StatusRuntimeException;
#
# import java.time.Duration;
# import java.time.Instant;
# import java.util.Timer;
# import java.util.TimerTask;
# import java.util.concurrent.atomic.AtomicBoolean;
# import java.util.concurrent.locks.ReadWriteLock;
# import java.util.concurrent.locks.StampedLock;
#
# import static typedb.client.common.exception.ErrorMessage.Client.SESSION_CLOSED;
# import static typedb.client.common.rpc.RequestBuilder.Session.closeReq;
# import static typedb.client.common.rpc.RequestBuilder.Session.openReq;
# import static typedb.client.common.rpc.RequestBuilder.Session.pulseReq;
#
# public class CoreSession implements TypeDBSession {
#
#     private static final int PULSE_INTERVAL_MILLIS = 5_000;
#
#     private final CoreClient client;
#     private final CoreDatabase database;
#     private final ByteString sessionID;
#     private final ConcurrentSet<TypeDBTransaction.Extended> transactions;
#     private final Type type;
#     private final TypeDBOptions options;
#     private final Timer pulse;
#     private final ReadWriteLock accessLock;
#     private final AtomicBoolean isOpen;
#     private final int networkLatencyMillis;
#
#     public CoreSession(CoreClient client, String database, Type type, TypeDBOptions options) {
#         try {
#             this.client = client;
#             this.type = type;
#             this.options = options;
#             Instant startTime = Instant.now();
#             SessionProto.Session.Open.Res res = client.stub().sessionOpen(
#                     openReq(database, type.proto(), options.proto())
#             );
#             Instant endTime = Instant.now();
#             this.database = new CoreDatabase(client.databases(), database);
#             networkLatencyMillis = (int) (Duration.between(startTime, endTime).toMillis() - res.getServerDurationMillis());
#             sessionID = res.getSessionId();
#             transactions = new ConcurrentSet<>();
#             accessLock = new StampedLock().asReadWriteLock();
#             isOpen = new AtomicBoolean(true);
#             pulse = new Timer();
#             pulse.scheduleAtFixedRate(this.new PulseTask(), 0, PULSE_INTERVAL_MILLIS);
#         } catch (StatusRuntimeException e) {
#             throw TypeDBClientException.of(e);
#         }
#     }
#
#     @Override
#     public boolean isOpen() { return isOpen.get(); }
#
#     @Override
#     public Type type() { return type; }
#
#     @Override
#     public CoreDatabase database() { return database; }
#
#     @Override
#     public TypeDBOptions options() { return options; }
#
#     @Override
#     public TypeDBTransaction transaction(TypeDBTransaction.Type type) {
#         return transaction(type, TypeDBOptions.core());
#     }
#
#     @Override
#     public TypeDBTransaction transaction(TypeDBTransaction.Type type, TypeDBOptions options) {
#         try {
#             accessLock.readLock().lock();
#             if (!isOpen.get()) throw new TypeDBClientException(SESSION_CLOSED);
#             TypeDBTransaction.Extended transactionRPC = new CoreTransaction(this, sessionID, type, options);
#             transactions.add(transactionRPC);
#             return transactionRPC;
#         } finally {
#             accessLock.readLock().unlock();
#         }
#     }
#
#     ByteString id() { return sessionID; }
#
#     TypeDBStub.Core stub() {
#         return client.stub();
#     }
#
#     RequestTransmitter transmitter() {
#         return client.transmitter();
#     }
#
#     int networkLatencyMillis() { return networkLatencyMillis; }
#
#     @Override
#     public void close() {
#         try {
#             accessLock.writeLock().lock();
#             if (isOpen.compareAndSet(true, false)) {
#                 transactions.forEach(TypeDBTransaction.Extended::close);
#                 client.removeSession(this);
#                 pulse.cancel();
#                 try {
#                     SessionProto.Session.Close.Res ignore = stub().sessionClose(closeReq(sessionID));
#                 } catch (StatusRuntimeException e) {
#                     // Most likely the session is already closed or the server is no longer running.
#                 }
#             }
#         } catch (StatusRuntimeException e) {
#             throw TypeDBClientException.of(e);
#         } finally {
#             accessLock.writeLock().unlock();
#         }
#     }
#
#     private class PulseTask extends TimerTask {
#
#         @Override
#         public void run() {
#             if (!isOpen()) return;
#             boolean alive;
#             try {
#                 alive = stub().sessionPulse(pulseReq(sessionID)).getAlive();
#             } catch (StatusRuntimeException exception) {
#                 alive = false;
#             }
#             if (!alive) {
#                 isOpen.set(false);
#                 pulse.cancel();
#             }
#         }
#     }
# }
