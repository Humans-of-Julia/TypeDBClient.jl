# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE 

# 
# package typedb.client.concept.answer;
# 
# import typedb.client.api.answer.Numeric;
# import typedb.client.common.exception.TypeDBClientException;
# import typedb.protocol.AnswerProto;
# 
# import javax.annotation.Nullable;
# 
# import static typedb.client.common.exception.ErrorMessage.Internal.ILLEGAL_CAST;
# import static typedb.client.common.exception.ErrorMessage.Query.BAD_ANSWER_TYPE;
# 
# public class NumericImpl implements Numeric {
# 
#     @Nullable
#     private final Long longValue;
#     @Nullable
#     private final Double doubleValue;
# 
#     private NumericImpl(@Nullable Long longValue, @Nullable Double doubleValue) {
#         this.longValue = longValue;
#         this.doubleValue = doubleValue;
#     }
# 
#     public static NumericImpl of(AnswerProto.Numeric numeric) {
#         switch (numeric.getValueCase()) {
#             case LONG_VALUE:
#                 return NumericImpl.ofLong(numeric.getLongValue());
#             case DOUBLE_VALUE:
#                 return NumericImpl.ofDouble(numeric.getDoubleValue());
#             case NAN:
#                 return NumericImpl.ofNaN();
#             default:
#                 throw new TypeDBClientException(BAD_ANSWER_TYPE, numeric.getValueCase());
#         }
#     }
# 
#     private static NumericImpl ofLong(long value) {
#         return new NumericImpl(value, null);
#     }
# 
#     private static NumericImpl ofDouble(double value) {
#         return new NumericImpl(null, value);
#     }
# 
#     private static NumericImpl ofNaN() {
#         return new NumericImpl(null, null);
#     }
# 
#     @Override
#     public boolean isLong() {
#         return longValue != null;
#     }
# 
#     @Override
#     public boolean isDouble() {
#         return doubleValue != null;
#     }
# 
#     @Override
#     public boolean isNaN() {
#         return !isLong() && !isDouble();
#     }
# 
#     @Override
#     public long asLong() {
#         if (isLong()) return longValue;
#         else throw new TypeDBClientException(ILLEGAL_CAST, Long.class);
#     }
# 
#     @Override
#     public Double asDouble() {
#         if (isDouble()) return doubleValue;
#         else throw new TypeDBClientException(ILLEGAL_CAST, Double.class);
#     }
# 
#     @Override
#     public Number asNumber() {
#         if (isLong()) return longValue;
#         else if (isDouble()) return doubleValue;
#         else throw new TypeDBClientException(ILLEGAL_CAST, Number.class);
#     }
# }
