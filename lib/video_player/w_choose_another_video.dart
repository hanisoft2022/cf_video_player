import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vid_player/common/provider/provider.dart';

class WChooseAnotherVideo extends ConsumerWidget {
  const WChooseAnotherVideo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoNotifier = ref.watch(videoProvider.notifier);

    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
        onPressed: videoNotifier.tapToChooseVid,
        icon: const Icon(Icons.photo_camera_back),
        color: Colors.white,
      ),
    );
  }
}
