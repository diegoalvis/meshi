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
      from: json['from'] as int,
      to: json['to'] as int,
      matchId: json['matchId'] as int);
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'date': instance.date?.toIso8601String(),
      'from': instance.from,
      'to': instance.to,
      'matchId': instance.matchId
    };
