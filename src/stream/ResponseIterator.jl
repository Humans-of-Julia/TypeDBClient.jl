# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE 

# 
# package grakn.client.stream;
# 
# import grakn.client.common.GraknClientException;
# import grakn.client.common.Proto;
# import grakn.protocol.TransactionProto;
# 
# import java.util.Iterator;
# import java.util.NoSuchElementException;
# import java.util.UUID;
# 
# import static grakn.client.common.ErrorMessage.Client.MISSING_RESPONSE;
# import static grakn.client.common.ErrorMessage.Internal.ILLEGAL_ARGUMENT;
# import static grakn.client.common.ErrorMessage.Internal.ILLEGAL_STATE;
# 
# public class ResponseIterator implements Iterator<TransactionProto.Transaction.ResPart> {
# 
#     private final UUID requestID;
#     private final RequestTransmitter.Dispatcher dispatcher;
#     private final ResponseCollector.Queue<TransactionProto.Transaction.ResPart> responseCollector;
#     private TransactionProto.Transaction.ResPart next;
#     private State state;
# 
#     enum State {EMPTY, FETCHED, DONE}
# 
#     public ResponseIterator(UUID requestID, ResponseCollector.Queue<TransactionProto.Transaction.ResPart> responseQueue,
#                             RequestTransmitter.Dispatcher requestDispatcher) {
#         this.requestID = requestID;
#         this.dispatcher = requestDispatcher;
#         this.responseCollector = responseQueue;
#         state = State.EMPTY;
#         next = null;
#     }
# 
#     private boolean fetchAndCheck() {
#         TransactionProto.Transaction.ResPart resPart = responseCollector.take();
#         switch (resPart.getResCase()) {
#             case RES_NOT_SET:
#                 throw new GraknClientException(MISSING_RESPONSE.message(requestID));
#             case STREAM_RES_PART:
#                 switch (resPart.getStreamResPart().getState()) {
#                     case DONE:
#                         state = State.DONE;
#                         return false;
#                     case CONTINUE:
#                         dispatcher.dispatch(Proto.Transaction.streamReq(requestID));
#                         return fetchAndCheck();
#                     default:
#                         throw new GraknClientException(ILLEGAL_ARGUMENT);
#                 }
#             default:
#                 next = resPart;
#                 state = State.FETCHED;
#                 return true;
#         }
#     }
# 
#     @Override
#     public boolean hasNext() {
#         switch (state) {
#             case DONE:
#                 return false;
#             case FETCHED:
#                 return true;
#             case EMPTY:
#                 return fetchAndCheck();
#             default:
#                 throw new GraknClientException(ILLEGAL_STATE);
#         }
#     }
# 
#     @Override
#     public TransactionProto.Transaction.ResPart next() {
#         if (!hasNext()) throw new NoSuchElementException();
#         state = State.EMPTY;
#         return next;
#     }
# }