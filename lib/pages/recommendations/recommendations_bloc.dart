/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:bloc/bloc.dart';
import 'package:meshi/data/models/recomendation.dart';
import 'package:meshi/managers/location_manager.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/data/repository/match_repository.dart';

class RecommendationsBloc extends Bloc<RecommendationsEvents, BaseState> {
  final MatchRepository _repository;
  LocationManager locationManager;
  List<Recomendation> users;
  int max = 0;

  RecommendationsBloc(this._repository, this.locationManager);

  @override
  get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(RecommendationsEvents event) async* {
    if (event is GetRecommendationsEvent) {
      yield* _loadRecommendationsToState();
    } else if (event is AddMatchEvent) {
      try {
        yield AddingMatchState(event.user.id);
        await _repository.addMatch(event.user.id);
        users.remove(event.user);
        yield SuccessState<List<Recomendation>>(data: users);
      } on Exception catch (e) {
        yield ErrorState(exception: e);
      }
    }else if (event is DeleteInterestEvent) {
      try {
        yield AddingMatchState(event.user.id);
        await _repository.dislike(event.user.id);
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
      final data = await _repository.getRecommendations();
      max = data.max;
      users = data.recomendations;
      yield SuccessState<List<Recomendation>>(data: users);
    } on Exception catch (e) {
      yield ErrorState(exception: e);
    }
  }
}

abstract class RecommendationsEvents {}

class GetRecommendationsEvent extends RecommendationsEvents {
  @override
  String toString() {
    return "GetRecommendations";
  }
}

class AddMatchEvent extends RecommendationsEvents {
  final Recomendation user;

  AddMatchEvent(this.user);

  @override
  String toString() => 'AddMatch {user: $user}';
}

class DeleteInterestEvent extends RecommendationsEvents {
  final Recomendation user;

  DeleteInterestEvent(this.user);

  @override
  String toString() => 'AddMatch {user: $user}';
}

class AddingMatchState extends BaseState {
  final int idMatch;

  AddingMatchState(this.idMatch): super(props: [idMatch]);

  @override
  String toString() => 'state-adding-match';
}

