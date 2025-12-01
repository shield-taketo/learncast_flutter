// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoDto _$VideoDtoFromJson(Map<String, dynamic> json) => _VideoDto(
  id: json['id'] as String,
  title: json['title'] as String,
  thumbnailUrl: json['thumbnail_url'] as String,
  videoUrl: json['video_url'] as String,
  viewCount: (json['view_count'] as num).toInt(),
  likeCount: (json['like_count'] as num).toInt(),
  commentCount: (json['comment_count'] as num).toInt(),
  durationSeconds: (json['duration_seconds'] as num).toInt(),
  isLiked: json['is_liked'] as bool,
);

Map<String, dynamic> _$VideoDtoToJson(_VideoDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'thumbnail_url': instance.thumbnailUrl,
  'video_url': instance.videoUrl,
  'view_count': instance.viewCount,
  'like_count': instance.likeCount,
  'comment_count': instance.commentCount,
  'duration_seconds': instance.durationSeconds,
  'is_liked': instance.isLiked,
};
