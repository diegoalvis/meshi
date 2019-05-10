// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deepening.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deepening _$DeepeningFromJson(Map<String, dynamic> json) {
  return Deepening()
    ..marriage = json['marriage'] as String
    ..children = json['children'] as int
    ..planChildren = json['planChildren'] as String
    ..likeChildren = json['likeChildren'] as bool
    ..priorities =
        (json['priorities'] as List)?.map((e) => e as String)?.toList()
    ..clothingStyle =
        (json['clothingStyle'] as List)?.map((e) => e as String)?.toList()
    ..isImportantClothing = json['isImportantClothing'] as bool
    ..likeClothing =
        (json['likeClothing'] as List)?.map((e) => e as String)?.toList()
    ..activities =
        (json['activities'] as List)?.map((e) => e as String)?.toList()
    ..isImportantAppearance = json['isImportantAppearance'] as String
    ..places = json['places'] as String
    ..topics = (json['topics'] as List)?.map((e) => e as String)?.toList()
    ..politics = json['politics'] as String
    ..music = json['music'] as String;
}

Map<String, dynamic> _$DeepeningToJson(Deepening instance) => <String, dynamic>{
      'marriage': instance.marriage,
      'children': instance.children,
      'planChildren': instance.planChildren,
      'likeChildren': instance.likeChildren,
      'priorities': instance.priorities,
      'clothingStyle': instance.clothingStyle,
      'isImportantClothing': instance.isImportantClothing,
      'likeClothing': instance.likeClothing,
      'activities': instance.activities,
      'isImportantAppearance': instance.isImportantAppearance,
      'places': instance.places,
      'topics': instance.topics,
      'politics': instance.politics,
      'music': instance.music
    };
