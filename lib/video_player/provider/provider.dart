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

  VideoPlayerController? videoPlayerController;

  bool isPlaying = false;

  double sliderValue = 0.0;

  Future<void> initializeController() async {
    try {
      // 현재 컨트롤러가 있다면 정리
      if (videoPlayerController != null) {
        await videoPlayerController!.dispose();
        videoPlayerController = null;
      }

      final video = ref.watch(videoProvider);

      if (video == null) return;
      // 새 컨트롤러 초기화
      videoPlayerController = VideoPlayerController.file(File(video.path));
      await videoPlayerController!.initialize();

      // 리스너 설정
      videoPlayerController!.addListener(() {
        isPlaying = videoPlayerController!.value.isPlaying;
        sliderValue = videoPlayerController!.value.position.inSeconds.toDouble();
      });

      // 초기화 후 자동으로 재생 시작 (선택사항)
      // await videoPlayerController.play();
      // isPlaying = true;
      state = !state;
    } catch (e) {
      print('Error initializing video controller: $e');
    }
  }

  toggleControls() => state = !state;

  // 뒤로가기 메서드
  void onRewind() {
    final currentPosition = videoPlayerController!.value.position;
    final backPosition = currentPosition - const Duration(seconds: 5);
    final clampedPosition = backPosition < Duration.zero ? Duration.zero : backPosition;

    videoPlayerController!.seekTo(clampedPosition);
  }

  void onPlayPause() {
    if (videoPlayerController!.value.isPlaying) {
      videoPlayerController!.pause();
      isPlaying = false;
    } else {
      videoPlayerController!.play();
      isPlaying = true;
    }
    state = !state;
  }

  // 앞으로가기 메서드
  void onForward() {
    final maxDuration = videoPlayerController!.value.duration;
    final currentPosition = videoPlayerController!.value.position;
    final frontPosition = currentPosition + const Duration(seconds: 5);
    final clampedPosition = frontPosition < maxDuration ? frontPosition : maxDuration;

    videoPlayerController!.seekTo(clampedPosition);
  }

  // 슬라이더 상태 변경 메서드
  onSliderChanged(double value) {
    // 비디오 위치를 백그라운드에서 동기화
    final goalPosition = Duration(seconds: value.toInt());
    videoPlayerController!.seekTo(goalPosition);
  }
}
