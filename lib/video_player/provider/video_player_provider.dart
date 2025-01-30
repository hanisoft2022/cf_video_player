import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerState {
  final VideoPlayerController? controller;
  final bool isPlaying;
  final bool showIcons;
  final double sliderValue;
  // [추가] 새로운 상태들
  final bool isLoading;
  final bool isBuffering;

  const VideoPlayerState({
    this.controller,
    this.isPlaying = false,
    this.showIcons = true,
    this.sliderValue = 0.0,
    this.isLoading = false,
    this.isBuffering = false,
  });

  VideoPlayerState copyWith({
    VideoPlayerController? controller,
    bool? isPlaying,
    bool? showIcons,
    double? sliderValue,
    bool? isLoading,
    bool? isBuffering,
  }) {
    return VideoPlayerState(
      controller: controller ?? this.controller,
      isPlaying: isPlaying ?? this.isPlaying,
      showIcons: showIcons ?? this.showIcons,
      sliderValue: sliderValue ?? this.sliderValue,
      isLoading: isLoading ?? this.isLoading,
      isBuffering: isBuffering ?? this.isBuffering,
    );
  }
}

final videoPlayerProvider = StateNotifierProvider<VideoPlayerNotifier, VideoPlayerState>(
  (ref) => VideoPlayerNotifier(),
);

class VideoPlayerNotifier extends StateNotifier<VideoPlayerState> {
  VideoPlayerNotifier() : super(const VideoPlayerState());

  Future<void> initializeController(String videoPath) async {
    // 기존 컨트롤러가 있다면 해제
    state.controller?.dispose();

    final controller = VideoPlayerController.file(File(videoPath));
    await controller.initialize();

    // 컨트롤러 리스너 설정
    controller.addListener(() {
      state = state.copyWith(
        isPlaying: controller.value.isPlaying,
        sliderValue: controller.value.position.inSeconds.toDouble(),
      );
    });

    // 초기화된 컨트롤러로 상태 업데이트
    state = state.copyWith(controller: controller);
  }

  void toggleIcons() {
    state = state.copyWith(showIcons: !state.showIcons);
  }

  void onRewind() {
    if (state.controller == null) return;

    final currentPosition = state.controller!.value.position;
    final backPosition = currentPosition - const Duration(seconds: 5);
    final clampedPosition = backPosition < Duration.zero ? Duration.zero : backPosition;

    state.controller!.seekTo(clampedPosition);
  }

  void onPlayPause() {
    if (state.controller == null) return;

    if (state.isPlaying) {
      state.controller!.pause();
    } else {
      state.controller!.play();
    }
  }

  void onForward() {
    if (state.controller == null) return;

    final maxDuration = state.controller!.value.duration;
    final currentPosition = state.controller!.value.position;
    final frontPosition = currentPosition + const Duration(seconds: 5);
    final clampedPosition = frontPosition < maxDuration ? frontPosition : maxDuration;

    state.controller!.seekTo(clampedPosition);
  }

  void onSliderChanged(double value) {
    if (state.controller == null) return;

    final goalPosition = Duration(seconds: value.toInt());
    state.controller!.seekTo(goalPosition);
  }

  @override
  void dispose() {
    state.controller?.dispose();
    super.dispose();
  }
}
