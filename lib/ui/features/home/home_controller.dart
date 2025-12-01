import 'package:flutter_riverpod/legacy.dart';

import '../../../app/config/providers.dart';
import '../../../domain/entities/video.dart';
import '../../../domain/repositories/video_repository.dart';
import 'home_state.dart';

final homeControllerProvider = StateNotifierProvider<HomeController, HomeState>((ref) {
  final repository = ref.watch(videoRepositoryProvider);
  return HomeController(repository)..load();
});

class HomeController extends StateNotifier<HomeState> {
  HomeController(this._repository) : super(const HomeState());

  final VideoRepository _repository;

  Future<void> load() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final videos = await _repository.fetchVideos();
      state = state.copyWith(videos: videos, isLoading: false);
    } on Exception catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '動画一覧の取得に失敗しました',
      );
    }
  }

  Future<void> toggleLike(Video video) async {
    final updatedLocal = state.videos
        .map(
          (v) => v.id == video.id
              ? v.copyWith(
                  isLiked: !v.isLiked,
                  likeCount: v.isLiked ? v.likeCount - 1 : v.likeCount + 1,
                )
              : v,
        )
        .toList();
    state = state.copyWith(videos: updatedLocal);

    try {
      final updated = await _repository.toggleLike(videoId: video.id);
      final fixed = state.videos.map((v) => v.id == updated.id ? updated : v).toList();
      state = state.copyWith(videos: fixed);
    } on Exception catch (_) {
      final rollback = state.videos
          .map(
            (v) => v.id == video.id ? video : v,
          )
          .toList();
      state = state.copyWith(videos: rollback);
    }
  }
}
