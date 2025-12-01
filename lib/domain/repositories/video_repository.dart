import '../entities/video.dart';

abstract class VideoRepository {
  Future<List<Video>> fetchVideos();
  Future<Video> toggleLike({required String videoId});
}
