import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/voice/voice_input_button.dart';

void main() {
  testWidgets('button shows mic icon', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: VoiceInputButton(onPressed: () {}),
      ),
    ));

    expect(find.byIcon(Icons.mic_none), findsOneWidget);
  });
}
