/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/reward_model.dart';
import 'package:rxdart/rxdart.dart';

class RewardBloc extends BaseBloc {
  final _rewardSubject = PublishSubject<Reward>();
  Observable<Reward> get rewardStream => _rewardSubject.stream;

  @override
  void dispose() {
    super.dispose();
    _rewardSubject.close();
  }

  getRewards() {
    progressSubject.sink.add(true);
    //TODO: Make API call to the server to get data
    final reward = Reward.mock(
        "Cita",
        75000,
        "Meshi quiere invitarte una cena para que conozcas a tu pareja ideal",
        "https://www.nhflavors.com/wp-content/uploads/2018/02/romantic-dinner-BVI-740X474.jpg",
        DateTime(2019, 2, 10));
    _rewardSubject.sink.add(reward);
    progressSubject.sink.add(false);
  }
}
