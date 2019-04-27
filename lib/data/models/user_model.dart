/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:io';

import 'package:meshi/utils/gender.dart';

const USER_PICTURE_NUMBER = 4;

class User {
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
  DateTime birthDate;
  List<String> images;
  Gender gender;
  Set<Gender> likeGender;
  String eduLevel;
  String bodyShape;
  Set<String> bodyShapePreferred;
  int height;
  double income;
  int minAgePreferred, maxAgePreferred;
  double minIncomePreferred, maxIncomePreferred;
  bool isIncomeImportant;

  // form questions
  Habits habits = Habits();
  Deepening deepening = Deepening();

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
    data['birthdate'] = this.birthDate;
    data['gender'] = this.gender.name;
    data['likeGender'] = this.likeGender?.map((gender) => gender.name)?.toList();
    data['location'] = this.location;
    data['description'] = this.description;
    data['freeTime'] = this.freeTime;
    data['occupation'] = this.occupation;
    data['interests'] = this.interests;
    data['idFacebook'] = this.idFacebook;
    data['images'] = this.images?.join(",");
    return data;
  }
}

class Habits {
  String smoke;
  String drink;
  String sport;
  String likeSmoke;
  String likeDrink;
  String likeSport;

  Habits();

  Habits.fromHabits(Habits habits) {
    this.smoke = habits.smoke;
    this.drink = habits.drink;
    this.sport = habits.sport;
    this.likeSmoke = habits.likeSmoke;
    this.likeDrink = habits.likeDrink;
    this.likeSport = habits.likeSport;
  }
}

class Deepening {
  String marriage;
  int children = 0;
  String planChildren;
  bool likeChildren;
  List<String> priorities;
  List<String> clothingStyle;
  bool isImportantClothing;
  List<String> likeClothing;
  List<String> activities;
  String isImportantAppearance;
  String places;
  List<String> topics;
  String politics;
  String music;

  Deepening();

  Deepening.fromDeepening(Deepening deepening) {
    this.marriage = deepening.marriage;
    this.children = deepening.children;
    this.planChildren = deepening.planChildren;
    this.likeChildren = deepening.likeChildren;
    this.priorities = deepening.priorities;
    this.clothingStyle = deepening.clothingStyle;
    this.isImportantClothing = deepening.isImportantClothing;
    this.likeClothing = deepening.likeClothing;
    this.activities = deepening.activities;
    this.isImportantAppearance = deepening.isImportantAppearance;
    this.places = deepening.places;
    this.topics = deepening.topics;
    this.politics = deepening.politics;
    this.music = deepening.music;
  }
}
