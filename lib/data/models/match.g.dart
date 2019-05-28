// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Matches _$MatchsFromJson(Map<String, dynamic> json) {
  return Matches(
      id: json['id'] as int,
      name: json['name'] as String,
      images: (json['images'] as List)?.map((e) => e as String)?.toList(),
      lastDate: json['lastDate'] == null
          ? null
          : DateTime.parse(json['lastDate'] as String),
      idMatch: json['idMatch'] as String,
      lastMessage: json['lastMessage'] as String);
}

Map<String, dynamic> _$MatchsToJson(Matches instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'images': instance.images,
      'lastMessage': instance.lastMessage,
      'idMatch': instance.idMatch,
      'lastDate': instance.lastDate?.toIso8601String()
    };
