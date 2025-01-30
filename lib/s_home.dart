import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/common/provider/provider.dart';
import 'package:vid_player/video_player/s_video_player.dart';

import 'package:vid_player/video_selector/s_video_selector.dart';

class SHome extends ConsumerWidget {
  const SHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final XFile? video = ref.watch(videoProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: video == null ? const SVideoSelector() : SVideoPlayer(),
    );
  }
}
