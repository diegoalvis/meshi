// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMatch _$UserMatchFromJson(Map<String, dynamic> json) {
  return UserMatch(
      id: json['id'] as int,
      name: json['name'] as String,
      images: (json['images'] as List)?.map((e) => e as String)?.toList(),
      lastDate: json['lastDate'] == null
          ? null
          : DateTime.parse(json['lastDate'] as String),
      idMatch: json['idMatch'] as int,
      lastMessage: json['lastMessage'] as String)
    ..type = json['type'] as String
    ..state = json['state'] as String
    ..erasedDate = json['erasedDate'] == null
        ? null
        : DateTime.parse(json['erasedDate'] as String);
}

Map<String, dynamic> _$UserMatchToJson(UserMatch instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'images': instance.images,
      'type': instance.type,
      'state': instance.state,
      'lastMessage': instance.lastMessage,
      'idMatch': instance.idMatch,
      'lastDate': instance.lastDate?.toIso8601String(),
      'erasedDate': instance.erasedDate?.toIso8601String()
    };
