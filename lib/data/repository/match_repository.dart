import 'package:meshi/data/api/match_api.dart';
import 'package:meshi/data/models/match.dart';
import 'package:meshi/data/models/my_likes.dart';
import 'package:meshi/data/models/user.dart';

class MatchRepository{

  final MatchApi _api;

  MatchRepository(this._api);

  Future<List<MyLikes>> getMyLikes() async{
      final result =  await this._api.getMyLikes();
      return result.data;
  }

  Future<List<MyLikes>> getLikesMe() async{
    final result =  await this._api.getLikesMe();
    return result.data;
  }

  Future<List<Matchs>> getMatchs() async{
    final result =  await this._api.getMatchs();
    return result.data;
  }

  Future<List<User>> getRecomendations({int limit, int skip}) async{
    final result =  await this._api.getRecomendations(limit: limit, skip: skip);
    return result.data;
  }

  Future addMatch(int toUserId) async{
    await this._api.addMatch(toUserId);
  }

}