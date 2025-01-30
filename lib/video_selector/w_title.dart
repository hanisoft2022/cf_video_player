import 'package:flutter/material.dart';

const textStyle = TextStyle(
  color: Colors.white,
  fontSize: 40,
);

class WTitle extends StatelessWidget {
  const WTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('VIDEO', style: textStyle.copyWith(fontWeight: FontWeight.w300)),
        Text('PLAYER', style: textStyle.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
