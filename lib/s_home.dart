import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/video_player/s_video_player.dart';

import 'package:vid_player/video_selector/s_video_selector.dart';

class SHome extends StatefulWidget {
  const SHome({super.key});

  @override
  State<SHome> createState() => _SHomeState();
}

class _SHomeState extends State<SHome> {
  XFile? video;

  onLogoTapToChooseAnotherVideo() async {
    final XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    setState(() => this.video = video);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: video == null
          ? SVideoSelector(onTap: onLogoTapToChooseAnotherVideo)
          : SVideoPlayer(
              video: video!,
              onChooseAnotherVideo: onLogoTapToChooseAnotherVideo,
            ),
    );
  }
}
