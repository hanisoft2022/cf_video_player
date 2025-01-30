import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vid_player/common/video_tap_provider.dart';

class WLogo extends ConsumerWidget {
  const WLogo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(videoTapProvider.notifier);

    return GestureDetector(
      onTap: notifier.onTap,
      child: Image.asset('asset/image/logo.png'),
    );
  }
}
