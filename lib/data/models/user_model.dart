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

  // form questions
  List<String> habits = new List(6);
  List<String> specifics = new List(17);

  User({this.name, this.email, this.age, this.photos, this.gender, this.fbToken});
}

// TODO create utils class for these

const Map<String, List<int>> FormSections = {
  "BASIC": [1, 4],
  "HABITOS": [5, 6],
  "OTROS": [7, 10],
};

const List<String> YesNoOptions = [
  "Si",
  "No",
];

const List<String> GenericFormOptions1 = [
  "Si",
  "No",
  "Ocasionalmente",
];

const List<String> GenericFormOptions2 = [
  "Si",
  "No",
  "No si es ocasionalmente",
];

const List<String> GenericFormOptions3 = [
  "Si",
  "No",
  "No he decidido",
];

const List<String> GenericFormOptions4 = [
  "Si, a corto plazo",
  "Si, a largo plazo",
];

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

const List<String> DressStyle = [
  "Seductor",
  "Suelto y ligero",
  "Propio",
  "Elegante",
  "Casual",
  "Deportivo",
];

const List<String> LifeGoals = [
  "Familia",
  "Trabajo",
  "Conocimiento/estudio",
  "Progreso",
  "Amigos",
];

const List<String> CoupleActivities = [
  "Viajar a otros países",
  "Hacer deporte",
  "Viajes locales",
  "Cocinar",
  "Ir a nuevos restaurantes",
  "Salir a bailar",
  "Ver películas y series en casa",
  "Salir a tomar unos tragos y conversar",
];
