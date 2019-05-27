import 'package:json_annotation/json_annotation.dart';

part 'my_likes.g.dart';

@JsonSerializable(nullable: true)
class MyLikes{
  String name;
  List<String> images;

  MyLikes({this.name, this.images});

  factory MyLikes.fromJson(Map<String, dynamic> json) => _$MyLikesFromJson(json);
  Map<String, dynamic> toJson() => _$MyLikesToJson(this);

}