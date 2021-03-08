using GraknClient
using gRPC
using Sockets

DefaultAdress = ip"127.0.0.1"
DefaultPort = 1729

cli = GraknBlockingClient(DefaultAdress,DefaultPort)

opt = GraknClient.GraknOptions(5000)

ses = GraknClient.Session(cli, "test", opt, GraknClient.Session_Type[:SCHEMA]) 

tra = GraknClient.Transaction(ses, GraknClient.Transaction_Type[:READ], opt)