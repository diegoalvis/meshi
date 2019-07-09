import 'package:json_annotation/json_annotation.dart';

part 'user_match.g.dart';

const String MATCH_BLOCKED = "blocked";

@JsonSerializable(nullable: true)
class UserMatch {
  int id;
  String name;
  List<String> images;
  String type;
  String state;
  String lastMessage;
  int idMatch;
  DateTime lastDate;
  DateTime erasedDate;

  UserMatch(
      {this.id,
      this.name,
      this.images,
      this.lastDate,
      this.idMatch,
      this.lastMessage,
      this.erasedDate,
      this.type});

  factory UserMatch.fromMessage(Map<String, dynamic> msg) {
    final data = msg["data"];
    final id = data["id"] == null ? null : int.parse(data["id"]);
    final name = data["name"] as String;
    final lastDate = data["lastDate"] == null ? null : DateTime.parse(data["lastDate"] as String);
    final idMatch = data["idMatch"] == null ? null : int.parse(data["idMatch"]);
    final lastMessage = data["lastMessage"] as String;
    final erasedDate = data["erasedDate"] == null ? null : DateTime.parse(data["erasedDate"] as String);
    return UserMatch(id: id, name: name, lastDate: lastDate, idMatch: idMatch, lastMessage: lastMessage, erasedDate: erasedDate);
  }
  factory UserMatch.fromJson(Map<String, dynamic> json) => _$UserMatchFromJson(json);
  Map<String, dynamic> toJson() => _$UserMatchToJson(this);

  factory UserMatch.fromDatabase(Map<String, dynamic> json) {
    final obj = Map.of(json);
    obj["images"] = (obj["images"] as String)?.split(",") ?? [];
    return _$UserMatchFromJson(obj);
  }

  Map<String, dynamic> toDatabase() {
    final json = _$UserMatchToJson(this);
    json["images"] = (json['images'] as List)?.join(",") ?? null;
    return json;
  }
}
