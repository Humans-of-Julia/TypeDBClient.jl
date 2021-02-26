
import grakn_protocol.protobuf.options_pb2 as options_proto

from grakn.options import GraknOptions, GraknClusterOptions


def options(opts: Union[GraknOptions, GraknClusterOptions]):
    proto_options = options_proto.Options()
    if opts.infer is not None:
        proto_options.infer = opts.infer
    if opts.trace_inference is not None:
        proto_options.trace_inference = opts.trace_inference
    if opts.explain is not None:
        proto_options.explain = opts.explain
    if opts.batch_size is not None:
        proto_options.batch_size = opts.batch_size
    if opts.is_cluster() and opts.read_any_replica is not None:
        proto_options.read_any_replica = opts.read_any_replica
    return proto_options