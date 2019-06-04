import 'package:dio/dio.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/data/models/match.dart';
import 'package:meshi/data/models/my_likes.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/managers/session_manager.dart';

class MatchApi extends BaseApi {
  MatchApi(Dio dio, SessionManager session) : super(dio, session);

  Future<BaseResponse<List<MyLikes>>> getMyLikes() async {
    return get("/users/my-likes").then((response) => processListResponse(response, parseMyLikes));
  }

  Future<BaseResponse<List<MyLikes>>> getLikesMe() async {
    return get("/users/likes-me").then((response) => processListResponse(response, parseMyLikes));
  }

  Future<BaseResponse<List<Match>>> getMatches() async {
    return get("/users/matchs").then((response) => processListResponse(response, parseMatch));
  }

  Future<BaseResponse<User>> getProfile(int id) async {
    return get("/users/$id").then((response) => processResponse(response, parseSingleUser));
  }

  Future<BaseResponse<List<User>>> getRecommendations({int limit = 0, int skip = 0}) async {
    return get("/users").then((response) => processListResponse(response, parseUser));
  }

  Future<BaseResponse<int>> addMatch(int id) async {
    return post("/users/match/$id").then((response) => processBasicResponse(response));
  }

  Future<BaseResponse<int>> disLike(int id) async {
    return post("/users/dislike/$id").then((response) => processBasicResponse(response));
  }
}

List<MyLikes> parseMyLikes(List<Map<String, dynamic>> json) =>
    json.map((element) => MyLikes.fromJson(element)).toList();
List<Match> parseMatch(List<Map<String, dynamic>> json) =>
    json.map((element) => Match.fromJson(element)).toList();
List<User> parseUser(List<Map<String, dynamic>> json) =>
    json.map((element) => User.fromJson(element)).toList();
User parseSingleUser(Map<String, dynamic> json) => User.fromJson(json);
