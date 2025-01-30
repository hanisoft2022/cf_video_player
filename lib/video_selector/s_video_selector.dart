import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vid_player/video_selector/w_logo.dart';
import 'package:vid_player/video_selector/w_title.dart';

LinearGradient customGradient() {
  return const LinearGradient(
      colors: [Colors.blue, Colors.black],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
}

class SVideoSelector extends StatelessWidget {
  const SVideoSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: customGradient(),
      ),
      width: double.infinity,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WLogo(),
          Gap(10),
          WTitle(),
        ],
      ),
    );
  }
}
