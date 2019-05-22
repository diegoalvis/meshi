/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/brand.dart';
import 'package:meshi/data/models/reward_model.dart';
import 'package:meshi/data/repository/reward_repository.dart';
import 'package:rxdart/rxdart.dart';

class RewardBloc extends BaseBloc {
  final _rewardSubject = PublishSubject<Reward>();
  final _brandSubject = PublishSubject<List<Brand>>();

  Observable<Reward> get rewardStream => _rewardSubject.stream;

  Observable<List<Brand>> get brandStream => _brandSubject.stream;

  RewardRepository repository;

  RewardBloc(this.repository, session) : super(session);

  @override
  void dispose() {
    super.dispose();
    _rewardSubject.close();
    _brandSubject.close();
  }

  void getRewards() {
    progressSubject.sink.add(true);
    //TODO: Make API call to the server to get data
    final reward = Reward.mock("Cita", 75000, "Meshi quiere invitarte una cena para que conozcas a tu pareja ideal",
        "https://www.nhflavors.com/wp-content/uploads/2018/02/romantic-dinner-BVI-740X474.jpg", DateTime(2019, 2, 10));
    _rewardSubject.sink.add(reward);
    progressSubject.sink.add(false);
  }

  void getBrands() {
    progressSubject.sink.add(true);
    repository.getBrands()
        .then((brands) {
          _brandSubject.sink.add(brands);
    }).catchError((error) {
      errorSubject.sink.add(error.toString());
    }).whenComplete(() => progressSubject.sink.add(false));
  }
}
