# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

mutable struct ResponseCollector
    collectors::Dict{Bytes,Channel{Transaction_Res_All}}
    transact_result_channel::Channel{Proto.Transaction_Server}
    access_lock::ReentrantLock
end


function ResponseCollector(transact_result_channel::Channel{Proto.Transaction_Server})
    collectors = Dict{Bytes,Channel{Transaction_Res_All}}()
    access_lock = ReentrantLock()
    resp_col = ResponseCollector(collectors, transact_result_channel, access_lock)
    res_task = @async response_worker(resp_col)
    return resp_col
end

"""
newId_result_channel(resp_collector::ResponsCollector, request::T) where {T<:Proto.ProtoType}
    Function is meant to give back the result_channel in which the results for one request
    will be collected.
    Attention! Don't put a new Id manually on the ResponsCollector. It wouldn't be thread safe
"""
function newId_result_channel(resp_collector::ResponseCollector, req_id::Bytes)
    res_channel = Channel{Transaction_Res_All}(10)
    try
        lock(resp_collector.access_lock)
        resp_collector.collectors[req_id] = res_channel
    catch
    finally
        unlock(resp_collector.access_lock)
    end
    return res_channel
end

"""
function remove_Id(resp_collector::ResponsCollector, id::Bytes)
    The function will close the collecting result channel and remove
    this from the the resonse collector.
    Attention! Don't remove a result_channel manually from the Dictionary.
    This will not be thread safe.
"""
function remove_Id(resp_collector::ResponseCollector, id::Bytes)
    try
        lock(resp_collector.access_lock)
        close(resp_collector.collectors[id])
        delete!(resp_collector.collectors, id)
    catch
    finally
        unlock(resp_collector.access_lock)
    end
end

function response_worker(response_collector::ResponseCollector)
    resp_chan = response_collector.transact_result_channel
    collectors = response_collector.collectors
    while isopen(resp_chan)
        yield()
        try
            if isready(resp_chan)
                req_result = take!(resp_chan)
                tmp_result = _process_Transaction_Server(req_result)
                put!(collectors[tmp_result.req_id], tmp_result)
            end
        catch ex
            @info "response_worker shows an error \n
                   $ex"
        finally
        end
    end
end

function _process_Transaction_Server(input::Proto.Transaction_Server)
    kind_of_respond = Proto.which_oneof(input,:server)
    result = getproperty(input, kind_of_respond)
    return result
end

function close(res_collector::ResponseCollector)
    #close the resul channels which are open
    close.(values(res_collector.collectors))
end




#
# package grakn.client.stream;
#
# import grakn.client.common.exception.GraknClientException;
# import grakn.common.collection.Either;
# import io.grpc.StatusRuntimeException;
#
# import javax.annotation.Nullable;
# import java.util.Optional;
# import java.util.UUID;
# import java.util.concurrent.BlockingQueue;
# import java.util.concurrent.ConcurrentHashMap;
# import java.util.concurrent.ConcurrentMap;
# import java.util.concurrent.LinkedBlockingQueue;
#
# import static grakn.client.common.exception.ErrorMessage.Client.TRANSACTION_CLOSED;
# import static grakn.client.common.exception.ErrorMessage.Internal.UNEXPECTED_INTERRUPTION;
#
# public class ResponseCollector<R> {
#
#     private final ConcurrentMap<UUID, Queue<R>> collectors;
#
#     public ResponseCollector() {
#         collectors = new ConcurrentHashMap<>();
#     }
#
#     public synchronized Queue<R> queue(UUID requestId) {
#         Queue<R> collector = new Queue<>();
#         collectors.put(requestId, collector);
#         return collector;
#     }
#
#     public Queue<R> get(UUID requestId) {
#         return collectors.get(requestId);
#     }
#
#     public synchronized void close(@Nullable StatusRuntimeException error) {
#         collectors.values().forEach(collector -> collector.close(error));
#         collectors.clear();
#     }
#
#     public static class Queue<R> {
#
#         private final BlockingQueue<Either<Response<R>, Done>> responseQueue;
#
#         Queue() {
#             responseQueue = new LinkedBlockingQueue<>();
#         }
#
#         public R take() {
#             try {
#                 Either<Response<R>, Done> response = responseQueue.take();
#                 if (response.isFirst()) return response.first().message();
#                 else if (!response.second().error().isPresent()) throw new GraknClientException(TRANSACTION_CLOSED);
#                 else throw GraknClientException.of(response.second().error().get());
#             } catch (InterruptedException e) {
#                 throw new GraknClientException(UNEXPECTED_INTERRUPTION);
#             }
#         }
#
#         public void put(R response) {
#             responseQueue.add(Either.first(new Response<>(response)));
#         }
#
#         public void close(@Nullable StatusRuntimeException error) {
#             responseQueue.add(Either.second(new Done(error)));
#         }
#
#         private static class Response<R> {
#
#             @Nullable
#             private final R value;
#
#             private Response(@Nullable R value) {
#                 this.value = value;
#             }
#
#             @Nullable
#             private R message() {
#                 return value;
#             }
#         }
#
#         private static class Done {
#             @Nullable
#             private final StatusRuntimeException error;
#
#             private Done(StatusRuntimeException error) {
#                 this.error = error;
#             }
#
#             private Optional<StatusRuntimeException> error() {
#                 return Optional.ofNullable(error);
#             }
#         }
#     }
# }
