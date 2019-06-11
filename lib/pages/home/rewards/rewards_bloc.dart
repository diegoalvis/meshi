/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/brand.dart';
import 'package:meshi/data/models/reward_info.dart';
import 'package:meshi/data/models/user_match.dart';
import 'package:meshi/data/repository/match_repository.dart';
import 'package:meshi/data/repository/reward_repository.dart';
import 'package:meshi/utils/base_state.dart';

class RewardBloc extends BaseBloc<RewardEventType, BaseState> {
  final RewardRepository rewardRepository;
  final MatchRepository matchRepository;

  RewardBloc(this.rewardRepository, this.matchRepository) : super();

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(RewardEventType event) async* {
    try {
      switch (event) {
        case RewardEventType.getCurrent:
          yield LoadingState();
          final rewardInfo = await rewardRepository.getCurrent();
          yield SuccessState<RewardInfo>(data: rewardInfo);
          break;
        case RewardEventType.getBrands:
          yield LoadingState();
          final brands = await rewardRepository.getBrands();
          yield SuccessState<List<Brand>>(data: brands);
          break;
      }
    } on Exception catch (e) {
      yield ErrorState(exception: e);
    }
  }
}

enum RewardEventType { getCurrent, getBrands }