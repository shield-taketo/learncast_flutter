import 'package:dio/dio.dart';

import '../../models/video_dto.dart';

abstract class VideoRemoteDataSource {
  Future<List<VideoDto>> fetchVideos();
  Future<VideoDto> toggleLike({required String videoId});
}

class VideoRemoteDataSourceImpl implements VideoRemoteDataSource {
  VideoRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<VideoDto>> fetchVideos() async {
    final response = await _dio.get<List<dynamic>>('/videos');
    final data = response.data ?? [];
    return data.map((json) => VideoDto.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<VideoDto> toggleLike({required String videoId}) async {
    final response = await _dio.post<Map<String, dynamic>>('/videos/$videoId/toggle_like');
    return VideoDto.fromJson(response.data!);
  }
}
