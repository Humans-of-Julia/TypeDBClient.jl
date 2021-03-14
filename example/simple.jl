using GraknClient

client = GraknBlockingClient()
session = Session(client, "phone_calls")
txn = Transaction(session, TransactionType.READ, GraknOptions())
close(txn)
close(session)
close(client)
