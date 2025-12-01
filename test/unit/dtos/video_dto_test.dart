import 'package:flutter_test/flutter_test.dart';
import 'package:learncast_flutter/data/models/video_dto.dart';

void main() {
  test('VideoDto JSON encode/decode works correctly', () {
    final json = {
      'id': 'v1',
      'title': 'Sample',
      'thumbnail_url': 'https://example.com/thumb.jpg',
      'video_url': 'https://example.com/video.mp4',
      'view_count': 100,
      'like_count': 10,
      'comment_count': 3,
      'duration_seconds': 120,
      'is_liked': true,
    };

    final dto = VideoDto.fromJson(json);

    expect(dto.id, 'v1');
    expect(dto.title, 'Sample');
    expect(dto.thumbnailUrl, 'https://example.com/thumb.jpg');
    expect(dto.videoUrl, 'https://example.com/video.mp4');
    expect(dto.viewCount, 100);

    final encoded = dto.toJson();
    expect(encoded['id'], 'v1');
    expect(encoded['view_count'], 100);
  });
}
