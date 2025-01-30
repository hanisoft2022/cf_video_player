import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final videoProvider = StateNotifierProvider<VideoNotifier, XFile?>((ref) => VideoNotifier());

class VideoNotifier extends StateNotifier<XFile?> {
  VideoNotifier() : super(null);

  void tapToChooseVid() async {
    final XFile? video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    state = video;
  }
}
