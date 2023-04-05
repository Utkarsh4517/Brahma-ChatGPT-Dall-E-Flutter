import 'dart:async';

import 'package:flutter/material.dart';

import 'package:speech_to_text/speech_to_text.dart';
import 'package:brahma/screens/chat_screen.dart';

class VoiceHandler {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  Future<String> startListening() async {
    final completer = Completer<String>();
    _speechToText.listen(
      onResult: (result) {
        if (result.finalResult) {
          completer.complete(result.recognizedWords);
        }
      },
    );
    return completer.future;
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
  }

  SpeechToText get speechToText => _speechToText;
  bool get isEnabled => _speechEnabled;
  
}
