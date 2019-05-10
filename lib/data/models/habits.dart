/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'habits.g.dart';

@JsonSerializable(nullable: true)
class Habits {
  String smoke;
  String drink;
  String sport;
  String likeSmoke;
  String likeDrink;
  String likeSport;

  factory Habits.fromJson(Map<String, dynamic> json) => _$HabitsFromJson(json);

  Map<String, dynamic> toJson() => _$HabitsToJson(this);

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