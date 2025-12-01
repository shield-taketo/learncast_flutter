import 'dart:async';

import '../../domain/entities/video.dart';
import '../../domain/repositories/video_repository.dart';

class FakeVideoRepository implements VideoRepository {
  FakeVideoRepository() {
    _videos = <Video>[
      const Video(
        id: 'video_1',
        title: '動画1',
        thumbnailUrl: 'https://plus.unsplash.com/premium_photo-1764435536930-c93558fa72c6?q=80&w=1523&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        viewCount: 1240,
        likeCount: 120,
        commentCount: 32,
        duration: Duration(seconds: 634),
        isLiked: false,
      ),
      const Video(
        id: 'video_2',
        title: '動画2',
        thumbnailUrl: 'https://plus.unsplash.com/premium_photo-1763978502997-8d59ea014ec2?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
        viewCount: 980,
        likeCount: 80,
        commentCount: 12,
        duration: Duration(seconds: 425),
        isLiked: true,
      ),
      const Video(
        id: 'video_3',
        title: '動画3',
        thumbnailUrl: 'https://plus.unsplash.com/premium_photo-1697648334379-91a258f98f7d?q=80&w=1622&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
        viewCount: 2000,
        likeCount: 260,
        commentCount: 58,
        duration: Duration(seconds: 912),
        isLiked: false,
      ),
    ];
  }

  late List<Video> _videos;

  @override
  Future<List<Video>> fetchVideos() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return _videos;
  }

  @override
  Future<Video> toggleLike({required String videoId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));

    final index = _videos.indexWhere((v) => v.id == videoId);
    if (index == -1) {
      throw Exception('Video not found');
    }

    final current = _videos[index];
    final updated = current.copyWith(
      isLiked: !current.isLiked,
      likeCount: current.isLiked ? current.likeCount - 1 : current.likeCount + 1,
    );

    _videos[index] = updated;
    return updated;
  }
}
