# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.core;
# 
# import grakn.client.api.database.Database;
# import grakn.client.api.database.DatabaseManager;
# import grakn.client.common.GraknClientException;
# import grakn.client.common.Proto;
# import grakn.protocol.GraknGrpc;
# 
# import java.util.List;
# import java.util.stream.Collectors;
# 
# import static grakn.client.common.ErrorMessage.Client.DB_DOES_NOT_EXIST;
# import static grakn.client.common.ErrorMessage.Client.MISSING_DB_NAME;
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
#     public boolean contains(String n) {
#         return client.call(() -> blockingGrpcStub.databaseContains(
#                 Proto.Database.contains(nonNull(n))
#         ).getContains());
#     }
# 
#     @Override
#     public void create(String n) {
#         client.call(() -> blockingGrpcStub.databaseCreate(Proto.Database.create(nonNull(n))));
#     }
# 
#     @Override
#     public Database get(String name) {
#         if (contains(name)) return new CoreDatabase(this, name);
#         else throw new GraknClientException(DB_DOES_NOT_EXIST.message(name));
#     }
# 
#     @Override
#     public List<CoreDatabase> all() {
#         List<String> databases = client.call(() -> blockingGrpcStub.databaseAll(Proto.Database.all()).getNamesList());
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
