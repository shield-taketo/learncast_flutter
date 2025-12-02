import 'package:flutter_test/flutter_test.dart';
import 'package:learncast_flutter/data/datasources/remote/video_remote_data_source.dart';
import 'package:learncast_flutter/data/models/video_dto.dart';
import 'package:learncast_flutter/data/repositories/video_repository_impl.dart';
import 'package:learncast_flutter/domain/exceptions/app_exception.dart';
import 'package:mocktail/mocktail.dart';

class MockVideoRemoteDataSource extends Mock implements VideoRemoteDataSource {}

void main() {
  late MockVideoRemoteDataSource dataSource;
  late VideoRepositoryImpl repository;

  const dto = VideoDto(
    id: 'v1',
    title: 'Sample',
    thumbnailUrl: 'https://example.com/thumb.jpg',
    videoUrl: 'https://example.com/video.mp4',
    viewCount: 100,
    likeCount: 10,
    commentCount: 3,
    durationSeconds: 120,
    isLiked: true,
  );

  setUp(() {
    dataSource = MockVideoRemoteDataSource();
    repository = VideoRepositoryImpl(dataSource);
  });

  test('converts DTO list to entity list when fetchVideos succeeds', () async {
    when(() => dataSource.fetchVideos()).thenAnswer((_) async => const [dto]);

    final result = await repository.fetchVideos();

    expect(result.length, 1);
    expect(result.first.id, 'v1');
    expect(result.first.duration, const Duration(seconds: 120));
    expect(result.first.isLiked, true);
  });

  test('throws AppException when fetchVideos fails', () {
    when(() => dataSource.fetchVideos()).thenThrow(Exception('network'));

    expect(
      repository.fetchVideos,
      throwsA(isA<AppException>()),
    );
  });

  test('converts DTO to entity when toggleLike succeeds', () async {
    when(() => dataSource.toggleLike(videoId: 'v1')).thenAnswer((_) async => dto);

    final result = await repository.toggleLike(videoId: 'v1');

    expect(result.id, 'v1');
    expect(result.isLiked, true);
  });

  test('throws AppException when toggleLike fails', () {
    when(() => dataSource.toggleLike(videoId: 'v1')).thenThrow(Exception('network'));

    expect(
      () => repository.toggleLike(videoId: 'v1'),
      throwsA(isA<AppException>()),
    );
  });
}
