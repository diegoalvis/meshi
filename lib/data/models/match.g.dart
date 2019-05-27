// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Matchs _$MatchsFromJson(Map<String, dynamic> json) {
  return Matchs(
      id: json['id'] as int,
      name: json['name'] as String,
      images: (json['images'] as List)?.map((e) => e as String)?.toList(),
      lastDate: json['lastDate'] == null
          ? null
          : DateTime.parse(json['lastDate'] as String),
      idMatch: json['idMatch'] as String,
      lastMessage: json['lastMessage'] as String);
}

Map<String, dynamic> _$MatchsToJson(Matchs instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'images': instance.images,
      'lastMessage': instance.lastMessage,
      'idMatch': instance.idMatch,
      'lastDate': instance.lastDate?.toIso8601String()
    };
