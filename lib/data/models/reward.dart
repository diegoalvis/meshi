import 'package:json_annotation/json_annotation.dart';

part 'reward.g.dart';

@JsonSerializable(nullable: true)
class Reward{
  int id;
  String name;
  String description;
  int value;
  int numCouples;
  DateTime publishDate;
  DateTime validDate;
  DateTime choseDate;
  String image;

  Reward({this.id, this.name, this.description, this.value, this.numCouples,
  this.publishDate, this.validDate, this.choseDate, this.image});

  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);
  Map<String, dynamic> toJson() => _$RewardToJson(this);

}