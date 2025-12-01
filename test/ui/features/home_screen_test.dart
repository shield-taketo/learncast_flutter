import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learncast_flutter/app/config/providers.dart';
import 'package:learncast_flutter/domain/entities/video.dart';
import 'package:learncast_flutter/domain/repositories/video_repository.dart';
import 'package:learncast_flutter/ui/features/home/home_screen.dart';

class _FakeVideoRepository implements VideoRepository {
  @override
  Future<List<Video>> fetchVideos() async => const [];

  @override
  Future<Video> toggleLike({required String videoId}) async {
    return Video(
      id: videoId,
      title: 'dummy',
      thumbnailUrl: '',
      videoUrl: '',
      viewCount: 0,
      likeCount: 0,
      commentCount: 0,
      duration: Duration.zero,
      isLiked: false,
    );
  }
}

void main() {
  testWidgets('empty list shows fallback text', (tester) async {
    final emptyRepository = _FakeVideoRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          videoRepositoryProvider.overrideWithValue(emptyRepository),
        ],
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('動画一覧の取得に失敗しました'), findsOneWidget);
  });
}
