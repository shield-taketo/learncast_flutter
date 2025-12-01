import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/video.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(<Video>[]) List<Video> videos,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _HomeState;
}
