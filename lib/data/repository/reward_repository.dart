/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/data/api/reward_api.dart';
import 'package:meshi/data/models/brand.dart';
import 'package:meshi/data/models/reward_info.dart';
import 'package:meshi/data/models/user_match.dart';
import 'package:meshi/managers/session_manager.dart';

class RewardRepository {
  RewardApi _api;
  SessionManager session;

  RewardRepository(this._api);

  Future<List<Brand>> getBrands() async {
    final result = await _api.getBrands();
    return result.data;
  }

  Future<RewardInfo> getCurrent() async {
    final currentDate = DateTime.now().millisecondsSinceEpoch;
    if (session.rewardInfo == null ||
        (currentDate <= session.rewardInfo.reward.publishDate.millisecondsSinceEpoch &&
            currentDate >= session.rewardInfo.reward.validDate.millisecondsSinceEpoch)) {
      final result = await _api.getCurrentReward();
      return result.data;
    } else {
      return session.rewardInfo;
    }
  }

  Future<bool> join(int rewardId, List<UserMatch> couples) async {
    final result = await _api.joinReward(rewardId, couples);
    return result.success;
  }
}
