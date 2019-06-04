/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dio/dio.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/data/models/brand.dart';
import 'package:meshi/data/models/reward_info.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/models/match.dart';
import 'package:meshi/managers/session_manager.dart';

class RewardApi extends BaseApi {
  RewardApi(Dio dio, SessionManager session) : super(dio, session);

  Future<BaseResponse<List<Brand>>> getBrands() {
    return get("/brands")
        .then((response) => processListResponse(response, parseBrand))
        .catchError((error) {
      print(error);
    });
  }

  Future<BaseResponse<RewardInfo>> getCurrentReward() {
    return get("/rewards/current/state")
        .then((response) => processResponse(response, parseReward))
        .catchError((error) {
      print(error);
    });
  }

  Future<BaseResponse<int>> joinReward(int id, List<Match> couples) {
    final jsonArray = couples.map((c) => {"toUser": c.id, "match": c.idMatch});
    return post("/rewards/join/$id", body: {"couples": jsonArray})
        .then((response) => processBasicResponse(response))
        .catchError((error) {
      print(error);
    });
  }
}

List<Brand> parseBrand(List<Map<String, dynamic>> json) =>
    json.map((element) => Brand.fromJson(element)).toList();

List<User> parseMatches(List<Map<String, dynamic>> json) =>
    json.map((element) => User.fromJson(element)).toList();

RewardInfo parseReward(Map<String, dynamic> json) => RewardInfo.fromJson(json);
