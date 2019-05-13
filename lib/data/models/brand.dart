/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:json_annotation/json_annotation.dart';

part 'brand.g.dart';

@JsonSerializable(nullable: true)
class Brand {
  int id;
  String name;
  String image;

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);

  Brand();
}
