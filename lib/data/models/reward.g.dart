// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reward _$RewardFromJson(Map<String, dynamic> json) {
  return Reward(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      value: json['value'] as int,
      numCouples: json['numCouples'] as int,
      publishDate: json['publishDate'] == null
          ? null
          : DateTime.parse(json['publishDate'] as String),
      validDate: json['validDate'] == null
          ? null
          : DateTime.parse(json['validDate'] as String),
      choseDate: json['choseDate'] == null
          ? null
          : DateTime.parse(json['choseDate'] as String),
      image: json['image'] as String);
}

Map<String, dynamic> _$RewardToJson(Reward instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'value': instance.value,
      'numCouples': instance.numCouples,
      'publishDate': instance.publishDate?.toIso8601String(),
      'validDate': instance.validDate?.toIso8601String(),
      'choseDate': instance.choseDate?.toIso8601String(),
      'image': instance.image
    };
