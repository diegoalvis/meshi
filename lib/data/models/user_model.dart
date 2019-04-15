/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:io';

import 'package:meshi/utils/gender.dart';

const USER_PICTURE_NUMBER = 4;

class User {
  /// User states
  static const String new_user = "new";
  static const String basic_user = "basic";
  static const String advanced_user = "advanced";

  int id;
  String createdDate;
  String type;
  String state;
  String name;
  String email;
  String location;
  String description;
  String freeTime;
  String occupation;
  String interests;
  String idFacebook;
  String images;
  DateTime birthDate;
  List<File> pictures;
  Gender gender;
  Set<Gender> likeGenders = Set();
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

  User(
      {this.id,
      this.createdDate,
      this.type,
      this.state,
      this.name,
      this.email,
//        this.birthDate,
//        this.gender,
//        this.likeGenders,
      this.location,
      this.description,
      this.freeTime,
      this.occupation,
      this.interests,
      this.idFacebook,
      this.images});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['createdDate'];
    type = json['type'];
    state = json['state'];
    name = json['name'];
    email = json['email'];
//    birthDate = json['birthdate'];
//    gender = json['gender'];
//    likeGenders = json['likeGender'];
    location = json['location'];
    description = json['description'];
    freeTime = json['freeTime'];
    occupation = json['occupation'];
    interests = json['interests'];
    idFacebook = json['idFacebook'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdDate'] = this.createdDate;
    data['type'] = this.type;
    data['state'] = this.state;
    data['name'] = this.name;
    data['email'] = this.email;
//    data['birthdate'] = this.birthDate;
//    data['gender'] = this.gender;
//    data['likeGender'] = this.likeGenders;
    data['location'] = this.location;
    data['description'] = this.description;
    data['freeTime'] = this.freeTime;
    data['occupation'] = this.occupation;
    data['interests'] = this.interests;
    data['idFacebook'] = this.idFacebook;
    data['images'] = this.images;
    return data;
  }
}

// TODO create utils class for these
const Map<String, List<int>> FormSections = {
  "BASIC": [1, 4],
  "HABITOS": [5, 6],
  "OTROS": [7, 16],
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

const List<String> ImportanceLevels = [
  "Muy importante",
  "Importante",
  "No es crucial o decisiva",
  "Nada importante",
];

const List<String> PlaceType = [
  "Refinados",
  "Convencionales",
  "Sencillos",
  "Cualquiera",
];

const List<String> RelevantTopics = [
  "ARTE",
  "EXPERIENCIAS",
  "PROFESIONALES",
  "SOCIALES",
  "POLITICA",
  "FARANDULA",
  "HISTORIA",
  "MUSICA",
];

const List<String> PoliticIdeology = [
  "Derecha, tengo la creencia que las cosas deben ganarse por mérito y por libre competitividad.",
  "Izquierda, tengo la creencia que la igualdad social es el camino hacia la prosperidad de un país",
  "Centro, tengo la creencia que debe de haber un balance entre la libre competitividad y la propiedad privada y la oferta de oportunidades para los más vulnerables.",
  "No tengo ideología política",
];

const List<String> MusicalGenre = [
  "Urbano",
  "Pop",
  "Rock",
  "Salsa",
  "Crossover",
];
