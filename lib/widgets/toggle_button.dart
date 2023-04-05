import 'package:avatar_glow/avatar_glow.dart';
import 'package:brahma/widgets/text_and_voice_field.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final VoidCallback _sendTextMessage;
  final VoidCallback _sendVoiceMessage;
  final InputMode _inputMode;
  final bool _isReplying;
  final bool _isListening;
  const ToggleButton({
    super.key,
    required InputMode inputMode,
    required VoidCallback sendTextMessage,
    required VoidCallback sendVoiceMessage,
    required bool isReplying,
    required bool isListening,
  })  : _inputMode = inputMode,
        _sendTextMessage = sendTextMessage,
        _sendVoiceMessage = sendVoiceMessage,
        _isReplying = isReplying,
        _isListening = isListening;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 2.5),
        //padding: const EdgeInsets.symmetric(vertical:20, horizontal: 25),
      ),
      onPressed: widget._isReplying
          ? null
          : widget._inputMode == InputMode.text
              ? widget._sendTextMessage
              : widget._sendVoiceMessage,
      child: AvatarGlow(
        endRadius: 20,
        animate: widget._isListening,
        duration: const Duration(milliseconds: 2000),
        glowColor: Colors.pink,
        repeat: true, //
        repeatPauseDuration: const Duration(milliseconds: 100), //
        showTwoGlows: true,
        child: Icon(widget._inputMode == InputMode.text
            ? Icons.send
            : widget._isListening
                ? Icons.mic_off
                : Icons.mic),
      ),
    );
  }
}
