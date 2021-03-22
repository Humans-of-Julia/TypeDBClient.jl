# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.core;
# 
# import grakn.client.api.database.Database;
# import grakn.client.api.database.DatabaseManager;
# import grakn.client.common.exception.GraknClientException;
# import grakn.client.common.rpc.GraknStub;
# 
# import java.util.List;
# 
# import static grakn.client.common.exception.ErrorMessage.Client.DB_DOES_NOT_EXIST;
# import static grakn.client.common.exception.ErrorMessage.Client.MISSING_DB_NAME;
# import static grakn.client.common.rpc.RequestBuilder.Core.DatabaseManager.allReq;
# import static grakn.client.common.rpc.RequestBuilder.Core.DatabaseManager.containsReq;
# import static grakn.client.common.rpc.RequestBuilder.Core.DatabaseManager.createReq;
# import static java.util.stream.Collectors.toList;
# 
# public class CoreDatabaseManager implements DatabaseManager {
# 
#     private final CoreClient client;
# 
#     public CoreDatabaseManager(CoreClient client) {
#         this.client = client;
#     }
# 
#     @Override
#     public Database get(String name) {
#         if (contains(name)) return new CoreDatabase(this, name);
#         else throw new GraknClientException(DB_DOES_NOT_EXIST, name);
#     }
# 
#     @Override
#     public boolean contains(String name) {
#         return stub().databasesContains(containsReq(nonNull(name))).getContains();
#     }
# 
#     @Override
#     public void create(String name) {
#         stub().databasesCreate(createReq(nonNull(name)));
#     }
# 
#     @Override
#     public List<CoreDatabase> all() {
#         List<String> databases = stub().databasesAll(allReq()).getNamesList();
#         return databases.stream().map(name -> new CoreDatabase(this, name)).collect(toList());
#     }
# 
#     GraknStub.Core stub() {
#         return client.stub();
#     }
# 
#     static String nonNull(String name) {
#         if (name == null) throw new GraknClientException(MISSING_DB_NAME);
#         return name;
#     }
# }
