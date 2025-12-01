import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/video.dart';
import '../../ui/features/home/home_screen.dart';
import '../../ui/features/video/video_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: HomeScreen.routeName,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/videos/:id',
        name: VideoScreen.routeName,
        builder: (context, state) {
          final video = state.extra! as Video;
          return VideoScreen(video: video);
        },
      ),
    ],
  );
});
