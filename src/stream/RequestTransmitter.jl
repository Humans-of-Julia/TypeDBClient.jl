# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

const BATCH_WINDOW_SMALL_MILLIS = 1
const BATCH_WINDOW_LARGE_MILLIS = 3

mutable struct Dispatcher
    input_channel::Channel{Proto.Transaction_Client}
    direct_dispatch_channel::Channel{Proto.ProtoType}
    dispatch_channel::Channel{Proto.ProtoType}
    dispatch_timer::Optional{Timer}
end


function Dispatcher(input_channel::Channel{Proto.Transaction_Client})
    direct_dispatch_channel = Channel{Proto.ProtoType}(10)
    dispatch_channel = Channel{Proto.ProtoType}(10)
    disp_timer = batch_requests(dispatch_channel,input_channel)
    process_direct_requests(direct_dispatch_channel, input_channel)

    return Dispatcher(input_channel, direct_dispatch_channel, dispatch_channel,disp_timer)
end

"""
function process_direct_requests(in_channel::Channel{Proto.ProtoType}, out_channel::Channel{Proto.Transaction_Client})
    This function process the incoming request directly to the server
"""
function process_direct_requests(in_channel::Channel{Proto.ProtoType}, out_channel::Channel{Proto.Transaction_Client})
    @async begin
        while isopen(in_channel)
            yield()
            # if the grpc connection shows an error or is terminated for the channel
            # the loop will exited
            try
                if isready(in_channel)
                    tmp_res = take!(in_channel)
                    client_res = TransactionRequestBuilder.client_msg([tmp_res])
                    Threads.@spawn put!(out_channel,client_res)
                end
            catch ex
                @info "process_direct_requests shows an error"
            finally
            end
        end
        @debug "process_direct_requests was closed"
    end
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
    close(dispatcher.direct_dispatch_channel)
    close(dispatcher.dispatch_channel)
    close(dispatcher.dispatch_timer)
    return true
end
