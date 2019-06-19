// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardInfo _$RewardInfoFromJson(Map<String, dynamic> json) {
  return RewardInfo(
      reward: json['reward'] == null
          ? null
          : Reward.fromJson(json['reward'] as Map<String, dynamic>),
      joined: json['joined'] as bool,
      winner: json['winner'] as bool,
      couple: json['couple'] == null
          ? null
          : MyLikes.fromJson(json['couple'] as Map<String, dynamic>),
      joinId: json['joinId'] as int);
}

Map<String, dynamic> _$RewardInfoToJson(RewardInfo instance) =>
    <String, dynamic>{
      'joined': instance.joined,
      'winner': instance.winner,
      'joinId': instance.joinId,
      'reward': instance.reward,
      'couple': instance.couple
    };
