import 'package:meshi/data/api/match_api.dart';
import 'package:meshi/data/db/dao/match_dao.dart';
import 'package:meshi/data/models/recomendation.dart';
import 'package:meshi/data/models/user_match.dart';
import 'package:meshi/data/models/my_likes.dart';
import 'package:meshi/data/models/user.dart';

class MatchRepository {
  final MatchApi _api;
  final MatchDao _dao;

  MatchRepository(this._api, this._dao);

  Future<List<MyLikes>> getMyLikes() async {
    final result = await this._api.getMyLikes();
    return result.data;
  }

  Future<List<MyLikes>> getLikesMe() async {
    final result = await this._api.getLikesMe();
    return result.data;
  }

  Future<List<UserMatch>> getLocalMatches() async {
    return _dao.getAll();
  }

  Future<List<UserMatch>> getMatches({bool interacted = false, bool premium = false}) async {
    final result = await this._api.getMatches(interacted: interacted, premium: premium)
        .catchError((error) => getLocalMatches());
    await _dao.removeAll();
    await _dao.insertAll(result.data);
    return result.data;
  }

  Future<List<Recomendation>> getRecommendations({int limit, int skip}) async {
    final result = await this._api.getRecommendations(limit: limit, skip: skip);
    return result.data;
  }

  Future addMatch(int toUserId) async {
    await this._api.addMatch(toUserId);
  }

  Future dislike(int toUserId) async {
    await this._api.disLike(toUserId);
  }

  Future blockMatch(int matchId) async{
    await this._api.block(matchId);
  }

  Future getProfile(int toUserId) async{
    final result = await this._api.getProfile(toUserId);
    return result.data;
  }

}
