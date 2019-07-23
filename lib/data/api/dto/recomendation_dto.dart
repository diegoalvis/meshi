import 'package:json_annotation/json_annotation.dart';
import 'package:meshi/data/models/recomendation.dart';

part 'recomendation_dto.g.dart';

@JsonSerializable(nullable: true)
class RecomendationDto{

  int max;
  int tries;
  @JsonSerializable(nullable: true)
  List<Recomendation> recomendations;

  RecomendationDto({this.max, this.recomendations});

  factory RecomendationDto.fromJson(Map<String, dynamic> json) => _$RecomendationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RecomendationDtoToJson(this);

}