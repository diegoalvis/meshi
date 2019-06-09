/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/user_match.dart';
import 'package:meshi/data/repository/match_repository.dart';
import 'package:meshi/data/repository/reward_repository.dart';
import 'package:meshi/utils/base_state.dart';

class SelectPartnerBloc extends BaseBloc<SelectPartnerEvent, BaseState> {
  final int rewardId;
  final RewardRepository rewardRepository;
  final MatchRepository matchRepository;

  SelectPartnerBloc(this.rewardId, this.rewardRepository, this.matchRepository) : super();

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(SelectPartnerEvent event) async* {
    try {
      switch (event.event) {
        case SelectPartnerEventType.updateInscription:
          yield PerformingRequestState();
          final success = await rewardRepository.join(rewardId, [event.data as UserMatch]);
          yield SuccessState<bool>(data: success);
          break;
        case SelectPartnerEventType.getMatches:
          yield LoadingState();
          final matches = await matchRepository.getMatches();
          yield SuccessState<List<UserMatch>>(data: matches);
          break;
        case SelectPartnerEventType.selectPartner:
          yield PartnerSelectedState(event.data as UserMatch);
          break;
      }
    } on Exception catch (e) {
      yield ErrorState(exception: e);
    }
  }
}

enum SelectPartnerEventType { updateInscription, getMatches, selectPartner }

class SelectPartnerEvent<T> {
  final SelectPartnerEventType event;
  final T data;

  SelectPartnerEvent(this.event, {this.data});
}

class PartnerSelectedState extends BaseState {
  final UserMatch match;

  PartnerSelectedState(this.match) : super(props: [match]);

  @override
  String toString() => 'select-partner-initial';
}
