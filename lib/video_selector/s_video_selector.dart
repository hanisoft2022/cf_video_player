import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vid_player/video_selector/w_logo.dart';
import 'package:vid_player/video_selector/w_title.dart';

LinearGradient customGradient() {
  return const LinearGradient(colors: [Colors.blue, Colors.black], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}

class SVideoSelector extends StatelessWidget {
  final VoidCallback onTap;

  const SVideoSelector({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: customGradient(),
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WLogo(onTap: onTap),
          const Gap(10),
          const WTitle(),
        ],
      ),
    );
  }
}
