// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recomendation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recomendation _$RecomendationFromJson(Map<String, dynamic> json) {
  return Recomendation(
      id: json['id'] as int,
      type: json['type'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      freeTime: json['freeTime'] as String,
      occupation: json['occupation'] as String,
      interests: json['interests'] as String,
      score: json['score'] as int,
      gender: json['gender'] as String,
      images: (json['images'] as List)?.map((e) => e as String)?.toList(),
      similarities: (json['similarities'] as List)
          ?.map((e) =>
              e == null ? null : Similarity.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$RecomendationToJson(Recomendation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'description': instance.description,
      'freeTime': instance.freeTime,
      'occupation': instance.occupation,
      'interests': instance.interests,
      'score': instance.score,
      'gender': instance.gender,
      'images': instance.images,
      'similarities': instance.similarities
    };

Similarity _$SimilarityFromJson(Map<String, dynamic> json) {
  return Similarity(
      label: json['label'] as String,
      value: json['value'] as String,
      type: json['type'] as String);
}

Map<String, dynamic> _$SimilarityToJson(Similarity instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
      'type': instance.type
    };
