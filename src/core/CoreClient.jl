# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

mutable struct CoreClient <: AbstractCoreClient
    #private static final String GRAKN_CLIENT_RPC_THREAD_NAME = "grakn-client-rpc"
    channel::gRPCClient.gRPCChannel
    address::String
    Port::Int
    core_stub::Core_GraknStub
    transmitter::RequestTransmitter
    databaseMgr::CoreDatabaseManager
    sessions::Dict{String, Union{<:AbstractCoreSession, Nothing}}
end

Base.show(io::IO, core_client::CoreClient) = Base.print(io,core_client)
Base.print(io::IO, core_client::CoreClient) = Base.print(io, "CoreClient($(print(core_client.channel))")

function CoreClient(address::String, port::Int)
    # NamedThreadFactory threadFactory = NamedThreadFactory.create(GRAKN_CLIENT_RPC_THREAD_NAME);
    channel = gRPCChannel(address * ":" * string(port))
    stub = Core_GraknStub(channel)
    transmitter = RequestTransmitter()
    databaseMgr = CoreDatabaseManager()
    sessions = Dict{String, Union{<:AbstractCoreSession, Nothing}}()
    return CoreClient(channel,address, port, stub,transmitter,databaseMgr,sessions)
end


function transmitter(client::T) where {T<:AbstractCoreClient}
    client.transmitter
end

function remove_session(client::T, session::R) where {T<:AbstractCoreClient, R<:AbstractCoreSession}
    delete!(client.sessions, session.sessionID)
end


#
# package grakn.client.core;
#
# import com.google.protobuf.ByteString;
# import grakn.client.api.GraknClient;
# import grakn.client.api.GraknOptions;
# import grakn.client.api.GraknSession;
# import grakn.client.common.exception.GraknClientException;
# import grakn.client.common.rpc.GraknStub;
# import grakn.client.stream.RequestTransmitter;
# import grakn.common.concurrent.NamedThreadFactory;
# import io.grpc.ManagedChannel;
# import io.grpc.ManagedChannelBuilder;
#
# import java.util.concurrent.ConcurrentHashMap;
# import java.util.concurrent.ConcurrentMap;
# import java.util.concurrent.TimeUnit;
#
# import static grakn.client.common.exception.ErrorMessage.Internal.ILLEGAL_CAST;
# import static grakn.common.util.Objects.className;
#
# public class CoreClient implements GraknClient {
#
#     private static final String GRAKN_CLIENT_RPC_THREAD_NAME = "grakn-client-rpc";
#
#     private final ManagedChannel channel;
#     private final GraknStub.Core stub;
#     private final RequestTransmitter transmitter;
#     private final CoreDatabaseManager databaseMgr;
#     private final ConcurrentMap<ByteString, CoreSession> sessions;
#
#     public CoreClient(String address) {
#         this(address, calculateParallelisation());
#     }
#
#     public CoreClient(String address, int parallelisation) {
#         NamedThreadFactory threadFactory = NamedThreadFactory.create(GRAKN_CLIENT_RPC_THREAD_NAME);
#         channel = ManagedChannelBuilder.forTarget(address).usePlaintext().build();
#         stub = GraknStub.core(channel);
#         transmitter = new RequestTransmitter(parallelisation, threadFactory);
#         databaseMgr = new CoreDatabaseManager(this);
#         sessions = new ConcurrentHashMap<>();
#     }
#
#     public static int calculateParallelisation() {
#         int cores = Runtime.getRuntime().availableProcessors();
#         if (cores <= 4) return 2;
#         else if (cores <= 9) return 3;
#         else if (cores <= 16) return 4;
#         else return (int) Math.ceil(cores / 4.0);
#     }
#
#     @Override
#     public CoreSession session(String database, GraknSession.Type type) {
#         return session(database, type, GraknOptions.core());
#     }
#
#     @Override
#     public CoreSession session(String database, GraknSession.Type type, GraknOptions options) {
#         CoreSession session = new CoreSession(this, database, type, options);
#         assert !sessions.containsKey(session.id());
#         sessions.put(session.id(), session);
#         return session;
#     }
#
#     @Override
#     public CoreDatabaseManager databases() {
#         return databaseMgr;
#     }
#
#     @Override
#     public boolean isOpen() {
#         return !channel.isShutdown();
#     }
#
#     @Override
#     public boolean isCluster() {
#         return false;
#     }
#
#     @Override
#     public Cluster asCluster() {
#         throw new GraknClientException(ILLEGAL_CAST, className(GraknClient.Cluster.class));
#     }
#
#     public ManagedChannel channel() {
#         return channel;
#     }
#
#     GraknStub.Core stub() {
#         return stub;
#     }
#
#     RequestTransmitter transmitter() {
#         return transmitter;
#     }
#
#     void removeSession(CoreSession session) {
#         sessions.remove(session.id());
#     }
#
#     @Override
#     public void close() {
#         try {
#             sessions.values().forEach(CoreSession::close);
#             channel.shutdown().awaitTermination(10, TimeUnit.SECONDS);
#             transmitter.close();
#         } catch (InterruptedException e) {
#             Thread.currentThread().interrupt();
#         }
#     }
# }
