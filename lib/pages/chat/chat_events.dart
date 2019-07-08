import 'package:equatable/equatable.dart';
import 'package:meshi/data/models/message.dart';

class ChatEvents extends Equatable {}

class SendMessageEvent extends ChatEvents {
  Message message;
  SendMessageEvent(this.message);

  @override
  String toString() {
    return "SendMessageEvent";
  }
}

class LoadedChatEvent extends ChatEvents {
  @override
  String toString() {
    return "LoadedChatEvent";
  }
}

class NewMessageEvent extends ChatEvents {
  Message message;
  NewMessageEvent(this.message);

  @override
  String toString() {
    return "NewMessageEvent";
  }
}

class ClearChatEvent extends ChatEvents {
  int matchId;
  ClearChatEvent(this.matchId);

  @override
  String toString() {
    return "ClearChatEvent";
  }
}

class BlockMatchEvent extends ChatEvents {
  int matchId;
  BlockMatchEvent(this.matchId);

  @override
  String toString() {
    return "BlockMatchEvent";
  }
}

class LoadPageEvent extends ChatEvents{
  int from;
  LoadPageEvent(this.from);

  @override
  String toString() {
    return "LoadPageEvent";
  }

}

