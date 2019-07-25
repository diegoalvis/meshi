import 'package:meshi/data/api/dto/recomendation_dto.dart';
import 'package:meshi/data/api/match_api.dart';
import 'package:meshi/data/db/dao/match_dao.dart';
import 'package:meshi/data/db/dao/recomendation_dao.dart';
import 'package:meshi/data/models/recomendation.dart';
import 'package:meshi/data/models/user_match.dart';
import 'package:meshi/data/models/my_likes.dart';
import 'package:meshi/managers/session_manager.dart';

class MatchRepository {
  final MatchApi _api;
  final MatchDao _dao;
  final RecomendationDao _recoDao;
  final SessionManager _session;

  MatchRepository(this._api, this._dao, this._recoDao, this._session);

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
    final result =
    await this._api.getMatches(interacted: interacted, premium: premium).catchError((error) => getLocalMatches());
    await _dao.removeAll();
    await _dao.insertAll(result.data);
    return result.data;
  }

  Future<RecomendationDto> getRecommendations({List<Recomendation> looked}) async {
    RecomendationDto recomendation;
    if (looked != null) {
      recomendation = await _nextRecomendations(looked);
    } else {
      recomendation = await _localRecomendations();
    }

    await this._recoDao.removeAll();
    await this._recoDao.insertAll(recomendation.recomendations);

    return recomendation;
  }

  Future<RecomendationDto> _localRecomendations() async {
    RecomendationDto recomendation;
    final listReco = await _recoDao.getAll();

    if (listReco.isEmpty) {
      final result = await this._api.getRecommendations();
      final tries = await this._session.recomendationTry(result.data.max);
      this._session.nextRecomendationPage();

      recomendation = result.data;
      recomendation.tries = tries;
      recomendation = result.data;
    } else {
      final triesResult = await this._api.maxTries();
      final tries = await this._session.recomendationTry(triesResult.data);
      recomendation = RecomendationDto(max: triesResult.data, recomendations: listReco);
      recomendation.tries = tries;
    }
    return recomendation;
  }

  Future<RecomendationDto> _nextRecomendations(List<Recomendation> looked) async {
    await this._api.updateLooked(looked.map((x) => x.id).toList());

    final page = await this._session.recomendationPage();
    final result = await this._api.getRecommendations(page: page);
    final recomendation = result.data;

    _session.nextRecomendationPage();

    final tries = await this._session.recomendationTry(result.data.max);
    recomendation.tries = tries;
    this._session.useRecomendationTry();

    return recomendation;
  }

  Future addMatch(int toUserId) async {
    await this._api.addMatch(toUserId);
    await this._recoDao.removeById(toUserId);
  }

  Future dislike(int toUserId) async {
    await this._api.disLike(toUserId);
    await this._recoDao.removeById(toUserId);
  }

  Future blockMatch(int matchId) async {
    await this._api.block(matchId);
  }

  Future<Recomendation> getProfile(int toUserId) async {
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
