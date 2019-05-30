/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/match.dart';
import 'package:meshi/data/models/my_likes.dart';
import 'package:meshi/data/repository/match_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/utils/base_state.dart';

class InterestsBloc extends BaseBloc<InterestsEventType, BaseState> {
  MatchRepository repository;

  InterestsBloc(SessionManager session, this.repository) : super(session);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(InterestsEventType event) async* {
    try {
      switch (event) {
        case InterestsEventType.getMutals:
          yield LoadingState();
          final matches = await repository.getMatches();
          yield SuccessState<List<Match>>(data: matches);
          break;
        case InterestsEventType.getLikesMe:
          yield LoadingState();
          final myLikes = await repository.getLikesMe();
          yield LikesFetchedState(myLikes);
          break;
        case InterestsEventType.getMyLikes:
          yield LoadingState();
          final myLikes = await repository.getMyLikes();
          yield LikesFetchedState(myLikes);
          break;
        case InterestsEventType.onMyLikesPageSelected:
          yield InitialState<InterestsEventType>(initialData: InterestsEventType.getMyLikes);
          break;
        case InterestsEventType.onLikesMePageSelected:
          yield InitialState<InterestsEventType>(initialData: InterestsEventType.getLikesMe);
          break;
        case InterestsEventType.onMutualPageSelected:
          yield InitialState();
          break;
      }
    } on Exception catch (e) {
      yield ErrorState(exception: e);
    }
  }
}

enum InterestsEventType { getMutals, getLikesMe, getMyLikes, onMyLikesPageSelected, onLikesMePageSelected, onMutualPageSelected }

class InterestsEvent {
  final InterestsEventType type;
  dynamic data;

  InterestsEvent(this.type, {this.data});
}

class LikesFetchedState extends BaseState {
  List<MyLikes> myLikes;

  LikesFetchedState(this.myLikes): super(props: [myLikes]);

  @override
  String toString() => 'state-likes-fetched';
}