module grakn
  const _ProtoBuf_Top_ = @static isdefined(parentmodule(@__MODULE__), :_ProtoBuf_Top_) ? (parentmodule(@__MODULE__))._ProtoBuf_Top_ : parentmodule(@__MODULE__)
  module protocol
    const _ProtoBuf_Top_ = @static isdefined(parentmodule(@__MODULE__), :_ProtoBuf_Top_) ? (parentmodule(@__MODULE__))._ProtoBuf_Top_ : parentmodule(@__MODULE__)
    include("concept_pb.jl")
    include("answer_pb.jl")
    include("database_pb.jl")
    include("options_pb.jl")
    include("session_pb.jl")
    include("logic_pb.jl")
    include("query_pb.jl")
    include("transaction_pb.jl")
  end
end
