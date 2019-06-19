/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:bloc/bloc.dart';
import 'package:meshi/data/models/recomendation.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/match_repository.dart';

class RecommendationsBloc extends Bloc<RecommendationsEvents, BaseState> {
  final MatchRepository _repository;
  List<Recomendation> users;

  RecommendationsBloc(this._repository);

  @override
  get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(RecommendationsEvents event) async* {
    if (event is GetRecommendationsEvent) {
      yield* _loadRecommendationsToState();
    } else if (event is AddMatchEvent) {
      try {
        yield PerformingRequestState();
        await _repository.addMatch(event.user.id);
        users.remove(event.user);
        yield SuccessState<List<Recomendation>>(data: users);
      } on Exception catch (e) {
        yield ErrorState(exception: e);
      }
    }
  }

  Stream<BaseState> _loadRecommendationsToState() async* {
    try {
      yield LoadingState();
      users = await _repository.getRecommendations();
      yield SuccessState<List<Recomendation>>(data: users);
    } on Exception catch (e) {
      yield ErrorState(exception: e);
    }
  }
}

class RecommendationsEvents {}

class GetRecommendationsEvent extends RecommendationsEvents {
  @override
  String toString() {
    return "GetRecommendations";
  }
}

class AddMatchEvent extends RecommendationsEvents {
  final User user;

  AddMatchEvent(this.user);

  @override
  String toString() => 'AddMatch {user: $user}';
}
