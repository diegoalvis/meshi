import 'package:meshi/data/api/match_api.dart';
import 'package:meshi/data/db/dao/match_dao.dart';
import 'package:meshi/data/models/match.dart';
import 'package:meshi/data/models/my_likes.dart';
import 'package:meshi/data/models/user.dart';

class MatchRepository{

  final MatchApi _api;
  final MatchDao _dao;

  MatchRepository(this._api, this._dao);

  Future<List<MyLikes>> getMyLikes() async{
      final result =  await this._api.getMyLikes();
      return result.data;
  }

  Future<List<MyLikes>> getLikesMe() async{
    final result =  await this._api.getLikesMe();
    return result.data;
  }

  Future<List<Matches>> getLocalMatches() async{
    return _dao.getAll();
  }

  Future<List<Matches>> getMatches() async{
    final result =  await this._api.getMatches();
    await _dao.removeAll();
    await _dao.insertAll(result.data);
    return result.data;
  }

  Future<List<User>> getRecommendations({int limit, int skip}) async{
    final result =  await this._api.getRecommendations(limit: limit, skip: skip);
    return result.data;
  }

  Future addMatch(int toUserId) async{
    await this._api.addMatch(toUserId);
  }

}