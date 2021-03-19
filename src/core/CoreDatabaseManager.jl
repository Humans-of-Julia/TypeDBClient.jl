# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.core;
# 
# import grakn.client.api.database.Database;
# import grakn.client.api.database.DatabaseManager;
# import grakn.client.common.GraknClientException;
# import grakn.protocol.GraknGrpc;
# 
# import java.util.List;
# import java.util.stream.Collectors;
# 
# import static grakn.client.common.ErrorMessage.Client.DB_DOES_NOT_EXIST;
# import static grakn.client.common.ErrorMessage.Client.MISSING_DB_NAME;
# import static grakn.client.common.RequestBuilder.Database.allReq;
# import static grakn.client.common.RequestBuilder.Database.containsReq;
# import static grakn.client.common.RequestBuilder.Database.createReq;
# 
# public class CoreDatabaseManager implements DatabaseManager {
#     private final CoreClient client;
#     private final GraknGrpc.GraknBlockingStub blockingGrpcStub;
# 
#     public CoreDatabaseManager(CoreClient client) {
#         this.client = client;
#         blockingGrpcStub = GraknGrpc.newBlockingStub(client.channel());
#     }
# 
#     @Override
#     public boolean contains(String name) {
#         return client.call(() -> blockingGrpcStub.databaseContains(containsReq(nonNull(name))).getContains());
#     }
# 
#     @Override
#     public void create(String name) {
#         client.call(() -> blockingGrpcStub.databaseCreate(createReq(nonNull(name))));
#     }
# 
#     @Override
#     public Database get(String name) {
#         if (contains(name)) return new CoreDatabase(this, name);
#         else throw new GraknClientException(DB_DOES_NOT_EXIST, name);
#     }
# 
#     @Override
#     public List<CoreDatabase> all() {
#         List<String> databases = client.call(() -> blockingGrpcStub.databaseAll(allReq()).getNamesList());
#         return databases.stream().map(name -> new CoreDatabase(this, name)).collect(Collectors.toList());
#     }
# 
#     public CoreClient client() {
#         return client;
#     }
# 
#     public GraknGrpc.GraknBlockingStub blockingGrpcStub() {
#         return blockingGrpcStub;
#     }
# 
#     static String nonNull(String name) {
#         if (name == null) throw new GraknClientException(MISSING_DB_NAME);
#         return name;
#     }
# }
