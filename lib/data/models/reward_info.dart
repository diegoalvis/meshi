import 'package:json_annotation/json_annotation.dart';
import 'package:meshi/data/models/my_likes.dart';
import 'package:meshi/data/models/reward.dart';

part 'reward_info.g.dart';

@JsonSerializable(nullable: true)
class RewardInfo {
  bool joined;
  bool winner;
  @JsonSerializable(nullable: true) Reward reward;
  @JsonSerializable(nullable: true) MyLikes couple;

  RewardInfo({this.reward, this.joined, this.winner, this.couple});

  factory RewardInfo.fromJson(Map<String, dynamic> json) => _$RewardInfoFromJson(json);

  Map<String, dynamic> toJson() => _$RewardInfoToJson(this);
}
