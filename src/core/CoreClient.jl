# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

mutable struct CoreClient <: AbstractCoreClient
    #private static final String GRAKN_CLIENT_RPC_THREAD_NAME = "typedb-client-rpc"
    channel::gRPCClient.gRPCChannel
    address::String
    port::Int
    core_stub::Core_TypeDBStub
    databaseMgr::CoreDatabaseManager
    sessions::Dict{String, Union{<:AbstractCoreSession, Nothing}}
end

Base.show(io::IO, core_client::CoreClient) = print(io,core_client)
Base.print(io::IO, core_client::CoreClient) = print(io, "CoreClient(address: $(core_client.address):$(core_client.port))")

function CoreClient(address::String, port::Int)
    channel = gRPCChannel(address * ":" * string(port))
    stub = Core_TypeDBStub(channel)
    databaseMgr = CoreDatabaseManager()
    sessions = Dict{String, Union{<:AbstractCoreSession, Nothing}}()
    return CoreClient(channel,address, port, stub, databaseMgr,sessions)
end

function is_cluster(client::T) where {T<:AbstractCoreClient}
    return false
end

function remove_session(client::T, session::R) where {T<:AbstractCoreClient, R<:AbstractCoreSession}
    delete!(client.sessions, session.sessionID)
end


#
# package typedb.client.core;
#
# import com.google.protobuf.ByteString;
# import typedb.client.api.TypeDBClient;
# import typedb.client.api.TypeDBOptions;
# import typedb.client.api.TypeDBSession;
# import typedb.client.common.exception.TypeDBClientException;
# import typedb.client.common.rpc.TypeDBStub;
# import typedb.client.stream.RequestTransmitter;
# import typedb.common.concurrent.NamedThreadFactory;
# import io.grpc.ManagedChannel;
# import io.grpc.ManagedChannelBuilder;
#
# import java.util.concurrent.ConcurrentHashMap;
# import java.util.concurrent.ConcurrentMap;
# import java.util.concurrent.TimeUnit;
#
# import static typedb.client.common.exception.ErrorMessage.Internal.ILLEGAL_CAST;
# import static typedb.common.util.Objects.className;
#
# public class CoreClient implements TypeDBClient {
#
#     private static final String GRAKN_CLIENT_RPC_THREAD_NAME = "typedb-client-rpc";
#
#     private final ManagedChannel channel;
#     private final TypeDBStub.Core stub;
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
#         stub = TypeDBStub.core(channel);
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
#     public CoreSession session(String database, TypeDBSession.Type type) {
#         return session(database, type, TypeDBOptions.core());
#     }
#
#     @Override
#     public CoreSession session(String database, TypeDBSession.Type type, TypeDBOptions options) {
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
#         throw new TypeDBClientException(ILLEGAL_CAST, className(TypeDBClient.Cluster.class));
#     }
#
#     public ManagedChannel channel() {
#         return channel;
#     }
#
#     TypeDBStub.Core stub() {
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
