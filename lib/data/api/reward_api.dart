/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dio/dio.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/data/models/brand.dart';
import 'package:meshi/data/models/reward.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/managers/session_manager.dart';

class RewardApi extends BaseApi {
  RewardApi(Dio dio, SessionManager session) : super(dio, session);

  Future<BaseResponse<List<Brand>>> getBrands() {
    return get("/brands").then((response) => processListResponse(response, parseBrand)).catchError((error) {
      print(error);
    });
  }

  Future<BaseResponse<Reward>> getCurrentReward(){
    return get("/rewards/current").then((response) => processResponse(response, parseReward)).catchError((error) {
      print(error);
    });
  }
}

List<Brand> parseBrand(List<Map<String, dynamic>> json) => json.map((element) => Brand.fromJson(element)).toList();
List<User> parseMatches(List<Map<String, dynamic>> json) => json.map((element) => User.fromJson(element)).toList();
Reward parseReward(Map<String, dynamic> json) => Reward.fromJson(json);
