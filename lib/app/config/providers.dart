import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/datasources/remote/video_remote_data_source.dart';
import '../../data/repositories/video_repository_fake.dart';
import '../../data/repositories/video_repository_impl.dart';
import '../../domain/repositories/video_repository.dart';
import 'env.dart';

const _useFakeInDebug = true;

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  return dio;
});

final videoRemoteDataSourceProvider = Provider<VideoRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return VideoRemoteDataSourceImpl(dio);
});

final videoRepositoryProvider = Provider<VideoRepository>((ref) {
  if (kDebugMode && _useFakeInDebug) {
    return FakeVideoRepository();
  }

  final dataSource = ref.watch(videoRemoteDataSourceProvider);
  return VideoRepositoryImpl(dataSource);
});
