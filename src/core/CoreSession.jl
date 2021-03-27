# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

const PULSE_INTERVAL_MILLIS = 5000

mutable struct  CoreSession <: AbstractCoreSession
    client::CoreClient
    database::CoreDatabase
    sessionID::Array{UInt8,1}
    transactions::Array{Union{Nothing,<:AbstractCoreTransaction},1}
    type::Int
    options::GraknOptions
# Timer pulse
# ReadWriteLock accessLock
    isOpen::Bool
    networkLatencyMillis::Int
end

Base.show(io::IO, session::T) where {T<:AbstractCoreSession} = Base.print(io, session)
Base.print(io::IO, session::T) where {T<:AbstractCoreSession} = Base.print(io, "Session(ID: $(session.sessionID))")

function CoreSession(client::T, database::String , type::Int32 , options::GraknOptions) where {T<:AbstractCoreClient}
    # try
        options.session_idle_timeout_millis = PULSE_INTERVAL_MILLIS
        open_req = session_open_req(database, type , copy_to_proto(options, grakn.protocol.Options))
        startTime = now()
        res = session_open(client.core_stub.blockingStub, gRPCController(), open_req)
        endTime = now()

        database = CoreDatabase(database)
        networkLatencyMillis = (endTime - startTime).value
        session_id = res.session_id
        transactions = Array{Union{Nothing,<:AbstractCoreTransaction},1}(nothing,0)
        is_open = true

        result = CoreSession(client, database, session_id, transactions, type, options, is_open, networkLatencyMillis)

        @async start_pulse(result, PULSE_INTERVAL_MILLIS)

        return result
    # catch ex
    #     throw(GraknClientException("Error construct a CoreSession",ex))
    # end
end

function start_pulse(session::T, pulse_time::Int) where {T<:AbstractCoreSession}
    while session.isOpen
        make_pulse_request(session)
        sleep(pulse_time - 1)
    end
end

function make_pulse_request(session::T) where {T<:AbstractCoreSession}
    pulsreq = session_pulse_req(session.sessionID)
    if session.isOpen
        result = session_pulse(session.client.core_stub.blockingStub, gRPCController() , pulsreq)
        if !result.alive
            session.isOpen = false
        end
    end
end




#
# package grakn.client.core;
#
# import com.google.protobuf.ByteString;
# import grakn.client.api.GraknOptions;
# import grakn.client.api.GraknSession;
# import grakn.client.api.GraknTransaction;
# import grakn.client.common.exception.GraknClientException;
# import grakn.client.common.rpc.GraknStub;
# import grakn.client.stream.RequestTransmitter;
# import grakn.common.collection.ConcurrentSet;
# import grakn.protocol.SessionProto;
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
# import static grakn.client.common.exception.ErrorMessage.Client.SESSION_CLOSED;
# import static grakn.client.common.rpc.RequestBuilder.Session.closeReq;
# import static grakn.client.common.rpc.RequestBuilder.Session.openReq;
# import static grakn.client.common.rpc.RequestBuilder.Session.pulseReq;
#
# public class CoreSession implements GraknSession {
#
#     private static final int PULSE_INTERVAL_MILLIS = 5_000;
#
#     private final CoreClient client;
#     private final CoreDatabase database;
#     private final ByteString sessionID;
#     private final ConcurrentSet<GraknTransaction.Extended> transactions;
#     private final Type type;
#     private final GraknOptions options;
#     private final Timer pulse;
#     private final ReadWriteLock accessLock;
#     private final AtomicBoolean isOpen;
#     private final int networkLatencyMillis;
#
#     public CoreSession(CoreClient client, String database, Type type, GraknOptions options) {
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
#             throw GraknClientException.of(e);
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
#     public GraknOptions options() { return options; }
#
#     @Override
#     public GraknTransaction transaction(GraknTransaction.Type type) {
#         return transaction(type, GraknOptions.core());
#     }
#
#     @Override
#     public GraknTransaction transaction(GraknTransaction.Type type, GraknOptions options) {
#         try {
#             accessLock.readLock().lock();
#             if (!isOpen.get()) throw new GraknClientException(SESSION_CLOSED);
#             GraknTransaction.Extended transactionRPC = new CoreTransaction(this, sessionID, type, options);
#             transactions.add(transactionRPC);
#             return transactionRPC;
#         } finally {
#             accessLock.readLock().unlock();
#         }
#     }
#
#     ByteString id() { return sessionID; }
#
#     GraknStub.Core stub() {
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
#                 transactions.forEach(GraknTransaction.Extended::close);
#                 client.removeSession(this);
#                 pulse.cancel();
#                 try {
#                     SessionProto.Session.Close.Res ignore = stub().sessionClose(closeReq(sessionID));
#                 } catch (StatusRuntimeException e) {
#                     // Most likely the session is already closed or the server is no longer running.
#                 }
#             }
#         } catch (StatusRuntimeException e) {
#             throw GraknClientException.of(e);
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
