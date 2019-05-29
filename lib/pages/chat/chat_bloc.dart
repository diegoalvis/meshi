import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meshi/data/models/message.dart';
import 'package:meshi/data/repository/chat_repository.dart';
import 'package:meshi/data/sockets/ChatSocket.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:rxdart/rxdart.dart';

import 'chat_events.dart';

class ChatBloc extends Bloc<ChatEvents, MessageState> {

  final int _matchId;
  final ChatSocket _socket;
  final ChatRepository _messageRespository;
  int _me;
  StreamSubscription _subs;

  ChatBloc(this._matchId, this._socket, this._messageRespository, SessionManager session){
    _me = session.user.id;
  }

  void connectSocket() async {
    final _obs = await _socket.connect(_matchId);
    _subs = _obs.flatMap((msg) =>
        Observable.fromFuture(_messageRespository.insertMessage(msg))
            .map((x) => msg))
        .listen((msg) => dispatch(NewMessageEvent(msg)),onError: (error){});
  }

  @override
  void dispose() {
    _subs.cancel();
    super.dispose();
  }

  @override
  MessageState get initialState => MessageState([], _me);

  @override
  Stream<MessageState> mapEventToState(ChatEvents event) async* {
    try {
      if (event is LoadedChatEvent) {
        final local = await _messageRespository.getLocalMessages(_matchId);
        yield MessageState(local, _me);
        final remotes = await _messageRespository.getMessages(_matchId);
        yield MessageState(remotes, _me);
      } else if (event is SendMessageEvent) {
        await _messageRespository.sendMessageLocal(_matchId, event.message);
        final local = await _messageRespository.getLocalMessages(_matchId);
        yield MessageState(local, _me);
        await _messageRespository.sendMessage(_matchId, event.message);
      } else if (event is NewMessageEvent) {
        final local = await _messageRespository.getLocalMessages(_matchId);
        yield MessageState(local, _me);
      }
    } catch (e){}
  }


}

class MessageState extends Equatable {

  List<Message> messages;
  int me;

  MessageState(this.messages, this.me) :super([messages]);

  @override
  String toString() {
    return "MessageState";
  }

}