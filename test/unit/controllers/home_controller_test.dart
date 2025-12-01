import 'package:flutter_test/flutter_test.dart';
import 'package:learncast_flutter/domain/entities/video.dart';
import 'package:learncast_flutter/domain/repositories/video_repository.dart';
import 'package:learncast_flutter/ui/features/home/home_controller.dart';
import 'package:learncast_flutter/ui/features/home/home_state.dart';
import 'package:mocktail/mocktail.dart';

class MockRepo extends Mock implements VideoRepository {}

void main() {
  const sample = Video(
    id: '1',
    title: 'A',
    thumbnailUrl: '',
    videoUrl: '',
    viewCount: 0,
    likeCount: 10,
    commentCount: 0,
    duration: Duration(seconds: 10),
    isLiked: false,
  );

  late MockRepo repo;
  late HomeController controller;

  setUp(() {
    repo = MockRepo();
    controller = HomeController(repo);
  });

  test('load success updates state', () async {
    when(() => repo.fetchVideos()).thenAnswer((_) async => [sample]);

    await controller.load();

    expect(controller.state.isLoading, false);
    expect(controller.state.videos.length, 1);
  });

  test('toggleLike optimistic update', () async {
    controller = HomeController(repo)..state = const HomeState(videos: [sample]);

    when(() => repo.toggleLike(videoId: '1')).thenAnswer((_) async => sample.copyWith(isLiked: true, likeCount: 11));

    await controller.toggleLike(sample);

    expect(controller.state.videos.first.isLiked, true);
    expect(controller.state.videos.first.likeCount, 11);
  });
}
