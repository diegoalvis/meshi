import 'package:json_annotation/json_annotation.dart';

part 'my_likes.g.dart';

const String TYPE_FREE = "free";
const String TYPE_PREMIUM = "premium";

@JsonSerializable(nullable: true)
class MyLikes {
  int id;
  String name;
  List<String> images;
  String type;

  MyLikes({this.id, this.name, this.images, this.type});

  factory MyLikes.fromJson(Map<String, dynamic> json) => _$MyLikesFromJson(json);
  Map<String, dynamic> toJson() => _$MyLikesToJson(this);

}