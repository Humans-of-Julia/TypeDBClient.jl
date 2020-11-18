```
Starting example by AaronRMatthis

```


connection = GraknClient("localhost:48555")
session = opensession(connection, "social_network")

query = Graql.somequerybuilding()

result = prepare!(session, query, Write())
println(result)
commit(result) #required to persist in Write() case
#why do we need to close a read transaction?
#sure, streams need to be closed, but a read transaction?

close(session)
close(connection)