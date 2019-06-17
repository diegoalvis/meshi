/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/data/api/reward_api.dart';
import 'package:meshi/data/models/brand.dart';
import 'package:meshi/data/models/reward_info.dart';
import 'package:meshi/data/models/user_match.dart';
import 'package:meshi/data/db/dao/reward_dao.dart';

class RewardRepository {
  RewardApi _api;
  RewardDao _rewardDao;

  RewardRepository(this._api);

  Future<List<Brand>> getBrands() async {
    final result = await _api.getBrands();
    return result.data;
  }

  Future<RewardInfo> getCurrent() async {
    /*final currentDate = DateTime.now();
    final result = _rewardDao.getReward();
    if (result == null) {
      await _api.getCurrentReward();
    }
    else if (result. && currentDate.isAfter(result.data.reward.publishDate) && currentDate.isBefore(result.data.reward.validDate)) {
      await _rewardDao.insertReward(result.data.reward);
    }
    return result.data;*/
  }

  Future<bool> join(int rewardId, List<UserMatch> couples) async {
    final result = await _api.joinReward(rewardId, couples);
    return result.success;
  }
}
