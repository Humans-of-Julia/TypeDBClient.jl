using TypeDBClient
g = TypeDBClient

client = g.CoreClient("127.0.0.1",1729)
g.create_database(client, "typedb")
sess = g.CoreSession(client, "typedb", g.Proto.Session_Type.SCHEMA, request_timout = Inf)
trans = g.transaction(sess, g.Proto.Transaction_Type.WRITE)

attr_req = g.ConceptManagerRequestBuilder.put_attribute_type_req("is-alive", g.Proto.AttributeType_ValueType.BOOLEAN)
res = g.execute(trans, attr_req)
