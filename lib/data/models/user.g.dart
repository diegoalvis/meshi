// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      id: json['id'] as int,
      createdDate: json['createdDate'] as String,
      type: json['type'] as String,
      state: json['state'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      freeTime: json['freeTime'] as String,
      occupation: json['occupation'] as String,
      interests: json['interests'] as String,
      idFacebook: json['idFacebook'] as String,
      birthdate: json['birthdate'] == null
          ? null
          : DateTime.parse(json['birthdate'] as String),
      images: (json['images'] as List)?.map((e) => e as String)?.toList(),
      gender: json['gender'] as String,
      likeGender:
          (json['likeGender'] as List)?.map((e) => e as String)?.toList(),
      eduLevel: json['eduLevel'] as String,
      bodyShape: json['bodyShape'] as String,
      bodyShapePreferred: (json['bodyShapePreferred'] as List)
          ?.map((e) => e as String)
          ?.toList(),
      height: json['height'] as int,
      income: (json['income'] as num)?.toDouble(),
      minAgePreferred: json['minAgePreferred'] as int,
      maxAgePreferred: json['maxAgePreferred'] as int,
      minIncomePreferred: (json['minIncomePreferred'] as num)?.toDouble(),
      maxIncomePreferred: (json['maxIncomePreferred'] as num)?.toDouble(),
      isIncomeImportant: json['isIncomeImportant'] as bool,
      planStartDate: json['planStartDate'] == null
          ? null
          : DateTime.parse(json['planStartDate'] as String),
      planEndDate: json['planEndDate'] == null
          ? null
          : DateTime.parse(json['planEndDate'] as String),
      habits: json['habits'] == null
          ? null
          : Habits.fromJson(json['habits'] as Map<String, dynamic>),
      deepening: json['deepening'] == null
          ? null
          : Deepening.fromJson(json['deepening'] as Map<String, dynamic>));
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'createdDate': instance.createdDate,
      'type': instance.type,
      'state': instance.state,
      'name': instance.name,
      'email': instance.email,
      'location': instance.location,
      'description': instance.description,
      'freeTime': instance.freeTime,
      'occupation': instance.occupation,
      'interests': instance.interests,
      'idFacebook': instance.idFacebook,
      'birthdate': instance.birthdate?.toIso8601String(),
      'images': instance.images,
      'gender': instance.gender,
      'likeGender': instance.likeGender,
      'eduLevel': instance.eduLevel,
      'bodyShape': instance.bodyShape,
      'bodyShapePreferred': instance.bodyShapePreferred,
      'height': instance.height,
      'income': instance.income,
      'minAgePreferred': instance.minAgePreferred,
      'maxAgePreferred': instance.maxAgePreferred,
      'minIncomePreferred': instance.minIncomePreferred,
      'maxIncomePreferred': instance.maxIncomePreferred,
      'isIncomeImportant': instance.isIncomeImportant,
      'habits': instance.habits,
      'deepening': instance.deepening
    };
