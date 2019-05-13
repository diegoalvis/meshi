/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'deepening.g.dart';

@JsonSerializable(nullable: true)
class Deepening {
  String marriage;
  int children;
  String planChildren;
  bool likeChildren;
  @JsonSerializable(nullable: true)
  List<String> priorities;
  @JsonSerializable(nullable: true)
  List<String> clothingStyle;
  bool isImportantClothing;
  @JsonSerializable(nullable: true)
  List<String> likeClothing;
  @JsonSerializable(nullable: true)
  List<String> activities;
  String isImportantAppearance;
  String places;
  @JsonSerializable(nullable: true)
  List<String> topics;
  String politics;
  String music;

  factory Deepening.fromJson(Map<String, dynamic> json) => _$DeepeningFromJson(json);

  Map<String, dynamic> toJson() => _$DeepeningToJson(this);

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

enum UserEducation { bachelor, technical, technologist, professional, postgraduate }

enum UserShape { thin, medium, big }

enum UserMarriage { yes, no, maybe }

enum UserPlanChildren { yes, no, maybe }

enum UserLikeAppearance { important, normal, nothing }

enum UserPlaces { refined, conventional, simple, any }

enum UserPolitics { left, center, right, nothing }

enum UserMusic { urban, pop, rock, salsa, crossover }
