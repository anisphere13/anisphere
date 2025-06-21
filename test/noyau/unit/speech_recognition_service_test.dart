import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/services/speech_recognition_service.dart';

class FakeSpeechToText {
  bool initialized = false;
  bool listening = false;
  Function(dynamic)? onResult;

  Future<bool> initialize({Function? onError}) async {
    initialized = true;
    return true;
  }

  Future<void> listen({required Function(dynamic) onResult}) async {
    listening = true;
    this.onResult = onResult;
  }

  Future<void> stop() async {
    listening = false;
  }
}

void main() {
  test('start and stop listening change state', () async {
    final fake = FakeSpeechToText();
    final service = SpeechRecognitionService(
      speechToText: fake as dynamic,
      googleFallback: fake as dynamic,
    );

    await service.startListening();
    expect(service.isListening, isTrue);

    await service.stopListening();
    expect(service.isListening, isFalse);
  });
}
