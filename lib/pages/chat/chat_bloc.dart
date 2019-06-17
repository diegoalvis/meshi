import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meshi/data/models/message.dart';
import 'package:meshi/data/models/user_match.dart';
import 'package:meshi/data/repository/chat_repository.dart';
import 'package:meshi/data/repository/match_repository.dart';
import 'package:meshi/data/sockets/ChatSocket.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:rxdart/rxdart.dart';

import 'chat_events.dart';

class ChatBloc extends Bloc<ChatEvents, BaseState> {
  final UserMatch _match;
  final ChatSocket _socket;
  final ChatRepository _messageRespository;
  final MatchRepository _matchRespository;
  int _me;
  StreamSubscription _subs;

  ChatBloc(this._match, this._socket, this._messageRespository,
      this._matchRespository, SessionManager session) {
    _me = session.user.id;
  }

  void connectSocket() async {
    final _obs = await _socket.connect(_match.idMatch);
    _subs = _obs
        .flatMap((msg) =>
            Observable.fromFuture(_messageRespository.insertMessage(msg))
                .map((x) => msg))
        .listen((msg) => dispatch(NewMessageEvent(msg)), onError: (error) {});
  }

  @override
  void dispose() {
    _subs.cancel();
    super.dispose();
  }

  @override
  BaseState get initialState => MessageState([], 0);

  @override
  Stream<BaseState> mapEventToState(ChatEvents event) async* {
    try {
      if (event is LoadedChatEvent) {
        final local = await _messageRespository.getLocalMessages(_match.idMatch);
        yield MessageState(local, _me);
        final remotes = await _messageRespository.getMessages(_match.idMatch, from: _match.erasedDate?.millisecondsSinceEpoch);
        yield MessageState(remotes, _me);
      } else if (event is SendMessageEvent) {
        await _messageRespository.sendMessageLocal(_match.idMatch, event.message);
        final local = await _messageRespository.getLocalMessages(_match.idMatch);
        yield MessageState(local, _me);
        await _messageRespository.sendMessage(_match.idMatch, event.message);
      } else if (event is NewMessageEvent) {
        final local = await _messageRespository.getLocalMessages(_match.idMatch);
        yield MessageState(local, _me);
      } else if (event is ClearChatEvent) {
        yield LoadingState();
        await _messageRespository.clear(event.matchId);
        yield MessageState([], _me);
      } else if (event is BlockMatchEvent) {
        yield LoadingState();
        await _matchRespository.blockMatch(event.matchId);
        yield ExitState();
      }
    } catch (e) {}
  }
}

class MessageState extends BaseState {
  List<Message> messages;
  int me;

  MessageState(this.messages, this.me) : super(props: messages);

  @override
  String toString() {
    return "MessageState";
  }
}
