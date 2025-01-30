import 'package:flutter/material.dart';

class WPlayButtons extends StatelessWidget {
  final VoidCallback onRewind;
  final VoidCallback onPlayPause;
  final VoidCallback onForward;
  final bool isPlaying;

  const WPlayButtons({
    super.key,
    required this.onRewind,
    required this.onPlayPause,
    required this.onForward,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 뒤로가기 아이콘버튼
        IconButton(
          color: Colors.white,
          onPressed: onRewind,
          icon: const Icon(Icons.rotate_left),
        ),
        // 재생&정지 아이콘버튼
        IconButton(
          color: Colors.white,
          onPressed: onPlayPause,
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
        ),
        // 앞으로가기 아이콘버튼
        IconButton(
          color: Colors.white,
          onPressed: onForward,
          icon: const Icon(Icons.rotate_right),
        ),
      ],
    );
  }
}
