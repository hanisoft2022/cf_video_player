import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final videoTapProvider = StateNotifierProvider<VideoTapNotifier, XFile?>(
  (ref) => VideoTapNotifier(),
);

class VideoTapNotifier extends StateNotifier<XFile?> {
  VideoTapNotifier() : super(null);

  Future<void> onLogoTapToChooseAnotherVideo() async {
    final XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    state = video;
  }
}
