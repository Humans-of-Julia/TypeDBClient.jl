using GraknClient
using gRPC
using Sockets

DefaultAdress = ip"127.0.0.1"
DefaultPort = 1729

cli = GraknBlockingClient(DefaultAdress,DefaultPort)

opt = GraknClient.GraknOptions(5000)

ses = GraknClient.Session(cli, "test", opt, GraknClient.grakn.protocol.Session_Type[:DATA]) 

# sleep(15)

# close(ses)
tra = GraknClient.Transaction(ses, GraknClient.grakn.protocol.Transaction_Type[:READ], opt)


type = GraknClient.transaction_type(tra)

is_open = GraknClient.is_open(tra)

concepts = GraknClient.concepts(tra)

query = GraknClient.query(tra)

logic = GraknClient.logic(tra)