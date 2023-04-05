import 'package:animate_do/animate_do.dart';
import 'package:brahma/models/chat_model.dart';
import 'package:brahma/provider/chats_provider.dart';
import 'package:brahma/screens/chat_screen.dart';
import 'package:brahma/screens/dalle_screen.dart';
import 'package:brahma/services/ai_handler.dart';
import 'package:brahma/services/voice_handler.dart';
import 'package:brahma/widgets/toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';

enum InputMode {
  text,
  voice,
}

class TextAndVoiceField extends ConsumerStatefulWidget {
  const TextAndVoiceField({super.key});

  @override
  ConsumerState<TextAndVoiceField> createState() => _TextAndVoiceFieldState();
}

class _TextAndVoiceFieldState extends ConsumerState<TextAndVoiceField> {
  InputMode _inputMode = InputMode.voice;
  final _messageController = TextEditingController();
  var _isReplying = false;
  var textToCopy = "";
  static var _isListening = false;
  bool get listening => _isListening;
  final AIHandler _openAI = AIHandler();
  FlutterTts flutterTts = FlutterTts();
  final VoiceHandler voiceHandler = VoiceHandler();

  @override
  void initState() {
    voiceHandler.initSpeech();
    initTts();
    super.initState();
  }

  initTts() {
    flutterTts = FlutterTts();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _openAI.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    copyToClipboard(textToCopy);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Icon(Icons.copy_sharp),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    startSpeaking();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Icon(Icons.play_circle),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    stopSpeaking();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Icon(Icons.stop_circle),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ImageScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Try Image Generation!',
                        style: TextStyle(fontSize: 11),
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.only(right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      onChanged: (value) {
                        value.isNotEmpty
                            ? setInputMode(InputMode.text)
                            : setInputMode(InputMode.voice);
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'ask me anything!',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(90, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ToggleButton(
                    isReplying: _isReplying,
                    isListening: _isListening,
                    inputMode: _inputMode,
                    sendTextMessage: () {
                      final message = _messageController.text;
                      _messageController.clear();
                      sendTextMessage(message);
                    },
                    sendVoiceMessage: sendVoiceMessage,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setInputMode(InputMode inputMode) {
    setState(() {
      _inputMode = inputMode;
    });
  }

  void sendVoiceMessage() async {
    if (voiceHandler.speechToText.isListening) {
      await voiceHandler.stopListening();
      setListeningstate(false);
    } else {
      setListeningstate(true);
      final result = await voiceHandler.startListening();
      setListeningstate(false);
      sendTextMessage(result);
    }
  }

  void sendTextMessage(String message) async {
    setReplyingstate(true);
    addToChatList(message, true, DateTime.now().toString());
    addToChatList('Generating response...', false, 'typing');
    setInputMode(InputMode.voice);
    // text to speech aiResponse using await flutterTts.speak();
    final aiResponse = await _openAI.getResponse(message);
    textToCopy = aiResponse;
    removeTyping();
    await flutterTts.speak(aiResponse);
    addToChatList(aiResponse, false, DateTime.now().toString());

    setReplyingstate(false);
  }

  void setReplyingstate(bool isReplying) {
    setState(() {
      _isReplying = isReplying;
    });
  }

  void setListeningstate(bool isListening) {
    setState(() {
      _isListening = isListening;
    });
  }

  void removeTyping() {
    final chats = ref.read(chatsProvider.notifier);
    chats.removeTyping();
  }

  void addToChatList(String message, bool isMe, String id) {
    final chats = ref.read(chatsProvider.notifier);
    chats.add(
      ChatModel(id: id, message: message, isMe: isMe),
    );
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  void startSpeaking() async {
    await flutterTts.speak(textToCopy);
  }

  void stopSpeaking() async {
    await flutterTts.stop();
  }
}
