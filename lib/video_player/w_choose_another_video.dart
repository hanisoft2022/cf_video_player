import 'package:flutter/material.dart';

class WChooseAnotherVideo extends StatelessWidget {
  final VoidCallback onPressed;

  const WChooseAnotherVideo({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.photo_camera_back),
        color: Colors.white,
      ),
    );
  }
}
