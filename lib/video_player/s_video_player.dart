import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vid_player/common/provider/provider.dart';
import 'package:vid_player/video_player/provider/provider.dart';

import 'package:vid_player/video_player/w_play_buttons.dart';
import 'package:vid_player/video_player/w_choose_another_video.dart';
import 'package:vid_player/video_player/w_progress_bar.dart';
import 'package:video_player/video_player.dart';

class SVideoPlayer extends ConsumerStatefulWidget {
  const SVideoPlayer({super.key});

  @override
  FVideoPlayerState createState() => FVideoPlayerState();
}

class FVideoPlayerState extends ConsumerState<SVideoPlayer> {
  @override
  void initState() {
    super.initState();
    final initializeController =
        ref.read(videoPlayerProvider.notifier).initializeController();
    // 비디오플레이어 컨트롤러 초기화 실행
    initializeController;
  }

  @override
  void didUpdateWidget(covariant SVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    ref.read(videoPlayerProvider.notifier).videoPlayerController.dispose();

    ref.read(videoPlayerProvider.notifier).initializeController();
  }

  @override
  Widget build(BuildContext context) {
    final showIcons = ref.watch(videoPlayerProvider);
    final toggleControls =
        ref.read(videoPlayerProvider.notifier).toggleControls;
    final videoPlayerController =
        ref.watch(videoPlayerProvider.notifier).videoPlayerController;

    return GestureDetector(
      onTap: toggleControls,
      child: Center(
        // 비율 유지 위젯
        child: AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 비디오 플레이어
              VideoPlayer(videoPlayerController),
              // 화면 어둡게 하기
              if (showIcons)
                Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              // 뒤로가기 / 재생&정지 / 앞으로가기
              if (showIcons) const WPlayButtons(),
              // 재생진행바와 시간 표시
              // 현재 시각 - 슬라이더 - 영상 길이
              if (showIcons) const WProgressBar(),
              // 다른 영상 선택 아이콘버튼
              if (showIcons) const WChooseAnotherVideo(),
            ],
          ),
        ),
      ),
    );
  }
}
