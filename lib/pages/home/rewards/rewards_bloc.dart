/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/brand.dart';
import 'package:meshi/data/models/reward_info.dart';
import 'package:meshi/data/repository/match_repository.dart';
import 'package:meshi/data/repository/reward_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/data/models/match.dart';

class RewardBloc extends BaseBloc<RewardEvent, BaseState> {
  final RewardRepository rewardRepository;
  final MatchRepository matchRepository;

  RewardBloc(SessionManager session, this.rewardRepository, this.matchRepository) : super(session);

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
          yield SuccessState<List<Match>>(data: matches);
          break;
        case RewardEventType.join:
          final rewardJoinInfo = event.data as RewardJoinInfo;
          final success = await rewardRepository.join(rewardJoinInfo.idReward, rewardJoinInfo.matches);
          if (success) {
            yield SuccessState<bool>(data: success);
          } else {
            yield ErrorState();
          }
          break;
      }
    } on Exception catch (e) {
      yield ErrorState(exception: e);
    }
  }
}

enum RewardEventType { getCurrent, getBrands, getMatches, join }

class RewardEvent<T> {
  final RewardEventType type;
  final T data;

  RewardEvent(this.type, {this.data});
}

class RewardJoinInfo {
  final int idReward;
  final List<Match> matches;

  RewardJoinInfo(this.idReward, this.matches);
}
