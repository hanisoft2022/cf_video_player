import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vid_player/common/video_tap_provider.dart';
import 'package:vid_player/video_player/s_video_player.dart';

import 'package:vid_player/video_selector/s_video_selector.dart';

class SHome extends ConsumerWidget {
  const SHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final video = ref.watch(videoTapProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: video == null ? const SVideoSelector() : const SVideoPlayer(),
    );
  }
}
