/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:meshi/data/models/deepening.dart';
import 'package:meshi/data/models/habits.dart';

part 'user.g.dart';

const USER_PICTURE_NUMBER = 4;

@JsonSerializable(nullable: true)
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
  @JsonSerializable(nullable: true) DateTime birthdate;
  @JsonSerializable(nullable: true) List<String> images;
  String gender;
  @JsonSerializable(nullable: true) Set<String> likeGender;
  String eduLevel;
  String bodyShape;
  @JsonSerializable(nullable: true) Set<String> bodyShapePreferred;
  int height;
  double income;
  int minAgePreferred, maxAgePreferred;
  double minIncomePreferred, maxIncomePreferred;
  bool isIncomeImportant;
  // form questions
  @JsonSerializable(nullable: true) Habits habits = Habits();
  @JsonSerializable(nullable: true) Deepening deepening = Deepening();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User({
      this.id,
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
      this.habits,
      this.deepening});

/*
  
  User(
      {this.id,
      this.createdDate,
      this.type,
      this.state,
      this.name,
      this.email,
      this.birthDate,
      this.gender,
      this.likeGender,
      this.location,
      this.description,
      this.freeTime,
      this.occupation,
      this.interests,
      this.idFacebook,
      this.images});

  
  User.fromJson(Map json) {
    id = int.tryParse(json['id'].toString());
    createdDate = json['createdDate'];
    type = json['type'];
    state = json['state'];
    name = json['name'];
    email = json['email'];
    birthDate = DateTime.parse(json['birthdate']);
    gender = json['gender'];
    likeGender = json['likeGender'].cast<String>().toSet();
    location = json['location'];
    description = json['description'];
    freeTime = json['freeTime'];
    occupation = json['occupation'];
    interests = json['interests'];
    idFacebook = json['idFacebook'];
    images = json['images'].cast<String>();
  }

  String toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['createdDate'] = this.createdDate;
    data['type'] = this.type;
    data['state'] = this.state;
    data['name'] = this.name;
    data['email'] = this.email;
    data['birthdate'] = this.birthDate.toIso8601String();
    data['gender'] = this.gender;
    data['likeGender'] = this.likeGender;
    data['location'] = this.location;
    data['description'] = this.description;
    data['freeTime'] = this.freeTime;
    data['occupation'] = this.occupation;
    data['interests'] = this.interests;
    data['idFacebook'] = this.idFacebook;
    data['images'] = this.images;
    return json.encode(data);
  }
  */
}
