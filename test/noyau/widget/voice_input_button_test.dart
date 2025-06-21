import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:anisphere/modules/noyau/widgets/voice_input_button.dart';

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
