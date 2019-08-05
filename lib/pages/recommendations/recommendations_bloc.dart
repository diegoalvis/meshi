/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
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
      try {
        yield LoadingState();
        final data = await _repository.getRecommendations(looked: event.looked);
        users = data.recomendations;
        max = data.max;
        int tries = data.tries;
        if (max < 1)
          yield SuccessState<List<Recomendation>>(data: users);
        else {
          if (tries < max) {
            yield SuccessState<List<Recomendation>>(data: users);
          } else {
            yield TriesCompleteState(true, users);
          }
        }
      } on Exception catch (e) {
        yield ErrorState(exception: e);
      }
    } else if (event is AddMatchEvent) {
      try {
        yield AddingMatchState(event.user.id);
        await _repository.addMatch(event.user.id);
        users.remove(event.user);
        yield SuccessState<List<Recomendation>>(data: users);
      } on Exception catch (e) {
        yield ErrorState(exception: e);
      }
    } else if (event is DeleteInterestEvent) {
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

  void sendLocation(BuildContext context) async {
    final location = await locationManager.getLocation(context);
    _repository.updateUserLocation(location.latitude, location.longitude);
  }
}

abstract class RecommendationsEvents {}

class GetRecommendationsEvent extends RecommendationsEvents {
  List<Recomendation> looked;

  GetRecommendationsEvent({this.looked});

  @override
  String toString() => "GetRecommendations";
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

  AddingMatchState(this.idMatch) : super(props: [idMatch]);

  @override
  String toString() => 'state-adding-match';
}

class TriesCompleteState extends BaseState {
  final bool isMaxComplete;
  final List<Recomendation> looked;

  TriesCompleteState(this.isMaxComplete, this.looked) : super(props: [isMaxComplete, looked]);

  @override
  String toString() => 'state-tries-complete';
}
