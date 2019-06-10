/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:meshi/data/models/user.dart';

part 'user_dto.g.dart';

const USER_PICTURE_NUMBER = 4;

@JsonSerializable(nullable: true)
class UserDto {
  String token;
  User user;

  UserDto({this.token, this.user});

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

}
