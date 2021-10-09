# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

mutable struct  BidirectionalStream
    resCollector::ResponseCollector
    dispatcher::Dispatcher
    is_open::Threads.Atomic{Bool}
    input_channel::Channel{Proto.Transaction_Client}
    output_channel::Channel{Proto.Transaction_Server}
    status::Task
    error_break_time::Real
end

function BidirectionalStream(input_channel::Channel{Proto.Transaction_Client},
                             output_channel::Channel{Proto.Transaction_Server},
                             status::Task;
                             error_break_time::Real)

    dispatcher = Dispatcher(input_channel)
    res_collector = ResponseCollector(output_channel)

    return BidirectionalStream(res_collector, dispatcher, Threads.Atomic{Bool}(true),input_channel, output_channel, status, error_break_time)
end

function single_request(bidirect_stream::BidirectionalStream, request::Proto.ProtoType)
    return single_request(bidirect_stream, request, true)
end

"""
function single_request(bidirect_stream::BidirectionalStream, request::T, batch::Bool) where {T<: Proto.ProtoType}
    This function process one single request and give back the results from the server to the calling functions. It is an intern
    function.
"""
function single_request(bidirect_stream::BidirectionalStream, request::Proto.Transaction_Req, batch::Bool)
    answer = _process_request(bidirect_stream, request, batch)
    return isempty(answer) ? nothing : answer[1]
end

"""
function stream_request(bidirect_stream::BidirectionalStream, request::T, batch::Bool) where {T<: Proto.ProtoType}
    Here we let the user decide what to do with the result channel. The returned value is the pure result_channel.
"""
function stream_request(bidirect_stream::BidirectionalStream, request::Proto.Transaction_Req, batch::Bool)
    answer = _process_request(bidirect_stream, request, batch)
    return answer
end

# ToDo: Make the request timout determined by user at session level as a default and in the transaction level
function _process_request(bidirect_stream::BidirectionalStream, request::Proto.Transaction_Req, batch::Bool)

    res_channel = _open_result_channel(bidirect_stream, request, batch)
    # start a task to collect the results asynchronusly
    result_task = Threads.@spawn collect_result(res_channel, bidirect_stream, request.req_id)

    # until solving the absent possibility to detect grpc errors in the gRPCClient a pure time
    # dependent solutionresult = nothing
    answer = Vector{Transaction_Res_All}()
    contr = Controller(true, bidirect_stream.error_break_time)
    @async sleeper(contr)
    while contr.running
        yield()
        if istaskdone(result_task)
            answer = fetch(result_task)
            break
        end
    end

    if !istaskdone(result_task)
        close(bidirect_stream.input_channel)
        failure_stat = fetch(bidirect_stream.status)
        close(bidirect_stream)
        try
            gRPCCheck(failure_stat)
        catch ex
            throw(TypeDBClientException(ex))
        end
    end

    return answer
end

function _open_result_channel(bidirect_stream::BidirectionalStream, request::Proto.Transaction_Req, batch::Bool)
    # This function serves as the opener for the result channel for both single- and stream request

    # put the needed request_id on the request
    request.req_id = bytes(uuid4())
    # get the channel which stores the result of the request
    res_channel = push!(bidirect_stream.resCollector, request.req_id)

    # direct the request to the right channel direct or batched processing
    if batch
        put!(bidirect_stream.dispatcher.dispatch_channel, request)
    else
        put!(bidirect_stream.dispatcher.direct_dispatch_channel, request)
    end
    return res_channel
end

"""
function collect_result(res_channel::Channel{T}) where {T<:ProtoProtoType}
    The function will be called for each single request. She works until
    the whole result set will be collected.
"""
function collect_result(res_channel::Channel{Transaction_Res_All}, bidirect_stream::BidirectionalStream, request_id::Bytes)
    answers = Vector{Transaction_Res_All}()
    for tmp_result in res_channel
        req_push, loop_break = _is_stream_respart_done(tmp_result, bidirect_stream)
        req_push && push!(answers, tmp_result)
        if loop_break
            delete!(bidirect_stream.resCollector, request_id)
            break
        end
    end
    return answers
end

"""
function _is_stream_respart_done(req_result::Proto.ProtoType)
    This function decides how to treat the result. It returns whether it should push the
    request to the answers and if it should break the retrieving loop.
"""
function _is_stream_respart_done(req_result::Transaction_Res_All, bidirect_stream::BidirectionalStream)
    kind_of_content = Proto.which_oneof(req_result, :res)
    request_content = getproperty(req_result, kind_of_content)
    type_of_result = typeof(request_content)
    req_push = false
    loop_break = false

    if type_of_result == Proto.Transaction_Stream_ResPart
        if request_content.state == Proto.Transaction_Stream_State[:DONE]
            req_push = false
            loop_break = true
        else
            req_push = false
            loop_break = false
            # if the Stream_State is :CONTINUE put a Stream requ on the dispatch_channel
            put!(bidirect_stream.dispatcher.direct_dispatch_channel,
                  TransactionRequestBuilder.stream_req(req_result.req_id))
        end
    elseif typeof(req_result) == Proto.Transaction_Res
            req_push = true
            loop_break = true
            @debug "answer to req_id: $(req_result.req_id)"
    elseif typeof(req_result) == Proto.Transaction_ResPart
        req_push = true
        loop_break = false
        @debug "answer to req_id: $(req_result.req_id)"
    else
        throw(TypeDBClientException("Not known result type"))
    end

    return req_push, loop_break
end


function close(stream::BidirectionalStream)
    safe_close(stream.dispatcher)
    task_to_close = @async begin
        while true
            yield()
            isempty(stream.resCollector.collectors) && break
            for (k,v) in stream.resCollector.collectors
                delete!(stream.resCollector.collectors, k)
            end
        end
    end
    wait(task_to_close)
    safe_close(stream.resCollector)
    return true
end
