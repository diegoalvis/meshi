/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/match.dart';
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
          //final matches = await repository.getMatches();
          final matches = List.generate(10, (index) => Matches(name: "Grilla $index", lastDate: DateTime.now().subtract(Duration(days: index)), lastMessage: "msg $index", images: ["https://images.pexels.com/photos/1036623/pexels-photo-1036623.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"]));
          yield SuccessState<List<Matches>>(data: matches);
          break;
        case InterestsEventType.getLikesMe:
          // TODO: Handle this case.
          break;
        case InterestsEventType.getMyLikes:
          // TODO: Handle this case.
          break;
      }
    } on Exception catch (e) {
      yield ErrorState(exception: e);
    }
  }
}

enum InterestsEventType { getMutals, getLikesMe, getMyLikes }

class InterestsEvent {}
