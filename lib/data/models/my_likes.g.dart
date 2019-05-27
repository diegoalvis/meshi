// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_likes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyLikes _$MyLikesFromJson(Map<String, dynamic> json) {
  return MyLikes(
      name: json['name'] as String,
      images: (json['images'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$MyLikesToJson(MyLikes instance) =>
    <String, dynamic>{'name': instance.name, 'images': instance.images};
