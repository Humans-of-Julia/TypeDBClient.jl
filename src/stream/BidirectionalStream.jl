# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

mutable struct  BidirectionalStream
    resCollector::ResponseCollector
    dispatcher::Dispatcher
    is_open::Threads.Atomic{Bool}
    input_channel::Channel{Proto.Transaction_Client}
    output_channel::Channel{Proto.Transaction_Server}
    grpc_status::Task
end

function BidirectionalStream(input_channel::Channel{Proto.Transaction_Client},
                             output_channel::Channel{Proto.Transaction_Server},
                             grpc_status::Task)

    dispatcher = Dispatcher(input_channel, grpc_status)
    res_collector = ResponseCollector(output_channel, grpc_status)

    return BidirectionalStream(res_collector, dispatcher, Threads.Atomic{Bool}(true),input_channel, output_channel, grpc_status)
end

function single_request(bidirect_stream::BidirectionalStream, request::T) where {T<: Proto.ProtoType}
    return single_request(bidirect_stream, request, true)
end

"""
function single_request(bidirect_stream::BidirectionalStream, request::T, batch::Bool) where {T<: Proto.ProtoType}
    This function process one single request and give back the results from the server to the calling functions. It is an intern
    function.
"""
function single_request(bidirect_stream::BidirectionalStream, request::Proto.Transaction_Req, batch::Bool)

    res_channel = _open_result_channel(bidirect_stream, request, batch)

    # start a task to collect the results asynchronusly
    task = @async collect_result(res_channel, bidirect_stream.grpc_status)
    result = fetch(task)

    # remove the result channel from the respons collector.
    remove_Id(bidirect_stream.resCollector, request.req_id)

    return result
end

"""
function stream_request(bidirect_stream::BidirectionalStream, request::T, batch::Bool) where {T<: Proto.ProtoType}
    Here we let the user decide what to do with the result channel. The returned value is the pure result_channel.
"""
function stream_request(bidirect_stream::BidirectionalStream, request::Proto.Transaction_Req, batch::Bool)
    res_channel = _open_result_channel(bidirect_stream, request, batch)
    return res_channel
end

function _open_result_channel(bidirect_stream::BidirectionalStream, request::Proto.Transaction_Req, batch::Bool)
    # This function serves as the opener for the result channel for both single- and stream request

    # put the needed request_id on the request
    request.req_id = bytes(uuid4())
    # get the channel which stores the result of the request
    res_channel = newId_result_channel(bidirect_stream.resCollector, request.req_id)

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
function collect_result(res_channel::Channel{Transaction_Res_All}, grpc_status::Task)
    answers = Vector{Transaction_Res_All}()
    while isopen(res_channel)
        yield()
        if isready(res_channel) && !istaskdone(grpc_status)
            tmp_result = take!(res_channel)
            req_push, loop_break = _is_stream_respart_done(tmp_result)

            req_push && push!(answers, tmp_result)
            loop_break && break
        end
        if istaskdone(grpc_status)
            @info "collect_result is done \n
            The grpc_status is: $(fetch(grpc_status))
            "
            break
        end
    end
    return answers
end

@assert precompile(which_oneof, (Proto.Transaction_ResPart, Symbol))
@assert precompile(which_oneof, (Proto.Transaction_Res, Symbol))
"""
function _is_stream_respart_done(req_result::Proto.ProtoType)
    This function decides how to treat the result. It returns whether it should push the
    request to the answers and if it should break the retrieving loop.
"""
function _is_stream_respart_done(req_result::Transaction_Res_All)
    kind_of_content = which_oneof(req_result, :res)
    request_content = getproperty(req_result, kind_of_content)
    type_of_result = typeof(request_content)
    req_push = false
    loop_break = false

    if type_of_result == Proto.Transaction_Stream_ResPart
        if request_content.state == Proto.Transaction_Stream_State[:DONE]
            req_push = false
            loop_break = true
        else
            req_push = true
            loop_break = false
        end
    elseif typeof(req_result) == Proto.Transaction_Res
            req_push = true
            loop_break = true
    elseif typeof(req_result) == Proto.Transaction_ResPart
        req_push = true
        loop_break = false
    end

    return req_push, loop_break
end

@assert precompile(single_request, (BidirectionalStream, Proto.Transaction_Req, Bool))
@assert precompile(_open_result_channel, (BidirectionalStream, Proto.Transaction_Req, Bool))
@assert precompile(collect_result, (Channel{Union{Proto.Transaction_Res,Proto.Transaction_ResPart}}, Task))
@assert precompile(_is_stream_respart_done, (Proto.Transaction_Res, ))
@assert precompile(_is_stream_respart_done, (Proto.Transaction_ResPart, ))


function close(stream::BidirectionalStream)
    close(stream.input_channel)
    close(stream.output_channel)
    close(stream.dispatcher)
    close(stream.resCollector)
    return true
end
