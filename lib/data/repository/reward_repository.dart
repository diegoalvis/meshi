/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dio/dio.dart';
import 'package:meshi/data/api/reward_api.dart';
import 'package:meshi/data/models/brand.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:rxdart/rxdart.dart';

class RewardRepository {
  RewardApi _api;

  RewardRepository(this._api);

  /// Fetch agreement companies
  Future<List<Brand>> getBrands() {
    return _api.getBrands().then((response) {
      return response.success ? response.data : throw Error();
    });
  }
}
