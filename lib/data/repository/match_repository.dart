import 'package:meshi/data/api/dto/recomendation_dto.dart';
import 'package:meshi/data/api/match_api.dart';
import 'package:meshi/data/db/dao/match_dao.dart';
import 'package:meshi/data/models/recomendation.dart';
import 'package:meshi/data/models/user_match.dart';
import 'package:meshi/data/models/my_likes.dart';
import 'package:meshi/managers/session_manager.dart';

class MatchRepository {
  final MatchApi _api;
  final MatchDao _dao;
  final SessionManager _session;

  MatchRepository(this._api, this._dao, this._session);

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

  Future<RecomendationDto> getRecommendations({int page = 0, List<Recomendation> looked}) async {
    if(looked != null){
      final ids = looked.map( (x){ return x.id; } );
      await this._api.updateLooked(ids);
    }
    final result = await this._api.getRecommendations(page:page);
    final recomendation = result.data;

    final tries = await this._session.recomendationTry(result.data.max);
    recomendation.tries = tries;
    if(looked != null){
      this._session.useRecomendationTry();
    }
    return recomendation;
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

  Future<Recomendation> getProfile(int toUserId) async{
    final result = await this._api.getProfile(toUserId);
    return result.data;
  }

  Future<int> updateUserLocation(double lat, double lon) async {
    final logged = await _session.logged;
    if (!logged) {
      return -1;
    }
    final rspn = await _api.updateLocation(lat, lon);
    return rspn.data;
  }
}
