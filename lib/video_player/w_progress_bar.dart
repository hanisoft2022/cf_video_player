import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vid_player/video_player/provider/video_player_provider.dart';

class WProgressBar extends ConsumerWidget {
  const WProgressBar({super.key});

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(videoPlayerProvider.notifier);
    final videoState = ref.watch(videoPlayerProvider);

    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Row(
        children: [
          // 현재 재생 시각 표시
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              _formatDuration(videoState.controller!.value.position),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          // 슬라이더
          Expanded(
            child: Slider(
              min: 0.0,
              max: videoState.controller!.value.duration.inSeconds.toDouble(),
              value: videoState.controller!.value.position.inSeconds.toDouble(),
              onChanged: notifier.onSliderChanged,
              activeColor: Colors.blue,
            ),
          ),
          // 전체 비디오 길이
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              _formatDuration(videoState.controller!.value.duration),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
