# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE

mutable struct TypeDBOptions
    infer::Optional{Bool}
    trace_inference::Optional{Bool}
    explain::Optional{Bool}
    parallel::Optional{Bool}
    batch_size::Optional{Int}
    prefetch::Optional{Bool}
    session_idle_timeout_millis::Optional{Int}
    schema_lock_acquire_timeout_millis::Optional{Int}
end

function TypeDBOptions()
    return TypeDBOptions(nothing,nothing,nothing,nothing,nothing,nothing,nothing,nothing)
end

function typedb_options_core()
    return TypeDBOptions()
end

#
# package typedb.client.api;
#
# import typedb.client.common.exception.TypeDBClientException;
# import typedb.protocol.OptionsProto;
#
# import javax.annotation.CheckReturnValue;
# import java.util.Optional;
#
# import static typedb.client.common.exception.ErrorMessage.Client.NEGATIVE_VALUE_NOT_ALLOWED;
# import static typedb.client.common.exception.ErrorMessage.Internal.ILLEGAL_CAST;
# import static typedb.common.util.Objects.className;
#
# public class TypeDBOptions {
#
#     private Boolean infer = null;
#     private Boolean traceInference = null;
#     private Boolean explain = null;
#     private Boolean parallel = null;
#     private Integer batchSize = null;
#     private Boolean prefetch = null;
#     private Integer sessionIdleTimeoutMillis = null;
#     private Integer schemaLockAcquireTimeoutMillis = null;
#
#     @CheckReturnValue
#     public static TypeDBOptions core() {
#         return new TypeDBOptions();
#     }
#
#     @CheckReturnValue
#     public static TypeDBOptions.Cluster cluster() {
#         return new Cluster();
#     }
#
#     @CheckReturnValue
#     public boolean isCluster() {
#         return false;
#     }
#
#     @CheckReturnValue
#     public Optional<Boolean> infer() {
#         return Optional.ofNullable(infer);
#     }
#
#     public TypeDBOptions infer(boolean infer) {
#         this.infer = infer;
#         return this;
#     }
#
#     @CheckReturnValue
#     public Optional<Boolean> traceInference() {
#         return Optional.ofNullable(traceInference);
#     }
#
#     public TypeDBOptions traceInference(boolean traceInference) {
#         this.traceInference = traceInference;
#         return this;
#     }
#
#     @CheckReturnValue
#     public Optional<Boolean> explain() {
#         return Optional.ofNullable(explain);
#     }
#
#     public TypeDBOptions explain(boolean explain) {
#         this.explain = explain;
#         return this;
#     }
#
#     @CheckReturnValue
#     public Optional<Boolean> parallel() {
#         return Optional.ofNullable(parallel);
#     }
#
#     public TypeDBOptions parallel(boolean parallel) {
#         this.parallel = parallel;
#         return this;
#     }
#
#     @CheckReturnValue
#     public Optional<Integer> batchSize() {
#         return Optional.ofNullable(batchSize);
#     }
#
#     public TypeDBOptions batchSize(int batchSize) {
#         if (batchSize < 1) {
#             throw new TypeDBClientException(NEGATIVE_VALUE_NOT_ALLOWED, batchSize);
#         }
#         this.batchSize = batchSize;
#         return this;
#     }
#
#     @CheckReturnValue
#     public Optional<Boolean> prefetch() {
#         return Optional.ofNullable(prefetch);
#     }
#
#     public TypeDBOptions prefetch(boolean prefetch) {
#         this.prefetch = prefetch;
#         return this;
#     }
#
#     @CheckReturnValue
#     public Optional<Integer> sessionIdleTimeoutMillis() {
#         return Optional.ofNullable(sessionIdleTimeoutMillis);
#     }
#
#     public TypeDBOptions sessionIdleTimeoutMillis(int sessionIdleTimeoutMillis) {
#         if (sessionIdleTimeoutMillis < 1) {
#             throw new TypeDBClientException(NEGATIVE_VALUE_NOT_ALLOWED, sessionIdleTimeoutMillis);
#         }
#         this.sessionIdleTimeoutMillis = sessionIdleTimeoutMillis;
#         return this;
#     }
#
#     @CheckReturnValue
#     public Optional<Integer> schemaLockAcquireTimeoutMillis() {
#         return Optional.ofNullable(schemaLockAcquireTimeoutMillis);
#     }
#
#     public TypeDBOptions schemaLockAcquireTimeoutMillis(int schemaLockAcquireTimeoutMillis) {
#         if (schemaLockAcquireTimeoutMillis < 1) {
#             throw new TypeDBClientException(NEGATIVE_VALUE_NOT_ALLOWED, schemaLockAcquireTimeoutMillis);
#         }
#         this.schemaLockAcquireTimeoutMillis = schemaLockAcquireTimeoutMillis;
#         return this;
#     }
#
#     @CheckReturnValue
#     public Cluster asCluster() {
#         throw new TypeDBClientException(ILLEGAL_CAST, className(Cluster.class));
#     }
#
#     @CheckReturnValue
#     public OptionsProto.Options proto() {
#         OptionsProto.Options.Builder builder = OptionsProto.Options.newBuilder();
#         infer().ifPresent(builder::setInfer);
#         traceInference().ifPresent(builder::setTraceInference);
#         explain().ifPresent(builder::setExplain);
#         parallel().ifPresent(builder::setParallel);
#         batchSize().ifPresent(builder::setBatchSize);
#         prefetch().ifPresent(builder::setPrefetch);
#         sessionIdleTimeoutMillis().ifPresent(builder::setSessionIdleTimeoutMillis);
#         schemaLockAcquireTimeoutMillis().ifPresent(builder::setSchemaLockAcquireTimeoutMillis);
#         if (isCluster()) asCluster().readAnyReplica().ifPresent(builder::setReadAnyReplica);
#
#         return builder.build();
#     }
#
#     public static class Cluster extends TypeDBOptions {
#
#         private Boolean readAnyReplica = null;
#
#         @CheckReturnValue
#         public Optional<Boolean> readAnyReplica() {
#             return Optional.ofNullable(readAnyReplica);
#         }
#
#         public Cluster readAnyReplica(boolean readAnyReplica) {
#             this.readAnyReplica = readAnyReplica;
#             return this;
#         }
#
#         @Override
#         @CheckReturnValue
#         public boolean isCluster() {
#             return true;
#         }
#
#         @Override
#         @CheckReturnValue
#         public Cluster asCluster() {
#             return this;
#         }
#     }
# }
