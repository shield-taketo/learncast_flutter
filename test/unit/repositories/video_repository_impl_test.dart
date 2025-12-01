import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learncast_flutter/data/datasources/remote/video_remote_data_source.dart';
import 'package:learncast_flutter/data/repositories/video_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio dio;
  late VideoRemoteDataSource ds;
  late VideoRepositoryImpl repo;

  setUp(() {
    dio = MockDio();
    ds = VideoRemoteDataSourceImpl(dio);
    repo = VideoRepositoryImpl(ds);
  });

  test('fetchVideos returns list of videos', () async {
    when(() => dio.get<List<dynamic>>(any())).thenAnswer(
      (_) async => Response(
        data: [
          {
            'id': 'v1',
            'title': 'Sample',
            'thumbnail_url': 'https://example.com/thumb.jpg',
            'video_url': 'https://example.com/video.mp4',
            'view_count': 100,
            'like_count': 10,
            'comment_count': 3,
            'duration_seconds': 120,
            'is_liked': true,
          },
        ],
        statusCode: 200,
        requestOptions: RequestOptions(),
      ),
    );

    final result = await repo.fetchVideos();
    expect(result.length, 1);
    expect(result.first.id, 'v1');
  });
}
