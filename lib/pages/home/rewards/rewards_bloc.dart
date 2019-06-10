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

class RewardBloc extends BaseBloc<RewardEvent, BaseState> {
  final RewardRepository rewardRepository;
  final MatchRepository matchRepository;

  RewardBloc(this.rewardRepository, this.matchRepository) : super();

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(RewardEvent event) async* {
    try {
      switch (event.type) {
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
        case RewardEventType.getMatches:
          yield LoadingState();
          final matches = await matchRepository.getMatches();
          yield SuccessState<List<UserMatch>>(data: matches);
          break;
      }
    } on Exception catch (e) {
      yield ErrorState(exception: e);
    }
  }
}

enum RewardEventType { getCurrent, getBrands, getMatches }

class RewardEvent<T> {
  final RewardEventType type;
  final T data;

  RewardEvent(this.type, {this.data});
}
