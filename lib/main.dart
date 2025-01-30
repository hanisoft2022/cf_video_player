import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vid_player/s_home.dart';

void main() {
  runApp(
    const ProviderScope(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SHome(),
    )),
  );
}

// for practice
