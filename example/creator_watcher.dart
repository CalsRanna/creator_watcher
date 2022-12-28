import 'package:creator/creator.dart';
import 'package:creator_watcher/creator_watcher.dart';
import 'package:flutter/material.dart';

final exampleCreator = Creator<String>.value(
  'Hello creator',
  name: 'exampleCreator',
);

void main() {
  runApp(MaterialApp(
    home: CreatorWatcher<String>(
      builder: (context, content) => Text(content),
      creator: exampleCreator,
    ),
  ));
}
