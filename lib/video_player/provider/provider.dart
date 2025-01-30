import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vid_player/common/provider/provider.dart';
import 'package:video_player/video_player.dart';

final videoPlayerProvider = StateNotifierProvider<VideoPlayerNotifier, bool>(
  (ref) {
    return VideoPlayerNotifier(ref);
  },
);

class VideoPlayerNotifier extends StateNotifier<bool> {
  Ref ref;

  VideoPlayerNotifier(this.ref) : super(true);
// 비디오 플레이어 컨트롤러
  late VideoPlayerController videoPlayerController;
  // 비디오 상태 변수
  bool isPlaying = false;
  // 슬라이더 위치값 변수
  double sliderValue = 0.0;
  // 아이콘, 슬라이더, 비디오 선택 버튼 등이 보이는지 여부
  // 초기에는 안 보이게

  // 비디오플레이어 컨트롤러 초기화 메서드
  Future<void> initializeController() async {
    final video = ref.watch(videoProvider);
    videoPlayerController = VideoPlayerController.file(File(video!.path));
    await videoPlayerController.initialize();
    videoPlayerController.addListener(
      () {
        () {
          isPlaying = videoPlayerController.value.isPlaying;
          sliderValue =
              videoPlayerController.value.position.inSeconds.toDouble();
        };
      },
    );
  }

  // 뒤로가기 메서드

  void onRewind() {
    final currentPosition = videoPlayerController.value.position;
    final backPosition = currentPosition - const Duration(seconds: 5);
    final clampedPosition =
        backPosition < Duration.zero ? Duration.zero : backPosition;

    videoPlayerController.seekTo(clampedPosition);
  }

  // 재생&정지 메서드
  void onPlayPause() {
    () {
      if (isPlaying) {
        videoPlayerController.pause();
      } else {
        videoPlayerController.play();
      }
    };
  }

  // 앞으로가기 메서드
  void onForward() {
    final maxDuration = videoPlayerController.value.duration;
    final currentPosition = videoPlayerController.value.position;
    final frontPosition = currentPosition + const Duration(seconds: 5);
    final clampedPosition =
        frontPosition < maxDuration ? frontPosition : maxDuration;

    videoPlayerController.seekTo(clampedPosition);
  }

  // 슬라이더 상태 변경 메서드
  onSliderChanged(double value) {
    // 비디오 위치를 백그라운드에서 동기화
    final goalPosition = Duration(seconds: value.toInt());
    videoPlayerController.seekTo(goalPosition);
  }

  toggleControls() => state = !state;
}
