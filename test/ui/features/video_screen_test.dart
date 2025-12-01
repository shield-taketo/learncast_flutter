import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learncast_flutter/domain/entities/video.dart';
import 'package:learncast_flutter/ui/features/video/video_screen.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

class _FakeVideoPlayerPlatform extends Fake with MockPlatformInterfaceMixin implements VideoPlayerPlatform {
  @override
  Future<void> init() async {}

  @override
  Future<void> dispose(int textureId) async {}

  @override
  Future<void> setLooping(int textureId, bool looping) async {}

  @override
  Future<void> setVolume(int textureId, double volume) async {}

  @override
  Future<void> play(int textureId) async {}

  @override
  Future<void> pause(int textureId) async {}

  @override
  Future<void> seekTo(int textureId, Duration position) async {}

  @override
  Future<Duration> getPosition(int textureId) async => Duration.zero;

  @override
  Future<int?> create(DataSource dataSource) async => 1;

  @override
  Future<int?> createWithOptions(VideoCreationOptions options) async => 1;

  @override
  Stream<VideoEvent> videoEventsFor(int textureId) async* {}

  @override
  Future<void> setPlaybackSpeed(int textureId, double speed) async {}
}

void main() {
  const sample = Video(
    id: 'v1',
    title: 'Sample Video',
    thumbnailUrl: 'https://example.com/thumb.jpg',
    videoUrl: 'https://example.com/video.mp4',
    viewCount: 123,
    likeCount: 10,
    commentCount: 3,
    duration: Duration(minutes: 3, seconds: 21),
    isLiked: false,
  );

  setUpAll(() {
    VideoPlayerPlatform.instance = _FakeVideoPlayerPlatform();
  });

  testWidgets('VideoScreen shows app bar title and basic layout', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: VideoScreen(
            video: sample,
          ),
        ),
      ),
    );

    expect(find.text('Sample Video'), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
