// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Video _$VideoFromJson(Map<String, dynamic> json) => _Video(
  id: json['id'] as String,
  title: json['title'] as String,
  thumbnailUrl: json['thumbnailUrl'] as String,
  videoUrl: json['videoUrl'] as String,
  viewCount: (json['viewCount'] as num).toInt(),
  likeCount: (json['likeCount'] as num).toInt(),
  commentCount: (json['commentCount'] as num).toInt(),
  duration: Duration(microseconds: (json['duration'] as num).toInt()),
  isLiked: json['isLiked'] as bool,
);

Map<String, dynamic> _$VideoToJson(_Video instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'thumbnailUrl': instance.thumbnailUrl,
  'videoUrl': instance.videoUrl,
  'viewCount': instance.viewCount,
  'likeCount': instance.likeCount,
  'commentCount': instance.commentCount,
  'duration': instance.duration.inMicroseconds,
  'isLiked': instance.isLiked,
};
