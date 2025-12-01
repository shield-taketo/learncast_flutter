import 'package:flutter/material.dart';

import '../../domain/entities/video.dart';
import '../../utils/formatters/duration_formatter.dart';
import '../../utils/formatters/number_formatter.dart';

class VideoListItem extends StatelessWidget {
  const VideoListItem({
    super.key,
    required this.video,
    required this.onTap,
    required this.onToggleLike,
  });

  final Video video;
  final VoidCallback onTap;
  final VoidCallback onToggleLike;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onTap: onTap,
      leading: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            video.thumbnailUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        video.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          children: [
            _StatIconText(
              icon: Icons.visibility,
              text: formatNumber(video.viewCount),
            ),
            const SizedBox(width: 12),
            _StatIconText(
              icon: Icons.comment,
              text: video.commentCount.toString(),
            ),
            const SizedBox(width: 12),
            _StatIconText(
              icon: Icons.timer,
              text: formatDuration(video.duration),
            ),
          ],
        ),
      ),
      trailing: IconButton(
        onPressed: onToggleLike,
        icon: Icon(
          video.isLiked ? Icons.favorite : Icons.favorite_border,
          color: video.isLiked ? Colors.red : null,
        ),
      ),
    );
  }
}

class _StatIconText extends StatelessWidget {
  const _StatIconText({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
