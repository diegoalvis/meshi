// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recomendation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecomendationDto _$RecomendationDtoFromJson(Map<String, dynamic> json) {
  return RecomendationDto(
      max: json['max'] as int,
      recomendations: (json['recomendations'] as List)
          ?.map((e) => e == null
              ? null
              : Recomendation.fromJson(e as Map<String, dynamic>))
          ?.toList())
    ..tries = json['tries'] as int;
}

Map<String, dynamic> _$RecomendationDtoToJson(RecomendationDto instance) =>
    <String, dynamic>{
      'max': instance.max,
      'tries': instance.tries,
      'recomendations': instance.recomendations
    };
