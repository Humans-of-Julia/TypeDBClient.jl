# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

const BATCH_WINDOW_SMALL_MILLIS = 1
const BATCH_WINDOW_LARGE_MILLIS = 3

mutable struct Dispatcher
    input_channel::Channel{Proto.Transaction_Client}
    direct_dispatch_channel::Channel{Proto.ProtoType}
    dispatch_channel::Channel{Proto.ProtoType}
    dispatch_timer::Optional{Vector{Timer}}
end


function Dispatcher(input_channel::Channel{Proto.Transaction_Client})
    direct_dispatch_channel = Channel{Proto.ProtoType}(10)
    dispatch_channel = Channel{Proto.ProtoType}(10)

    disp_timer = Vector{Timer}()
    for _ in 1:3
        push!(disp_timer, batch_requests(dispatch_channel,input_channel))
    end

    for _ in 1:2
        Threads.@spawn process_direct_requests(direct_dispatch_channel, input_channel)
    end

    return Dispatcher(input_channel, direct_dispatch_channel, dispatch_channel,disp_timer)
end

"""
function process_direct_requests(in_channel::Channel{Proto.ProtoType}, out_channel::Channel{Proto.Transaction_Client})
    This function process the incoming request directly to the server
"""
function process_direct_requests(in_channel::Channel{Proto.ProtoType}, out_channel::Channel{Proto.Transaction_Client})

    while isopen(in_channel)
        yield()
        # if the grpc connection shows an error or is terminated for the channel
        # the loop will exited
        tmp_res = nothing
            if isready(in_channel)
                try
                    tmp_res = take!(in_channel)
                 catch ex
                    @info "take impossible"
                    @info ex
                 end
            end
            if tmp_res !== nothing
                client_res = TransactionRequestBuilder.client_msg([tmp_res])
                put!(out_channel, client_res)
            end
    end
    @debug "process_direct_requests was closed"
end

"""
function batch_requests(in_channel::Channel{Proto.ProtoType}, out_channel::Channel{Proto.Transaction_Client})
    This function contains the whole logic for batching incomming requests. The inner runner function will be
    called every x ms and will send the collected request in one Transaction_Client message to teh server.
"""
function batch_requests(in_channel::Channel{Proto.ProtoType}, out_channel::Channel{Proto.Transaction_Client})
    time_to_run = BATCH_WINDOW_SMALL_MILLIS / 1000

    function runner(controller)
        @async sleeper(controller)
        answers = Proto.Transaction_Req[]
        try
            while controller.running
                yield()
                if isready(in_channel)
                    tmp_res = take!(in_channel)
                    push!(answers, tmp_res)
                end
            end
            if length(answers) > 0
                put!(out_channel, TransactionRequestBuilder.client_msg(answers))
            end
        catch ex
            throw(TypeDBClientException("batch_requests runner failure",ex))
        end
    end

    cb(timer) = (runner(Controller(true, time_to_run)))
    t = Timer(cb,time_to_run, interval = time_to_run)
    wait(t)

    return t
end

function close(dispatcher::Dispatcher)
    safe_close(dispatcher.direct_dispatch_channel)
    safe_close(dispatcher.dispatch_channel)
    safe_close(dispatcher.dispatch_timer)
end
