// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) {
  return UserPreferences(
      chat: json['chat'] as bool,
      match: json['match'] as bool,
      reward: json['reward'] as bool);
}

Map<String, dynamic> _$UserPreferencesToJson(UserPreferences instance) =>
    <String, dynamic>{
      'chat': instance.chat,
      'match': instance.match,
      'reward': instance.reward
    };
