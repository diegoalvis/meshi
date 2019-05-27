import 'package:meshi/data/api/chat_api.dart';
import 'package:meshi/data/models/message.dart';

class ChatRepository{

  ChatApi _api;

  ChatRepository(this._api);

  Future<int> sendMessage(int matchId, Message message) async{
    final result = await _api.sendMessage(matchId, message);
    return result.data;
  }

  Future<List<Message>> getMessages(int matchId, {int limit, int skip}) async{
    final result = await _api.getMessages(matchId, limit: limit, skip: skip);
    return result.data;
  }

}