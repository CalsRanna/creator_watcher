# Creator Watcher

A widget wrap creator's watcher which is simple to use especially for emitter.

## Install

```bash
flutter pub add creator_watcher
```

## Getting started

This widget can be used to wrap creator's watch widget, make it easy to use and provides some default widget to display extra status of emitter.

### Creator Watcher

```dart
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

```

### Emitter Watcher

```dart
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

```