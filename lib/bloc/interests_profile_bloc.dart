/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/match_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/utils/base_state.dart';

class InterestsProfileBloc extends BaseBloc<InterestEvent, BaseState> {
  final int _userId;
  final MatchRepository repository;

  InterestsProfileBloc(this._userId, SessionManager session, this.repository) : super(session);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(InterestEvent event) async* {
    try {
      switch (event) {
        case InterestEvent.getUserInfo:
          yield LoadingState();
          final user = await repository.getProfile(_userId);
          yield SuccessState<User>(data: user);
          break;
      }
    } on Exception catch (e) {
      yield ErrorState(exception: e);
    }
  }
}

enum InterestEvent { getUserInfo }
