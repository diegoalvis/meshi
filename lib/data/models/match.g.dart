// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Match _$MatchFromJson(Map<String, dynamic> json) {
  return Match(
      id: json['id'] as int,
      name: json['name'] as String,
      images: (json['images'] as List)?.map((e) => e as String)?.toList(),
      lastDate: json['lastDate'] == null
          ? null
          : DateTime.parse(json['lastDate'] as String),
      idMatch: json['idMatch'] as int,
      lastMessage: json['lastMessage'] as String);
}

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'images': instance.images,
      'lastMessage': instance.lastMessage,
      'idMatch': instance.idMatch,
      'lastDate': instance.lastDate?.toIso8601String()
    };
