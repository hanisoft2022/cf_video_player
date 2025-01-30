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
  @override
  void initState() {
    super.initState();

    ref.read(videoPlayerProvider.notifier).initializeController(widget.video.path);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.video.path != widget.video.path) {
      ref.read(videoPlayerProvider.notifier).initializeController(widget.video.path);
    }
  }

  // [추가] 비디오 초기화 메서드 분리
  Future<void> _initializeVideo() async {
    try {
      await ref.read(videoPlayerProvider.notifier).initializeController(widget.video.path);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('비디오 초기화 실패: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tapNotifier = ref.watch(videoTapProvider.notifier);
    final notifier = ref.watch(videoPlayerProvider.notifier);
    final videoState = ref.watch(videoPlayerProvider);

    // [추가] 에러 상태 처리
    if (videoState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('오류가 발생했습니다: ${videoState.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _initializeVideo,
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }
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
              // [추가] 버퍼링 인디케이터
              if (videoState.isBuffering)
                const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              // 화면 어둡게 하기
              if (videoState.showIcons)
                Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              // 뒤로가기 / 재생&정지 / 앞으로가기
              if (videoState.showIcons)
                WPlayButtons(
                  onRewind: notifier.onRewind,
                  onPlayPause: notifier.onPlayPause,
                  onForward: notifier.onForward,
                  isPlaying: videoState.isPlaying,
                ),
              // 재생진행바와 시간 표시
              // 현재 시각 - 슬라이더 - 영상 길이
              if (videoState.showIcons) WProgressBar(controller: videoState.controller!, onSliderChanged: notifier.onSliderChanged),
              // 다른 영상 선택 아이콘버튼
              if (videoState.showIcons) WChooseAnotherVideo(onPressed: tapNotifier.onTap),
            ],
          ),
        ),
      ),
    );
  }
}
