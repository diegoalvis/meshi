import 'package:meshi/data/models/user_model.dart';
import 'package:rxdart/rxdart.dart';

class FormBloc {
  final _eduLevelIndexSubject = PublishSubject<int>();
  final _shapeSubject = PublishSubject<String>();
  final _heightSubject = PublishSubject<int>();
  final _userSubject = PublishSubject<User>();

  // stream outputs
  Stream<int> get eduLevelSelectedIndex => _eduLevelIndexSubject.stream;
  Stream<int> get heightSelected => _heightSubject.stream;
  Stream<String> get shapeSelected => _shapeSubject.stream;
  Stream<User> get user => _userSubject.stream;

  static const List<String> educationalLevels = [
    "Bachiller",
    "Tecnico",
    "Tecnologo",
    "Profesional",
    "Posrado"
  ];

  set height(int height) {
    _heightSubject.sink.add(height);
  }

  set eduLevelIndex(int eduLevelIndex) {
    _eduLevelIndexSubject.sink.add(eduLevelIndex);
  }

  set shape(String shape) {
    _shapeSubject.sink.add(shape);
  }

  void dispose() {
    _eduLevelIndexSubject.close();
    _shapeSubject.close();
    _heightSubject.close();
    _userSubject.close();
  }
}
