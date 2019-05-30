
import 'package:json_annotation/json_annotation.dart';

part 'match.g.dart';

@JsonSerializable(nullable: true)
class Match{
  int id;
  String name;
  List<String> images;
  String lastMessage;
  int idMatch;
  DateTime lastDate;

  Match({this.id, this.name, this.images, this.lastDate, this.idMatch, this.lastMessage});

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);
  Map<String, dynamic> toJson() => _$MatchToJson(this);

  factory Match.fromDatabase(Map<String, dynamic> json){
    json["images"] = (json["images"] as String)?.split(",") ?? [];
    return _$MatchFromJson(json);
  }

  Map<String, dynamic> toDatabase(){
    final json =  _$MatchToJson(this);
    json["images"] = (json['images'] as List)?.join(",") ?? null;
    return json;
  }

}