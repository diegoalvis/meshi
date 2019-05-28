// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
      id: json['id'] as int,
      content: json['content'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      fromUser: json['fromUser'] as int,
      toUser: json['toUser'] as int,
      matchId: json['matchId'] as int);
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'date': instance.date?.toIso8601String(),
      'fromUser': instance.fromUser,
      'toUser': instance.toUser,
      'matchId': instance.matchId
    };
