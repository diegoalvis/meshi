import 'package:meshi/utils/gender.dart';

class User {
  String name;
  String email;
  int age;
  List<String> photos;
  Gender gender;
  String fbToken;
  String eduLevel;
  String bodyShape;
  Set<String> bodyShapePreferred = new Set();
  int height;
  double income;
  int minAgePreferred, maxAgePreferred;
  double minIncomePreferred, maxIncomePreferred;
  bool isIncomeImportant = false;

  User({this.name, this.email, this.age, this.photos, this.gender, this.fbToken});
}

const List<String> EducationalLevels = [
  "Bachiller",
  "Tecnico",
  "Tecnologo",
  "Profesional",
  "Posrado",
];

const List<String> BodyShapeList = [
  "Delgad@",
  "Medio",
  "Grande",
];
