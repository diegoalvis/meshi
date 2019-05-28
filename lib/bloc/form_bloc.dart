/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/deepening.dart';
import 'package:meshi/data/models/habits.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/utils/base_state.dart';
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

  FormBloc(this.repository, session) : super(session) {
    if (session.user?.deepening?.children == null) session.user?.deepening?.children = 0;
  }

  set height(int height) {
    session.user.height = height;
    _userSubject.sink.add(session.user);
  }

  set eduLevel(String eduLevel) {
    session.user.eduLevel = eduLevel;
    _userSubject.sink.add(session.user);
  }

  set eduLevelIndex(String eduLevel) {
    session.user.eduLevel = eduLevel;
    _userSubject.sink.add(session.user);
  }

  set shape(String shapeBody) {
    session.user.bodyShape = shapeBody;
    _userSubject.sink.add(session.user);
  }

  set income(double income) {
    session.user.income = income;
    _userSubject.sink.add(session.user);
  }

  set isIncomeImportant(bool isIncomeImportant) {
    session.user.isIncomeImportant = isIncomeImportant;
    _userSubject.sink.add(session.user);
  }

  void ageRangePreferred(int minAgePreferred, int maxAgePreferred) {
    session.user.minAgePreferred = minAgePreferred;
    session.user.maxAgePreferred = maxAgePreferred;
    _userSubject.sink.add(session.user);
  }

  void incomeRangePreferred(double minIncomePreferred, double maxIncomePreferred) {
    session.user.minIncomePreferred = minIncomePreferred;
    session.user.maxIncomePreferred = maxIncomePreferred;
    _userSubject.sink.add(session.user);
  }

  void updateBodyShapePreferred(String bodyShapePreferred) {
    if (session.user.bodyShapePreferred == null) {
      session.user.bodyShapePreferred = Set();
    }

    if (session.user.bodyShapePreferred.contains(bodyShapePreferred)) {
      session.user.bodyShapePreferred.remove(bodyShapePreferred);
    } else {
      session.user.bodyShapePreferred.add(bodyShapePreferred);
    }
    _userSubject.sink.add(session.user);
  }

  void updateHabits(Habits habits) {
    session.user.habits = habits;
    _habitsSubject.sink.add(session.user.habits);
  }

  void updateDeepening(Deepening deepening) {
    session.user.deepening = deepening;
    _deepeningSubject.sink.add(session.user.deepening);
  }

  Observable<bool> updateUserInfo() {
    progressSubject.sink.add(true);
    return repository.updateUserAdvancedInfo(session.user).handleError((error) {
      errorSubject.sink.add(error.toString());
    }).doOnEach((data) => progressSubject.sink.add(false));
  }

  @override
  dispose() {
    super.dispose();
    _userSubject.close();
    _basicsSubject.close();
    _habitsSubject.close();
    _deepeningSubject.close();
  }

}
