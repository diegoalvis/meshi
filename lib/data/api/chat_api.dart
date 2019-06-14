import 'package:dio/dio.dart';
import 'package:meshi/data/models/message.dart';
import 'package:meshi/managers/session_manager.dart';

import 'base_api.dart';

class ChatApi extends BaseApi {

  ChatApi(Dio dio, SessionManager session) : super(dio, session);

  Future<BaseResponse<List<Message>>> getMessages(int match, {int limit, int skip, int from}) async{
    return get("/chat/$match", query: {"from":from, "limit":limit, "skip":skip}).then((response) =>
        processListResponse(response, parseMessages));
  }

  Future<BaseResponse<int>> sendMessage(int match, Message message) async{
    return post("/chat/$match/message", body: message.toJson()).then((response) => processBasicResponse(response));
  }

  Future<BaseResponse<int>> clear(int match) async{
    return delete("/chat/$match/clear").then((response) => processBasicResponse(response));
  }

}

List<Message> parseMessages(List<Map<String, dynamic>> json) => json.map((element) => Message.fromJson(element)).toList();