using .grakn.protocol

const DEFAULT_GRAKN_GRPC_PORT = 1729

struct GraknBlockingClient
    controller::gRPCController
    client::gRPCClient
    grakn_stub::GraknBlockingStub
    databases::DatabaseManager
    address::IPAddr
    port::Int
end

GraknBlockingClient(port::Integer = DEFAULT_GRAKN_GRPC_PORT) = GraknBlockingClient(ip"127.0.0.1", port)
GraknBlockingClient(address::String, port::Integer) = GraknBlockingClient(Sockets.parse(IPAddr , address), port)
function GraknBlockingClient(ip::IPAddr, port::Integer)
    controller = gRPCController()
    try 
        client = gRPCClient(ip, port)
        databases = DatabaseManager(client.channel)
        grakn_blocking_stub = stub(client, GraknBlockingStub)
        GraknBlockingClient(controller, client, grakn_blocking_stub, databases, ip, port)
    catch ex
        if typeof(ex) == Base.IOError
            throw(GraknClientException("Connection could not established. Proof the address, port and the accessibility of the server \n 
                                       for more Information refer to the stored exception in this exception"))
        end
    end
end

show(io::IO, grakn::GraknBlockingClient) = print(io,"Grakn(", grakn.client.sock, ")")
close(grakn::GraknBlockingClient) = close(grakn.client)

############### Handling gRPC #####################
function grpc_channel(grakn_client::GraknBlockingClient)
    grakn_client.client.channel
end