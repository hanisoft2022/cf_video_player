import 'package:flutter/material.dart';

class WLogo extends StatelessWidget {
  final VoidCallback onTap;

  const WLogo({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset('asset/image/logo.png'),
    );
  }
}
