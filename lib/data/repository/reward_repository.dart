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
    final winner = await session.winner;
    if (winner != null &&
        winner.winner &&
        currentDate < winner.reward.validDate.millisecondsSinceEpoch &&
        currentDate > winner.reward.publishDate.millisecondsSinceEpoch) {
      return winner;
    }
    final result = await _api.getCurrentReward();
    if (result.data.winner) session.saveWinner(result.data);
    return result.data;
  }

  Future<bool> join(int rewardId, List<UserMatch> couples) async {
    final result = await _api.joinReward(rewardId, couples);
    return result.success;
  }
}
