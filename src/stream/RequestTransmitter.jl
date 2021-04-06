# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

const BATCH_WINDOW_SMALL_MILLIS = 1
const BATCH_WINDOW_LARGE_MILLIS = 3

mutable struct Dispatcher
    input_channel::Channel
end

mutable struct Executor

        # private final ConcurrentSet<Dispatcher> dispatchers;
        # private final AtomicBoolean isRunning;
        # private final Semaphore permissionToRun;

end

mutable struct RequestTransmitter
    #private static final Logger LOG = LoggerFactory.getLogger(RequestTransmitter.class);
    executors::Union{Nothing, Vector{Executor}}
    executorIndex::Int
    accessLock::ReentrantLock
    is_open::Bool
end

RequestTransmitter() = RequestTransmitter(nothing, 0, ReentrantLock(), true)

function RequestTransmitter(session::T) where {T<:AbstractCoreSession}
    executors = Vector{Executor}()
    index = 0
    accesLock = ReentrantLock()
    is_open = true
    return RequestTransmitter(executors, index, accesLock, is_open)
end

function session_transmitter(session::T) where {T<:AbstractCoreSession}
    return RequestTransmitter(session)
end


#
# package grakn.client.stream;
#
# import grakn.client.common.exception.GraknClientException;
# import grakn.client.common.rpc.RequestBuilder;
# import grakn.common.collection.ConcurrentSet;
# import grakn.common.concurrent.NamedThreadFactory;
# import grakn.protocol.TransactionProto;
# import io.grpc.stub.StreamObserver;
# import org.slf4j.Logger;
# import org.slf4j.LoggerFactory;
#
# import java.util.ArrayList;
# import java.util.concurrent.ConcurrentLinkedQueue;
# import java.util.concurrent.Semaphore;
# import java.util.concurrent.ThreadFactory;
# import java.util.concurrent.atomic.AtomicBoolean;
# import java.util.concurrent.atomic.AtomicInteger;
# import java.util.concurrent.locks.ReadWriteLock;
# import java.util.concurrent.locks.StampedLock;
#
# import static grakn.client.common.exception.ErrorMessage.Client.CLIENT_CLOSED;
#
# public class RequestTransmitter implements AutoCloseable {
#
#     private static final Logger LOG = LoggerFactory.getLogger(RequestTransmitter.class);
#     private static final int BATCH_WINDOW_SMALL_MILLIS = 1;
#     private static final int BATCH_WINDOW_LARGE_MILLIS = 3;
#
#     private final ArrayList<Executor> executors;
#     private final AtomicInteger executorIndex;
#     private final ReadWriteLock accessLock;
#     private volatile boolean isOpen;
#
#     public RequestTransmitter(int parallelisation, NamedThreadFactory threadFactory) {
#         this.executors = new ArrayList<>(parallelisation);
#         this.executorIndex = new AtomicInteger(0);
#         this.accessLock = new StampedLock().asReadWriteLock();
#         this.isOpen = true;
#         for (int i = 0; i < parallelisation; i++) this.executors.add(new Executor(threadFactory));
#     }
#
#     private Executor nextExecutor() {
#         return executors.get(executorIndex.getAndUpdate(i -> {
#             i++;
#             if (i % executors.size() == 0) i = 0;
#             return i;
#         }));
#     }
#
#     public Dispatcher dispatcher(StreamObserver<TransactionProto.Transaction.Client> requestObserver) {
#         try {
#             accessLock.readLock().lock();
#             if (!isOpen) throw new GraknClientException(CLIENT_CLOSED);
#             Executor executor = nextExecutor();
#             Dispatcher dispatcher = new Dispatcher(executor, requestObserver);
#             executor.dispatchers.add(dispatcher);
#             return dispatcher;
#         } finally {
#             accessLock.readLock().unlock();
#         }
#     }
#
#     @Override
#     public void close() {
#         try {
#             accessLock.writeLock().lock();
#             if (isOpen) {
#                 isOpen = false;
#                 executors.forEach(Executor::close);
#             }
#         } finally {
#             accessLock.writeLock().unlock();
#         }
#     }
#
#     private class Executor implements AutoCloseable {
#
#         private final ConcurrentSet<Dispatcher> dispatchers;
#         private final AtomicBoolean isRunning;
#         private final Semaphore permissionToRun;
#
#         private Executor(ThreadFactory threadFactory) {
#             dispatchers = new ConcurrentSet<>();
#             isRunning = new AtomicBoolean(false);
#             permissionToRun = new Semaphore(0);
#             threadFactory.newThread(this::run).start();
#         }
#
#         private void mayStartRunning() {
#             if (isRunning.compareAndSet(false, true)) permissionToRun.release();
#         }
#
#         private void run() {
#             while (isOpen) {
#                 try {
#                     permissionToRun.acquire();
#                     boolean first = true;
#                     while (true) {
#                         Thread.sleep(first ? BATCH_WINDOW_SMALL_MILLIS : BATCH_WINDOW_LARGE_MILLIS);
#                         if (dispatchers.isEmpty()) break;
#                         else dispatchers.forEach(Dispatcher::sendBatchedRequests);
#                         first = false;
#                     }
#                 } catch (InterruptedException e) {
#                     LOG.error(e.getMessage(), e);
#                 } finally {
#                     isRunning.set(false);
#                 }
#                 if (!dispatchers.isEmpty()) mayStartRunning();
#             }
#         }
#
#         @Override
#         public void close() {
#             dispatchers.forEach(Dispatcher::close);
#             mayStartRunning();
#         }
#     }
#
#     public class Dispatcher implements AutoCloseable {
#
#         private final Executor executor;
#         private final StreamObserver<TransactionProto.Transaction.Client> requestObserver;
#         private final ConcurrentLinkedQueue<TransactionProto.Transaction.Req> requestQueue;
#
#         private Dispatcher(Executor executor, StreamObserver<TransactionProto.Transaction.Client> requestObserver) {
#             this.executor = executor;
#             this.requestObserver = requestObserver;
#             requestQueue = new ConcurrentLinkedQueue<>();
#         }
#
#         private synchronized void sendBatchedRequests() {
#             if (requestQueue.isEmpty() || !isOpen) return;
#             TransactionProto.Transaction.Req request;
#             while ((request = requestQueue.poll()) != null) requests.add(request);
#             requestObserver.onNext(RequestBuilder.Transaction.clientMsg(requests));
#         }
#
#         public void dispatch(TransactionProto.Transaction.Req requestProto) {
#             try {
#                 accessLock.readLock().lock();
#                 if (!isOpen) throw new GraknClientException(CLIENT_CLOSED);
#                 requestQueue.add(requestProto);
#                 executor.mayStartRunning();
#             } finally {
#                 accessLock.readLock().unlock();
#             }
#         }
#
#         public void dispatchNow(TransactionProto.Transaction.Req requestProto) {
#             try {
#                 accessLock.readLock().lock();
#                 if (!isOpen) throw new GraknClientException(CLIENT_CLOSED);
#                 requestQueue.add(requestProto);
#                 sendBatchedRequests();
#             } finally {
#                 accessLock.readLock().unlock();
#             }
#         }
#
#         @Override
#         public void close() {
#             requestObserver.onCompleted();
#             executor.dispatchers.remove(this);
#         }
#     }
# }
