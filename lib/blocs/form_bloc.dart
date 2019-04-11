/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:rxdart/rxdart.dart';

class FormBloc {
  static const MIN_INCOME = 1000000.0;
  static const MAX_INCOME = 10000000.0;
  static const STEP_INCOME = 500000.0; // step value for the slider

  static const int MIN_AGE = 18;
  static const int MAX_AGE = 50;

  final User user = SessionManager.instance.user;

  final _userSubject = PublishSubject<User>();
  final _basicsSubject = PublishSubject<List<String>>();
  final _habitsSubject = PublishSubject<List<String>>();
  final _specificsSubject = PublishSubject<List<String>>();

  Stream<User> get userStream => _userSubject.stream;
  Stream<List<String>> get habitsStream => _habitsSubject.stream;
  Stream<List<String>> get specificsStream => _specificsSubject.stream;

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

  ageRangePreferred(int minAgePreferred, int maxAgePreferred) {
    user.minAgePreferred = minAgePreferred;
    user.maxAgePreferred = maxAgePreferred;
    _userSubject.sink.add(user);
  }

  incomeRangePreferred(double minIncomePreferred, double maxIncomePreferred) {
    user.minIncomePreferred = minIncomePreferred;
    user.maxIncomePreferred = maxIncomePreferred;
    _userSubject.sink.add(user);
  }

  updateBodyShapePreferred(String bodyShapePreferred) {
    if (user.bodyShapePreferred.contains(bodyShapePreferred)) {
      user.bodyShapePreferred.remove(bodyShapePreferred);
    } else {
      user.bodyShapePreferred.add(bodyShapePreferred);
    }
    _userSubject.sink.add(user);
  }

  // Form data
  habits(int index, String answer) {
    user.habits[index] = answer;
    _habitsSubject.sink.add(user.habits);
  }

  specifics(int index, String answer) {
    user.specifics[index] = answer;
    _specificsSubject.sink.add(user.specifics);
  }

  void dispose() {
    _userSubject.close();
    _basicsSubject.close();
    _habitsSubject.close();
    _specificsSubject.close();
  }
}
