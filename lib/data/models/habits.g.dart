// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habits.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Habits _$HabitsFromJson(Map<String, dynamic> json) {
  return Habits()
    ..smoke = json['smoke'] as String
    ..drink = json['drink'] as String
    ..sport = json['sport'] as String
    ..likeSmoke = json['likeSmoke'] as String
    ..likeDrink = json['likeDrink'] as String
    ..likeSport = json['likeSport'] as String;
}

Map<String, dynamic> _$HabitsToJson(Habits instance) => <String, dynamic>{
      'smoke': instance.smoke,
      'drink': instance.drink,
      'sport': instance.sport,
      'likeSmoke': instance.likeSmoke,
      'likeDrink': instance.likeDrink,
      'likeSport': instance.likeSport
    };
