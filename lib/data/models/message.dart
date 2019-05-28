
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable(nullable: true)
class Message{

  int id;
  String content;
  DateTime date;
  int fromUser;
  int toUser;
  int matchId;

  Message({this.id, this.content, this.date, this.fromUser, this.toUser, this.matchId});

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

}