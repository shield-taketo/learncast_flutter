import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_dto.freezed.dart';
part 'video_dto.g.dart';

@freezed
abstract class VideoDto with _$VideoDto {
  const factory VideoDto({
    required String id,
    required String title,
    @JsonKey(name: 'thumbnail_url') required String thumbnailUrl,
    @JsonKey(name: 'video_url') required String videoUrl,
    @JsonKey(name: 'view_count') required int viewCount,
    @JsonKey(name: 'like_count') required int likeCount,
    @JsonKey(name: 'comment_count') required int commentCount,
    @JsonKey(name: 'duration_seconds') required int durationSeconds,
    @JsonKey(name: 'is_liked') required bool isLiked,
  }) = _VideoDto;

  factory VideoDto.fromJson(Map<String, dynamic> json) => _$VideoDtoFromJson(json);
}
