import 'package:creator/creator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:creator_watcher/creator_watcher.dart';

void main() {
  testWidgets('CreatorWatcher', (WidgetTester tester) async {
    final exampleCreator = Creator.value(
      'This is an example creator',
      name: 'exampleCreator',
    );

    await tester.pumpWidget(CreatorGraph(
      child: MaterialApp(
        home: CreatorWatcher<String>(
          builder: (context, content) => Text(content),
          creator: exampleCreator,
        ),
      ),
    ));

    expect(find.text('This is an example creator'), findsOneWidget);
  });

  testWidgets('EmitterWatcher', (WidgetTester tester) async {
    final exampleEmitter = Emitter<String>(
      (ref, emit) async {
        await Future.delayed(const Duration(milliseconds: 500));
        emit('This is an example emitter');
      },
      name: 'exampleEmitter',
    );

    await tester.pumpWidget(CreatorGraph(
      child: MaterialApp(
        home: Scaffold(
          body: EmitterWatcher<String>(
            builder: (context, content) => Text(content),
            emitter: exampleEmitter,
          ),
        ),
      ),
    ));

    expect(find.text('This is an example emitter'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('This is an example emitter'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
