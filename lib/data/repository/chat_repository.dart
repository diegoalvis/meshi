import 'dart:math';

import 'package:meshi/data/api/chat_api.dart';
import 'package:meshi/data/db/dao/match_dao.dart';
import 'package:meshi/data/db/dao/message_dao.dart';
import 'package:meshi/data/models/message.dart';

class ChatRepository {
  ChatApi _api;
  MessageDao _dao;
  MatchDao _matchDao;

  ChatRepository(this._api, this._dao, this._matchDao);

  Future updateMatch(int matchId, Message message) async {
    await _matchDao.updateMatch(matchId, message);
  }

  Future<bool> sendMessage(int matchId, Message message) async {
    final result = await _api.sendMessage(matchId, message);
    return result.success;
  }

  Future<List<Message>> getMessages(int matchId,
      {int limit = 60, int skip}) async {
    final result = await _api.getMessages(matchId, limit: limit, skip: skip);
    await _dao.removeAll(matchId);
    await _dao.insertAll(result.data);
    return result.data;
  }

  Future<List<Message>> getLocalMessages(int matchId) async {
    return await this._dao.get(matchId);
  }

  Future<int> clear(int matchId) async{
    final id = await this._api.clear(matchId);
    return id.data;
  }

  Future<int> insertMessage(Message msg) async{
    await _dao.insert(msg);
    await _matchDao.updateMatch(msg.matchId, msg);
    return 1;
  }

}
