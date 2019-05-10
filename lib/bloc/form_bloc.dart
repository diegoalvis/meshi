/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/api/BaseResponse.dart';
import 'package:meshi/data/models/deepening.dart';
import 'package:meshi/data/models/habits.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:rxdart/rxdart.dart';

class FormBloc extends BaseBloc {
  static const MIN_INCOME = 1000000.0;
  static const MAX_INCOME = 10000000.0;
  static const STEP_INCOME = 500000.0; // step value for the slider

  static const int MIN_AGE = 18;
  static const int MAX_AGE = 50;

  final _userSubject = PublishSubject<User>();
  final _basicsSubject = PublishSubject<List<String>>();
  final _habitsSubject = PublishSubject<Habits>();
  final _deepeningSubject = PublishSubject<Deepening>();

  Stream<User> get userStream => _userSubject.stream;
  Stream<Habits> get habitsStream => _habitsSubject.stream;
  Stream<Deepening> get deepeningStream => _deepeningSubject.stream;

  UserRepository repository;

  User user;// = session.user;


  set height(int height) {
    user.height = height;
    _userSubject.sink.add(user);
  }

  set eduLevel(String eduLevel) {
    user.eduLevel = eduLevel;
    _userSubject.sink.add(user);
  }

  set eduLevelIndex(String eduLevel) {
    user.eduLevel = eduLevel;
    _userSubject.sink.add(user);
  }

  set shape(String shapeBody) {
    user.bodyShape = shapeBody;
    _userSubject.sink.add(user);
  }

  set income(double income) {
    user.income = income;
    _userSubject.sink.add(user);
  }

  set isIncomeImportant(bool isIncomeImportant) {
    user.isIncomeImportant = isIncomeImportant;
    _userSubject.sink.add(user);
  }

  void ageRangePreferred(int minAgePreferred, int maxAgePreferred) {
    user.minAgePreferred = minAgePreferred;
    user.maxAgePreferred = maxAgePreferred;
    _userSubject.sink.add(user);
  }

  void incomeRangePreferred(double minIncomePreferred, double maxIncomePreferred) {
    user.minIncomePreferred = minIncomePreferred;
    user.maxIncomePreferred = maxIncomePreferred;
    _userSubject.sink.add(user);
  }

  void updateBodyShapePreferred(String bodyShapePreferred) {
    if(user.bodyShapePreferred == null) {
      user.bodyShapePreferred = Set();
    }

    if (user.bodyShapePreferred.contains(bodyShapePreferred)) {
      user.bodyShapePreferred.remove(bodyShapePreferred);
    } else {
      user.bodyShapePreferred.add(bodyShapePreferred);
    }
    _userSubject.sink.add(user);
  }

  void updateHabits(Habits habits) {
    user.habits = habits;
    _habitsSubject.sink.add(user.habits);
  }

  void updateDeepening(Deepening deepening) {
    user.deepening = deepening;
    _deepeningSubject.sink.add(user.deepening);
  }

  Observable<BaseResponse> updateUserInfo() {
    progressSubject.sink.add(true);
    return repository.updateUserAdvancedInfo(user).handleError((error) {
      errorSubject.sink.add(error.toString());
    }).doOnEach((data) => progressSubject.sink.add(false));
  }

  @override dispose() {
    _userSubject.close();
    _basicsSubject.close();
    _habitsSubject.close();
    _deepeningSubject.close();
  }
}
