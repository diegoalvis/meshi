/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/match_repository.dart';
import 'package:meshi/utils/base_state.dart';

class InterestsProfileBloc extends BaseBloc<InterestsProfileEvents, BaseState> {
  final int _userId;
  final MatchRepository _repository;

  InterestsProfileBloc(this._userId, this._repository) : super();

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(InterestsProfileEvents event) async* {
    try {
      switch (event) {
        case InterestsProfileEvents.getUserInfo:
          yield LoadingState();
          final user = await _repository.getProfile(_userId);
          yield SuccessState<User>(data: user);
          break;
        case InterestsProfileEvents.AddMatch:
          SuccessState<bool>(data: true);
          await _repository.addMatch(_userId);
          yield ExitState();
          break;
        case InterestsProfileEvents.DisLike:
          SuccessState<bool>(data: true);
          await _repository.dislike(_userId);
          yield ExitState();
          break;
      }
    } on Exception catch (e) {
      yield ErrorState(exception: e);
    }
  }
}

enum InterestsProfileEvents { getUserInfo, AddMatch, DisLike }
