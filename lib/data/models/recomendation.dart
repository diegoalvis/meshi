import 'package:json_annotation/json_annotation.dart';

part 'recomendation.g.dart';

@JsonSerializable(nullable: true)
class Recomendation {
  int id;
  String type;
  String name;
  String description;
  String freeTime;
  String occupation;
  String interests;
  int score;
  String gender;
  @JsonSerializable(nullable: true)
  List<String> images;
  @JsonSerializable(nullable: true)
  List<Similarity> similarities;

  Recomendation(
      {this.id,
      this.type,
      this.name,
      this.description,
      this.freeTime,
      this.occupation,
      this.interests,
      this.score,
      this.gender,
      this.images,
      this.similarities});

  factory Recomendation.fromJson(Map<String, dynamic> json) => _$RecomendationFromJson(json);
  Map<String, dynamic> toJson() => _$RecomendationToJson(this);
}

const String TYPE_INT = "int";
const String TYPE_STRING = "string";
const String TYPE_ARRAY = "array";

@JsonSerializable(nullable: true)
class Similarity {
  String label;
  String value;
  String type;

  Similarity({this.label, this.value, this.type});

  factory Similarity.fromJson(Map<String, dynamic> json) => _$SimilarityFromJson(json);
  Map<String, dynamic> toJson() => _$SimilarityToJson(this);
}
