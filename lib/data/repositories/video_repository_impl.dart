import '../../domain/entities/video.dart';
import '../../domain/exceptions/app_exception.dart';
import '../../domain/repositories/video_repository.dart';
import '../datasources/remote/video_remote_data_source.dart';
import '../models/video_dto.dart';

extension _VideoDtoMapper on VideoDto {
  Video toEntity() => Video(
    id: id,
    title: title,
    thumbnailUrl: thumbnailUrl,
    videoUrl: videoUrl,
    viewCount: viewCount,
    likeCount: likeCount,
    commentCount: commentCount,
    duration: Duration(seconds: durationSeconds),
    isLiked: isLiked,
  );
}

class VideoRepositoryImpl implements VideoRepository {
  VideoRepositoryImpl(this._remoteDataSource);

  final VideoRemoteDataSource _remoteDataSource;

  @override
  Future<List<Video>> fetchVideos() async {
    try {
      final dtos = await _remoteDataSource.fetchVideos();
      return dtos.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw AppException('Failed to fetch videos', cause: e);
    }
  }

  @override
  Future<Video> toggleLike({required String videoId}) async {
    try {
      final dto = await _remoteDataSource.toggleLike(videoId: videoId);
      return dto.toEntity();
    } catch (e) {
      throw AppException('Failed to toggle like', cause: e);
    }
  }
}
