import 'package:avatar_glow/avatar_glow.dart';
import 'package:brahma/widgets/dalle_text_and_voice_field.dart';
import 'package:flutter/material.dart';

class DalleToggleButton extends StatefulWidget {
  final VoidCallback _sendTextMessage;
  final VoidCallback _sendVoiceMessage;
  final DalleInputMode _dalleInputMode;
  final bool _isReplying;
  final bool _isListening;
  const DalleToggleButton({
    super.key,
    required DalleInputMode dalleInputMode,
    required VoidCallback sendTextMessage,
    required VoidCallback sendVoiceMessage,
    required bool isReplying,
    required bool isListening,
  })  : _dalleInputMode = dalleInputMode,
        _sendTextMessage = sendTextMessage,
        _sendVoiceMessage = sendVoiceMessage,
        _isReplying = isReplying,
        _isListening = isListening;

  @override
  State<DalleToggleButton> createState() => _DalleToggleButtonState();
}

class _DalleToggleButtonState extends State<DalleToggleButton> {
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
          : widget._dalleInputMode == DalleInputMode.text
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
        child: Icon(widget._dalleInputMode == DalleInputMode.text
            ? Icons.send
            : widget._isListening
                ? Icons.mic_off
                : Icons.mic),
      ),
    );
  }
}
