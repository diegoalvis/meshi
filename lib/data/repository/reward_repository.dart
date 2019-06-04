/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/data/api/reward_api.dart';
import 'package:meshi/data/models/brand.dart';
import 'package:meshi/data/models/match.dart';
import 'package:meshi/data/models/reward_info.dart';

class RewardRepository {
  RewardApi _api;

  RewardRepository(this._api);

  /// Fetch agreement companies
  Future<List<Brand>> getBrands() async {
    final result = await _api.getBrands();
    return result.data;
  }

  Future<RewardInfo> getCurrent() async{
    final result = await _api.getCurrentReward();
    return result.data;
  }

  Future join(int rewardId, List<Match> couples) async{
    await _api.joinReward(rewardId, couples);
  }
}
