// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardInfo _$RewardInfoFromJson(Map<String, dynamic> json) {
  return RewardInfo(
      reward: json['reward'],
      joined: json['joined'],
      winner: json['winner'],
      couple: json['couple']);
}

Map<String, dynamic> _$RewardInfoToJson(RewardInfo instance) =>
    <String, dynamic>{
      'reward': instance.reward,
      'joined': instance.joined,
      'winner': instance.winner,
      'couple': instance.couple
    };
