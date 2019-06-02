/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/brand.dart';
import 'package:meshi/data/models/reward_model.dart';
import 'package:meshi/data/repository/reward_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/utils/base_state.dart';

class RewardBloc extends BaseBloc<RewardEvent, BaseState> {
  final RewardRepository repository;

  RewardBloc(SessionManager session, this.repository) : super(session);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(RewardEvent event) async* {
    try {
      switch (event) {
        case RewardEvent.getCurrent:
          yield LoadingState();
          final reward = Reward.mock("Cita", 75000, "Meshi quiere invitarte una cena para que conozcas a tu pareja ideal",
              "https://www.nhflavors.com/wp-content/uploads/2018/02/romantic-dinner-BVI-740X474.jpg", DateTime(2019, 2, 10));
          yield SuccessState<Reward>(data: reward);
          break;
        case RewardEvent.getBrands:
          yield LoadingState();
          final brands = await repository.getBrands();
          yield SuccessState<List<Brand>>(data: brands);
          break;
      }
    } on Exception catch (e) {
      yield ErrorState(exception: e);
    }
  }
}

enum RewardEvent { getCurrent, getBrands }
