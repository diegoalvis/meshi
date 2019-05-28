
import 'package:json_annotation/json_annotation.dart';

part 'match.g.dart';

@JsonSerializable(nullable: true)
class Matches{
  int id;
  String name;
  List<String> images;
  String lastMessage;
  String idMatch;
  DateTime lastDate;

  Matches({this.id, this.name, this.images, this.lastDate, this.idMatch, this.lastMessage});

  factory Matches.fromJson(Map<String, dynamic> json) => _$MatchsFromJson(json);
  Map<String, dynamic> toJson() => _$MatchsToJson(this);

}