/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:bloc/bloc.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/data/repository/match_repository.dart';
import 'package:meshi/pages/home/recommendations/recommendations_event.dart';

class RecommendationsBloc extends Bloc<RecommendationsEvents, BaseState> {
  final MatchRepository _repository;
  //SessionManager session;
  List<User> users;

  RecommendationsBloc(this._repository);

  @override
  get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(RecommendationsEvents event) async* {
    if (event is GetRecommendationsEvent) {
      yield* _loadRecommendationsToState();
    } else if (event is AddMatchEvent) {
      yield* _addMatchToState(event);
    }
  }

  Stream<BaseState> _loadRecommendationsToState() async* {
    try {
      yield LoadingState();
//      users = await _repository.getRecommendations();
      users = List.generate(
          10,
          (index) => User(
                  id: int.parse('$index'),
                  name: "Juanita $index",
                  description: 'Descripcion $index',
                  images: [
                    "https://images.pexels.com/photos/1036623/pexels-photo-1036623.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
                  ]));
      yield SuccessState<List<User>>(data: users);
    } on Exception catch (e) {
      yield ErrorState(exception: e);
    }
  }

  Stream<BaseState> _addMatchToState(AddMatchEvent event) async* {
    try {
      await _repository.addMatch(event.user.id);
      users.remove(event.user);
      yield SuccessState<List<User>>(data: users);
    } on Exception catch (e) {
      yield ErrorState(exception: e);
    }
  }
}
