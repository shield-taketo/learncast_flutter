import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learncast_flutter/domain/entities/video.dart';
import 'package:learncast_flutter/ui/widgets/video_list_item.dart';
import 'package:network_image_mock/network_image_mock.dart';

void _noop() {}

void main() {
  testWidgets('renders stats text and duration correctly', (tester) async {
    const video = Video(
      id: 'v1',
      title: 'Sample Video',
      thumbnailUrl: 'https://example.com/thumb.jpg',
      videoUrl: 'https://example.com/video.mp4',
      viewCount: 1234,
      likeCount: 10,
      commentCount: 5,
      duration: Duration(minutes: 2, seconds: 30),
      isLiked: false,
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VideoListItem(
              video: video,
              onTap: _noop,
              onToggleLike: _noop,
            ),
          ),
        ),
      );

      expect(find.text('Sample Video'), findsOneWidget);
      expect(find.text('1,234'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
      expect(find.text('2:30'), findsOneWidget);
    });
  });

  testWidgets('shows filled heart icon when video is liked', (tester) async {
    const likedVideo = Video(
      id: 'v1',
      title: 'Liked',
      thumbnailUrl: 'https://example.com/thumb.jpg',
      videoUrl: 'https://example.com/video.mp4',
      viewCount: 0,
      likeCount: 1,
      commentCount: 0,
      duration: Duration.zero,
      isLiked: true,
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VideoListItem(
              video: likedVideo,
              onTap: _noop,
              onToggleLike: _noop,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });
  });
}
