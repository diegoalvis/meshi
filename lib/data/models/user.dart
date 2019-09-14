/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:meshi/data/models/deepening.dart';
import 'package:meshi/data/models/habits.dart';
import 'package:meshi/data/models/user_preferences.dart';

part 'user.g.dart';

const USER_PICTURE_NUMBER = 4;

@JsonSerializable(nullable: true)
class User {
  static const String NEW_USER = "new";
  static const String BASIC_USER = "basic";
  static const String ADVANCED_USER = "advanced";
  static const String DISABLED_USER = "disabled";

  int id;
  String createdDate;
  String type; // premium or not
  String state; // new, basic, advanced, disabled
  String name;
  String email;
  String location;
  String description;
  String freeTime;
  String occupation;
  String interests;
  String idFacebook;
  @JsonSerializable(nullable: true)
  DateTime birthdate;
  @JsonSerializable(nullable: true)
  List<String> images;
  String gender;
  @JsonSerializable(nullable: true)
  List<String> likeGender;
  String eduLevel;
  String bodyShape;
  @JsonSerializable(nullable: true)
  List<String> bodyShapePreferred;
  int height;
  double income;
  int minAgePreferred, maxAgePreferred;
  double minIncomePreferred, maxIncomePreferred;
  bool isIncomeImportant;
  @JsonSerializable(nullable: true)
  DateTime planStartDate;
  @JsonSerializable(nullable: true)
  DateTime planEndDate;

  // form questions
  @JsonSerializable(nullable: true)
  Habits habits = Habits();
  @JsonSerializable(nullable: true)
  Deepening deepening = Deepening();
  @JsonSerializable(nullable: true)
  UserPreferences preferences = UserPreferences();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User(
      {this.id,
      this.createdDate,
      this.type,
      this.state,
      this.name,
      this.email,
      this.location,
      this.description,
      this.freeTime,
      this.occupation,
      this.interests,
      this.idFacebook,
      this.birthdate,
      this.images,
      this.gender,
      this.likeGender,
      this.eduLevel,
      this.bodyShape,
      this.bodyShapePreferred,
      this.height,
      this.income,
      this.minAgePreferred,
      this.maxAgePreferred,
      this.minIncomePreferred,
      this.maxIncomePreferred,
      this.isIncomeImportant,
      this.planStartDate,
      this.planEndDate,
      this.habits,
      this.deepening,
      this.preferences});
}
