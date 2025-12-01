import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learncast_flutter/domain/entities/video.dart';
import 'package:learncast_flutter/ui/widgets/video_list_item.dart';

class _NoNetworkHttpOverrides extends HttpOverrides {}

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
    HttpOverrides.global = _NoNetworkHttpOverrides();
  });

  testWidgets('VideoListItem shows title and counts', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VideoListItem(
            video: sample,
            onTap: () {},
            onToggleLike: () {},
          ),
        ),
      ),
    );

    expect(find.text('Sample Video'), findsOneWidget);
    expect(find.textContaining('123'), findsWidgets);
  });

  testWidgets('VideoListItem tap calls onTap', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VideoListItem(
            video: sample,
            onTap: () {
              tapped = true;
            },
            onToggleLike: () {},
          ),
        ),
      ),
    );

    await tester.tap(find.byType(VideoListItem));
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });
}
