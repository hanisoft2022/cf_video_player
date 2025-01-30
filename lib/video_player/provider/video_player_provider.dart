import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerState {
  final VideoPlayerController? controller;
  final bool isPlaying;
  final bool showIcons;
  final double sliderValue;

  const VideoPlayerState({
    this.controller,
    this.isPlaying = false,
    this.showIcons = true,
    this.sliderValue = 0.0,
  });

  VideoPlayerState copyWith({
    VideoPlayerController? controller,
    bool? isPlaying,
    bool? showIcons,
    double? sliderValue,
  }) {
    return VideoPlayerState(
      controller: controller ?? this.controller,
      isPlaying: isPlaying ?? this.isPlaying,
      showIcons: showIcons ?? this.showIcons,
      sliderValue: sliderValue ?? this.sliderValue,
    );
  }
}

final videoPlayerProvider = StateNotifierProvider<VideoPlayerNotifier, VideoPlayerState>(
  (ref) => VideoPlayerNotifier(),
);

class VideoPlayerNotifier extends StateNotifier<VideoPlayerState> {
  VideoPlayerNotifier() : super(const VideoPlayerState());

  void toggleIcons() {
    state = state.copyWith(showIcons: !state.showIcons);
  }

  // 나머지 메서드들은 현재 위젯에서 사용하는 것들을 그대로 옮기면 됩니다
}
