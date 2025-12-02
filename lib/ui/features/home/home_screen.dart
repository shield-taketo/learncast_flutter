import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/video_list_item.dart';
import 'home_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const routeName = 'home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeControllerProvider);
    final controller = ref.read(homeControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('LearnCast'),
      ),
      body: RefreshIndicator(
        onRefresh: controller.load,
        child: Builder(
          builder: (context) {
            if (state.isLoading && state.videos.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null && state.videos.isEmpty) {
              return ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Center(child: Text(state.errorMessage!)),
                ],
              );
            }

            if (!state.isLoading && state.errorMessage == null && state.videos.isEmpty) {
              return ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  const Center(
                    child: Text('動画がありません'),
                  ),
                ],
              );
            }

            return ListView.builder(
              itemCount: state.videos.length,
              itemBuilder: (context, index) {
                final video = state.videos[index];
                return VideoListItem(
                  video: video,
                  onTap: () => context.pushNamed(
                    'video',
                    pathParameters: {'id': video.id},
                    extra: video,
                  ),
                  onToggleLike: () => controller.toggleLike(video),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
