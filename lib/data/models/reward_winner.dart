/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */
import 'package:json_annotation/json_annotation.dart';
import 'package:meshi/data/models/my_likes.dart';

@JsonSerializable(nullable: true)
class RewardWinner {
  int joinId;
  int id;
  String name;
  String description;
  int value;
  int numCouples;
  DateTime publishDate;
  DateTime validDate;
  DateTime choseDate;
  String image;
  @JsonSerializable(nullable: true)
  MyLikes couple;

  RewardWinner(
      {this.couple,
      this.joinId,
      this.id,
      this.name,
      this.description,
      this.value,
      this.numCouples,
      this.publishDate,
      this.validDate,
      this.choseDate,
      this.image});
}
