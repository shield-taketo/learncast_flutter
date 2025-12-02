import 'package:flutter_test/flutter_test.dart';
import 'package:learncast_flutter/domain/entities/video.dart';
import 'package:learncast_flutter/domain/repositories/video_repository.dart';
import 'package:learncast_flutter/ui/features/home/home_controller.dart';
import 'package:learncast_flutter/ui/features/home/home_state.dart';
import 'package:mocktail/mocktail.dart';

class MockRepo extends Mock implements VideoRepository {}

const _sample = Video(
  id: '1',
  title: 'A',
  thumbnailUrl: '',
  videoUrl: '',
  viewCount: 0,
  likeCount: 10,
  commentCount: 0,
  duration: Duration(seconds: 60),
  isLiked: false,
);

void main() {
  late MockRepo repo;
  late HomeController controller;

  setUp(() {
    repo = MockRepo();
    controller = HomeController(repo);
  });

  test('has default initial state', () {
    expect(controller.state, const HomeState());
  });

  test('updates state correctly when load succeeds', () async {
    when(() => repo.fetchVideos()).thenAnswer((_) async => const [_sample]);

    await controller.load();

    expect(controller.state.isLoading, false);
    expect(controller.state.errorMessage, isNull);
    expect(controller.state.videos, const [_sample]);
  });

  test('sets error message when load fails', () async {
    when(() => repo.fetchVideos()).thenThrow(Exception('network'));

    await controller.load();

    expect(controller.state.isLoading, false);
    expect(controller.state.videos, isEmpty);
    expect(controller.state.errorMessage, '動画一覧の取得に失敗しました');
  });

  test('updates liked video when toggleLike succeeds', () async {
    controller = HomeController(repo)..state = const HomeState(videos: [_sample]);

    final updated = _sample.copyWith(isLiked: true, likeCount: 11);

    when(() => repo.toggleLike(videoId: _sample.id)).thenAnswer((_) async => updated);

    await controller.toggleLike(_sample);

    expect(controller.state.videos.single, updated);
  });

  test('rolls back optimistic update when toggleLike fails', () async {
    controller = HomeController(repo)..state = const HomeState(videos: [_sample]);

    when(() => repo.toggleLike(videoId: _sample.id)).thenThrow(Exception('api error'));

    final before = controller.state.videos.single;

    await controller.toggleLike(_sample);

    expect(controller.state.videos.single, before);
  });
}
