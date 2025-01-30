import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vid_player/common/video_tap_provider.dart';

import 'package:vid_player/video_player/provider/video_player_provider.dart';
import 'package:vid_player/video_player/w_play_buttons.dart';
import 'package:vid_player/video_player/w_choose_another_video.dart';
import 'package:vid_player/video_player/w_progress_bar.dart';
import 'package:video_player/video_player.dart';

class SVideoPlayer extends ConsumerStatefulWidget {
  const SVideoPlayer({super.key});

  @override
  SVideoPlayerState createState() => SVideoPlayerState();
}

class SVideoPlayerState extends ConsumerState<SVideoPlayer> {
  @override
  void initState() {
    super.initState();

    final video = ref.read(videoTapProvider);

    ref.read(videoPlayerProvider.notifier).initializeController(video!.path);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(videoPlayerProvider.notifier);
    final videoState = ref.watch(videoPlayerProvider);

    ref.listen(
      videoTapProvider,
      (previous, next) {
        if (previous!.path != next!.path) {
          notifier.initializeController(next.path);
        }
      },
    );

    // 로딩 상태 처리
    if (videoState.controller == null || videoState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return GestureDetector(
      onTap: notifier.toggleIcons,
      child: Center(
        // 비율 유지 위젯
        child: AspectRatio(
          aspectRatio: videoState.controller!.value.aspectRatio,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 비디오 플레이어
              VideoPlayer(videoState.controller!),
              // 화면 어둡게 하기
              if (videoState.showIcons)
                Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              // 뒤로가기 / 재생&정지 / 앞으로가기
              if (videoState.showIcons) const WPlayButtons(),
              // 재생진행바와 시간 표시
              // 현재 시각 - 슬라이더 - 영상 길이
              if (videoState.showIcons) const WProgressBar(),
              // 다른 영상 선택 아이콘버튼
              if (videoState.showIcons) const WChooseAnotherVideo(),
            ],
          ),
        ),
      ),
    );
  }
}
