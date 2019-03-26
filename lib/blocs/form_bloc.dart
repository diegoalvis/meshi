import 'package:meshi/data/models/user_model.dart';
import 'package:rxdart/rxdart.dart';

class FormBloc {
  static const MIN_INCOME = 1000000.0;
  static const MAX_INCOME = 10000000.0;
  static const STEP_INCOME = 500000.0; // step value for the slider

  static const MIN_AGE = 18;
  static const MAX_AGE = 50;

  final _user = User();

  final _userSubject = PublishSubject<User>();
  Stream<User> get userStream => _userSubject.stream;

  set height(int height) {
    _user.height = height;
    _userSubject.sink.add(_user);
  }

  set eduLevelIndex(String eduLevel) {
    _user.eduLevel = eduLevel;
    _userSubject.sink.add(_user);
  }

  set shape(String shapeBody) {
    _user.bodyShape = shapeBody;
    _userSubject.sink.add(_user);
  }

  set income(double income) {
    _user.income = income;
    _userSubject.sink.add(_user);
  }

  set isIncomeImportant(bool isIncomeImportant) {
    _user.isIncomeImportant = isIncomeImportant;
    _userSubject.sink.add(_user);
  }

  ageRangePreferred(int minAgePreferred, int maxAgePreferred) {
    _user.minAgePreferred = minAgePreferred;
    _user.maxAgePreferred = maxAgePreferred;
    _userSubject.sink.add(_user);
  }

  incomeRangePreferred(double minIncomePreferred, double maxIncomePreferred) {
    _user.minIncomePreferred = minIncomePreferred;
    _user.maxIncomePreferred = maxIncomePreferred;
    _userSubject.sink.add(_user);
  }

  updateBodyShapePreferred(String bodyShapePreferred) {
    if (_user.bodyShapePreferred.contains(bodyShapePreferred)) {
      _user.bodyShapePreferred.remove(bodyShapePreferred);
    } else {
      _user.bodyShapePreferred.add(bodyShapePreferred);
    }
    _userSubject.sink.add(_user);
  }

  void dispose() {
    _userSubject.close();
  }
}
