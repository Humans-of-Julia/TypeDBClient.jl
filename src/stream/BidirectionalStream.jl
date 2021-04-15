# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

mutable struct  BidirectionalStream
    resCollector::ResponseCollector
    dispatcher::Dispatcher
    is_open::Threads.Atomic{Bool}
    input_channel::Channel{Proto.Transaction_Client}
    output_channel::Channel{Proto.Transaction_Server}
end

function BidirectionalStream(input_channel::Channel{Proto.Transaction_Client},
                             output_channel::Channel{Proto.Transaction_Server})

    dispatcher = Dispatcher(input_channel)

    res_collector = ResponseCollector(output_channel)

    return BidirectionalStream(res_collector, dispatcher, Threads.Atomic{Bool}(true),input_channel, output_channel)
end


function single_request(bidirect_stream::BidirectionalStream, request::T) where {T<: Proto.ProtoType}
    return single_request(bidirect_stream, request, true)
end


function single_request(bidirect_stream::BidirectionalStream, request::T, batch::Bool) where {T<: Proto.ProtoType}

    # # get the channel which stores the result of the request
    res_channel = newId_result_channel(bidirect_stream.resCollector, request)

    # direct the request to the right channel direct or batched processing
    if batch
        Threads.@spawn put!(bidirect_stream.dispatcher.dispatch_channel, request)
    else
        @info "single request direct put"
        Threads.@spawn put!(bidirect_stream.dispatcher.direct_dispatch_channel, request)
    end

    # # start a task to collect the results asynchronusly
    task = Threads.@spawn collect_result(bidirect_stream)

    # wait until the result is back
    result = fetch(task)

    # remove the result channel from the respons collector.
    remove_Id(bidirect_stream, request.req_id)

    return result
end

"""
function collect_result(res_channel::Channel{T}) where {T<:ProtoProtoType}
    The function will be called for each single request. She works until
    the whole result set will be collected.
"""
function collect_result(bidirect_stream::BidirectionalStream)
    answers = Vector{Proto.ProtoType}()
    res_channel = bidirect_stream.output_channel
    while true
        yield()
        if isready(res_channel)
            @info "collect result in"
            tmp_result = take!(res_channel)

            if typeof(tmp_result) == Transaction_Res_All
                push!(answers, tmp_result)
            elseif typeof(tmp_result) == Proto.Transaction_Res
                push!(answers, tmp_result)
                break
            elseif typeof(tmp_result) == Proto.Transaction_Stream_ResPart
                if tmp_result.state == Proto.Transaction_Stream_State[:DONE]
                    break
                else
                    push!(answers, tmp_result)
                end
            end
        end
    end
    return answers
end


function close(stream::BidirectionalStream)
    close(stream.input_channel)
    close(stream.output_channel)
    close(stream.dispatcher)
    close(stream.resCollector)
    return true
end

#
# package grakn.client.stream;
#
# import grakn.client.common.exception.GraknClientException;
# import grakn.client.common.rpc.GraknStub;
# import grakn.protocol.TransactionProto.Transaction.Req;
# import grakn.protocol.TransactionProto.Transaction.Res;
# import grakn.protocol.TransactionProto.Transaction.ResPart;
# import grakn.protocol.TransactionProto.Transaction.Server;
# import io.grpc.StatusRuntimeException;
# import io.grpc.stub.StreamObserver;
#
# import javax.annotation.Nullable;
# import java.util.UUID;
# import java.util.concurrent.atomic.AtomicBoolean;
# import java.util.stream.Stream;
# import java.util.stream.StreamSupport;
#
# import static grakn.client.common.exception.ErrorMessage.Client.UNKNOWN_REQUEST_ID;
# import static grakn.client.common.exception.ErrorMessage.Internal.ILLEGAL_ARGUMENT;
# import static java.util.Spliterator.IMMUTABLE;
# import static java.util.Spliterator.ORDERED;
# import static java.util.Spliterators.spliteratorUnknownSize;
#
# public class BidirectionalStream implements AutoCloseable {
#
#     private final ResponseCollector<Res> resCollector;
#     private final ResponseCollector<ResPart> resPartCollector;
#     private final RequestTransmitter.Dispatcher dispatcher;
#     private final AtomicBoolean isOpen;
#
#     public BidirectionalStream(GraknStub.Core stub, RequestTransmitter transmitter) {
#         resPartCollector = new ResponseCollector<>();
#         resCollector = new ResponseCollector<>();
#         isOpen = new AtomicBoolean(false);
#         dispatcher = transmitter.dispatcher(stub.transaction(new ResponseObserver()));
#         isOpen.set(true);
#     }
#
#     public Single<Res> single(Req.Builder request, boolean batch) {
#         UUID requestID = UUID.randomUUID();
#         Req req = request.setReqId(requestID.toString()).build();
#         ResponseCollector.Queue<Res> queue = resCollector.queue(requestID);
#         if (batch) dispatcher.dispatch(req);
#         else dispatcher.dispatchNow(req);
#         return new Single<>(queue);
#     }
#
#     public Stream<ResPart> stream(Req.Builder request) {
#         UUID requestID = UUID.randomUUID();
#         ResponseCollector.Queue<ResPart> collector = resPartCollector.queue(requestID);
#         dispatcher.dispatch(request.setReqId(requestID.toString()).build());
#         ResponseIterator iterator = new ResponseIterator(requestID, collector, dispatcher);
#         return StreamSupport.stream(spliteratorUnknownSize(iterator, ORDERED | IMMUTABLE), false);
#     }
#
#     public boolean isOpen() {
#         return isOpen.get();
#     }
#
#     private void collect(Res res) {
#         UUID requestID = UUID.fromString(res.getReqId());
#         ResponseCollector.Queue<Res> collector = resCollector.get(requestID);
#         if (collector != null) collector.put(res);
#         else throw new GraknClientException(UNKNOWN_REQUEST_ID, requestID);
#     }
#
#     private void collect(ResPart resPart) {
#         UUID requestID = UUID.fromString(resPart.getReqId());
#         ResponseCollector.Queue<ResPart> collector = resPartCollector.get(requestID);
#         if (collector != null) collector.put(resPart);
#         else throw new GraknClientException(UNKNOWN_REQUEST_ID, requestID);
#     }
#
#     @Override
#     public void close() {
#         close(null);
#     }
#
#     private void close(@Nullable StatusRuntimeException error) {
#         if (isOpen.compareAndSet(true, false)) {
#             resCollector.close(error);
#             resPartCollector.close(error);
#             try {
#                 dispatcher.close();
#             } catch (StatusRuntimeException e) {
#                 throw GraknClientException.of(e);
#             }
#         }
#     }
#
#     public static class Single<T> {
#
#         private final ResponseCollector.Queue<T> queue;
#
#         public Single(ResponseCollector.Queue<T> queue) {
#             this.queue = queue;
#         }
#
#         public T get() {
#             return queue.take();
#         }
#     }
#
#     private class ResponseObserver implements StreamObserver<Server> {
#
#         @Override
#         public void onNext(Server serverMsg) {
#             if (!isOpen.get()) return;
#
#             switch (serverMsg.getServerCase()) {
#                 case RES:
#                     collect(serverMsg.getRes());
#                     break;
#                 case RES_PART:
#                     collect(serverMsg.getResPart());
#                     break;
#                 default:
#                 case SERVER_NOT_SET:
#                     throw new GraknClientException(ILLEGAL_ARGUMENT);
#             }
#         }
#
#         @Override
#         public void onError(Throwable t) {
#             assert t instanceof StatusRuntimeException : "The server sent an exception of unexpected type " + t.getClass();
#             // TODO: this isn't nice - an error from one request isn't really appropriate for all of them (see #180)
#             close((StatusRuntimeException) t);
#         }
#
#         @Override
#         public void onCompleted() {
#             close();
#         }
#     }
# }
