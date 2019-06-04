import 'package:json_annotation/json_annotation.dart';
import 'package:meshi/data/models/my_likes.dart';
import 'package:meshi/data/models/reward.dart';

part 'reward_info.g.dart';

@JsonSerializable(nullable: true)
class RewardInfo{

  Reward reward;
  bool joined;
  bool winner;
  MyLikes couple;

  RewardInfo({reward, joined, winner, couple});

  factory RewardInfo.fromJson(Map<String, dynamic> json) => _$RewardInfoFromJson(json);
  Map<String, dynamic> toJson() => _$RewardInfoToJson(this);

}