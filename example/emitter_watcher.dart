import 'package:creator/creator.dart';
import 'package:creator_watcher/creator_watcher.dart';
import 'package:flutter/material.dart';

final exampleEmitter = Emitter<String>(
  (ref, emit) async {
    await Future.delayed(const Duration(seconds: 1));
    emit('Hello emitter');
  },
  name: 'exampleEmitter',
);

void main() {
  runApp(MaterialApp(
    home: EmitterWatcher<String>(
      builder: (context, content) => Text(content),
      emitter: exampleEmitter,
    ),
  ));
}
