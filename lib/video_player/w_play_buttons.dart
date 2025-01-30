import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vid_player/video_player/provider/provider.dart';

class WPlayButtons extends ConsumerWidget {
  const WPlayButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(videoPlayerProvider);
    final notifier = ref.watch(videoPlayerProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 뒤로가기 아이콘버튼
        IconButton(
          color: Colors.white,
          onPressed: notifier.onRewind,
          icon: const Icon(Icons.rotate_left),
        ),
        // 재생&정지 아이콘버튼
        IconButton(
          color: Colors.white,
          onPressed: notifier.onPlayPause,
          icon: Icon(notifier.isPlaying ? Icons.pause : Icons.play_arrow),
        ),
        // 앞으로가기 아이콘버튼
        IconButton(
          color: Colors.white,
          onPressed: notifier.onForward,
          icon: const Icon(Icons.rotate_right),
        ),
      ],
    );
  }
}
