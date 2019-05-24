/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:meshi/data/models/user.dart';

part 'suggestion.g.dart';

@JsonSerializable(nullable: true)
class Suggestion {
  int id;
  int compatibility;
  User user;

  Suggestion({this.id, this.compatibility, this.user});

  factory Suggestion.fromJson(Map<String, dynamic> json) => _$SuggestionFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestionToJson(this);
}
