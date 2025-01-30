import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoPlayerProvider = StateNotifierProvider<VideoPlayerNotifier, void>(
  (ref) => VideoPlayerNotifier(),
);

class VideoPlayerNotifier extends StateNotifier {
  VideoPlayerNotifier() : super(null);

  bool showIcons = true;

  bool toggleIcons() {
    showIcons = !showIcons;
    return showIcons;
  }
}
