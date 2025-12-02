import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learncast_flutter/app/config/providers.dart';
import 'package:learncast_flutter/domain/entities/video.dart';
import 'package:learncast_flutter/domain/repositories/video_repository.dart';
import 'package:learncast_flutter/ui/features/home/home_screen.dart';
import 'package:network_image_mock/network_image_mock.dart';

class _SuccessVideoRepository implements VideoRepository {
  _SuccessVideoRepository(this._videos);

  final List<Video> _videos;

  @override
  Future<List<Video>> fetchVideos() async => _videos;

  @override
  Future<Video> toggleLike({required String videoId}) async {
    final target = _videos.firstWhere((v) => v.id == videoId);
    return target.copyWith(
      isLiked: !target.isLiked,
      likeCount: target.isLiked ? target.likeCount - 1 : target.likeCount + 1,
    );
  }
}

class _EmptyVideoRepository implements VideoRepository {
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

class _ErrorVideoRepository implements VideoRepository {
  @override
  Future<List<Video>> fetchVideos() {
    throw Exception('network error');
  }

  @override
  Future<Video> toggleLike({required String videoId}) {
    throw Exception('not implemented');
  }
}

const _sample = Video(
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

void main() {
  Widget wrap(Widget child, VideoRepository repo) {
    return ProviderScope(
      overrides: [
        videoRepositoryProvider.overrideWithValue(repo),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('displays video list on successful load', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        wrap(const HomeScreen(), _SuccessVideoRepository(const [_sample])),
      );

      await tester.pumpAndSettle();

      expect(find.text('Sample Video'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });
  });

  testWidgets('empty list shows fallback text', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        wrap(const HomeScreen(), _EmptyVideoRepository()),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('動画がありません'), findsOneWidget);
    });
  });

  testWidgets('displays video list on successful load', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        wrap(const HomeScreen(), _ErrorVideoRepository()),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('動画一覧の取得に失敗しました'), findsOneWidget);
    });
  });
}
