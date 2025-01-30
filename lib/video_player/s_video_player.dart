import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/common/video_tap_provider.dart';
import 'package:vid_player/video_player/provider/video_player_provider.dart';
import 'package:vid_player/video_player/w_play_buttons.dart';
import 'package:vid_player/video_player/w_choose_another_video.dart';
import 'package:vid_player/video_player/w_progress_bar.dart';
import 'package:video_player/video_player.dart';

class SVideoPlayer extends ConsumerStatefulWidget {
  final XFile video;

  const SVideoPlayer({
    super.key,
    required this.video,
  });

  @override
  FVideoPlayerState createState() => FVideoPlayerState();
}

class FVideoPlayerState extends ConsumerState<SVideoPlayer> {
  // 비디오 플레이어 컨트롤러
  late VideoPlayerController videoPlayerController;
  // 비디오 상태 변수
  bool isPlaying = false;
  // 슬라이더 위치값 변수
  double sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
    // 비디오플레이어 컨트롤러 초기화 실행
    initializeController();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.video.path != widget.video.path) {
      videoPlayerController.dispose();

      initializeController();
    }
  }

  // 비디오플레이어 컨트롤러 초기화 메서드
  Future<void> initializeController() async {
    videoPlayerController = VideoPlayerController.file(File(widget.video.path));
    await videoPlayerController.initialize();
    videoPlayerController.addListener(
      () => setState(
        () {
          isPlaying = videoPlayerController.value.isPlaying;
          sliderValue = videoPlayerController.value.position.inSeconds.toDouble();
        },
      ),
    );
  }

  // 뒤로가기 메서드

  void onRewind() {
    final currentPosition = videoPlayerController.value.position;
    final backPosition = currentPosition - const Duration(seconds: 5);
    final clampedPosition = backPosition < Duration.zero ? Duration.zero : backPosition;

    videoPlayerController.seekTo(clampedPosition);
  }

  // 재생&정지 메서드
  void onPlayPause() => setState(
        () {
          if (isPlaying) {
            videoPlayerController.pause();
          } else {
            videoPlayerController.play();
          }
        },
      );

  // 앞으로가기 메서드
  void onForward() {
    final maxDuration = videoPlayerController.value.duration;
    final currentPosition = videoPlayerController.value.position;
    final frontPosition = currentPosition + const Duration(seconds: 5);
    final clampedPosition = frontPosition < maxDuration ? frontPosition : maxDuration;

    videoPlayerController.seekTo(clampedPosition);
  }

  // 슬라이더 상태 변경 메서드
  onSliderChanged(double value) {
    // 비디오 위치를 백그라운드에서 동기화
    final goalPosition = Duration(seconds: value.toInt());
    videoPlayerController.seekTo(goalPosition);
  }

  @override
  Widget build(BuildContext context) {
    final tapNotifier = ref.watch(videoTapProvider.notifier);
    final notifier = ref.watch(videoPlayerProvider.notifier);
    final showIcons = ref.watch(videoPlayerProvider.notifier).showIcons;

    return GestureDetector(
      onTap: notifier.toggleIcons,
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
              if (showIcons)
                WPlayButtons(
                  onRewind: onRewind,
                  onPlayPause: onPlayPause,
                  onForward: onForward,
                  isPlaying: isPlaying,
                ),
              // 재생진행바와 시간 표시
              // 현재 시각 - 슬라이더 - 영상 길이
              if (showIcons) WProgressBar(controller: videoPlayerController, onSliderChanged: onSliderChanged),
              // 다른 영상 선택 아이콘버튼
              if (showIcons) WChooseAnotherVideo(onPressed: tapNotifier.onTap),
            ],
          ),
        ),
      ),
    );
  }
}
