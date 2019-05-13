/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dio/dio.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/data/models/brand.dart';
import 'package:meshi/managers/session_manager.dart';

class RewardApi extends BaseApi {
  RewardApi(Dio dio, SessionManager session) : super(dio, session);

  Future<BaseResponse<List<Brand>>> getBrands() {
    return get("/brands").then((response) => processListResponse(response, parseBrand)).catchError((error) {
      print(error);
    });

  }
}

List<Brand> parseBrand(List<Map<String, dynamic>> json) => json.map((element) => Brand.fromJson(element)).toList();
