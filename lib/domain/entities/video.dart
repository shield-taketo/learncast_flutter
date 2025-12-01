import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
abstract class Video with _$Video {
  const factory Video({
    required String id,
    required String title,
    required String thumbnailUrl,
    required String videoUrl,
    required int viewCount,
    required int likeCount,
    required int commentCount,
    required Duration duration,
    required bool isLiked,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
}
