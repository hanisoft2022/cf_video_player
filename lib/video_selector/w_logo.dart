import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vid_player/common/provider/provider.dart';

class WLogo extends ConsumerWidget {
  const WLogo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoNotifier = ref.watch(videoProvider.notifier);

    return GestureDetector(
      onTap: videoNotifier.onLogoTapToChooseAnotherVideo,
      child: Image.asset('asset/image/logo.png'),
    );
  }
}
