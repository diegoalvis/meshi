import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meshi/data/models/message.dart';
import 'package:meshi/data/models/user_match.dart';
import 'package:meshi/data/repository/chat_repository.dart';
import 'package:meshi/data/repository/match_repository.dart';
import 'package:meshi/data/sockets/ChatSocket.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/utils/base_state.dart';

import 'chat_events.dart';

class ChatBloc extends Bloc<ChatEvents, BaseState> {
  final UserMatch _match;
  final ChatSocket _socket;
  final ChatRepository _messageRepository;
  final MatchRepository _matchRepository;
  final SessionManager session;
  int _me;
  StreamSubscription _subs;

  ChatBloc(this._match, this._socket, this._messageRepository, this._matchRepository, this.session) {
    session.userId.then((id) => _me = id);
  }

  void connectSocket() async {
    final _obs = await _socket.connect(_match.idMatch);
    _subs = _obs.listen((msg) => {if (msg.fromUser != _me) dispatch(NewMessageEvent(msg))}, onError: (error) {
      print(error);
    });
  }

  @override
  void dispose() {
    _subs.cancel();
    super.dispose();
  }

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(ChatEvents event) async* {
    try {
      if (event is LoadedChatEvent) {
        final local = await _messageRepository.getLocalMessages(_match.idMatch);
        yield MessageState(local, _me);
        final remotes =
            await _messageRepository.getMessages(_match.idMatch, from: _match.erasedDate?.millisecondsSinceEpoch);
        yield MessageState(remotes, _me);
      } else if (event is LoadPageEvent) {
        final remotes = await _messageRepository.getPreviousMessages(_match.idMatch,
            from: _match.erasedDate?.millisecondsSinceEpoch, skipFrom: event.from);
        yield MessageState(remotes, _me, newPage: true);
      } else if (event is SendMessageEvent) {
        yield MessageState([event.message], _me, newMessage: true);
        await _messageRepository.sendMessage(_match.idMatch, event.message);
        await _messageRepository.insertMessage(event.message);
      } else if (event is NewMessageEvent) {
        yield MessageState([event.message], _me, newMessage: true);
        await _messageRepository.insertMessage(event.message);
      } else if (event is ClearChatEvent) {
        yield LoadingState();
        await _messageRepository.clear(event.matchId);
        yield MessageState([], _me);
      } else if (event is BlockMatchEvent) {
        yield LoadingState();
        await _matchRepository.blockMatch(event.matchId);
        yield ExitState();
      }
    } catch (e) {
      print('ERROR');
    }
  }
}

class MessageState extends BaseState {
  List<Message> messages;
  int me;
  bool newPage;
  bool newMessage;

  MessageState(this.messages, this.me, {this.newPage = false, this.newMessage = false}) : super(props: messages);

  @override
  String toString() {
    return "MessageState";
  }
}
