import 'package:equatable/equatable.dart';
import 'package:meshi/data/models/message.dart';

class ChatEvents extends Equatable {}

class SendMessageEvent extends ChatEvents{

  Message message;
  SendMessageEvent(this.message);

  @override
  String toString() {
    return "SendMessageEvent";
  }

}

class LoadedChatEvent extends ChatEvents{
  @override
  String toString() {
    return "LoadedChatEvent";
  }
}

class NewMessageEvent extends ChatEvents{
  Message message;
  NewMessageEvent(this.message);

  @override
  String toString() {
    return "NewMessageEvent";
  }
}
