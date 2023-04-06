import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:brahma/screens/chat_screen.dart';
import 'package:brahma/services/dalle_ai_handler.dart';
import 'package:flutter/material.dart';
import 'package:brahma/widgets/dalle_toggle_button.dart';
import 'package:brahma/services/voice_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';



enum DalleInputMode {
  text,
  voice,
}

class DalleTextAndVoiceField extends ConsumerStatefulWidget {
  const DalleTextAndVoiceField({super.key});



  @override
  ConsumerState<DalleTextAndVoiceField> createState() =>
      _DalleTextAndVoiceFieldState();
}

class _DalleTextAndVoiceFieldState
    extends ConsumerState<DalleTextAndVoiceField> {
  DalleInputMode _dalleInputMode = DalleInputMode.voice;
  final _dalleMessageController = TextEditingController();
  var _dalleIsReplying = false;
  var _dalleIsListening = false;
  // create dalleAi handler instance here

  final VoiceHandler voiceHandler = VoiceHandler();
  final DalleAIService dalleAIService = DalleAIService();
  var speechResult = "tap the mic to say";
  List<String>? generatedImageUrl;

   Future<void> _downloadImage(String imageUrl) async {
  final response = await http.get(Uri.parse(imageUrl));
  final bytes = response.bodyBytes;
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
  await file.writeAsBytes(bytes);
}

  @override
  void initState() {
    voiceHandler.initSpeech();
    super.initState();
  }

  @override
  void dispose() {
    _dalleMessageController.dispose();
    // dispose dalleAi handler instance here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            FadeInDown(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black, // Update the border radius here
                ),
                child: Visibility(
                  visible: generatedImageUrl != null,
                  child: generatedImageUrl != null
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.86,
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(generatedImageUrl![index]),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton(
                                          onPressed: () => _downloadImage(generatedImageUrl![index]),
                                          child: const Icon(Icons.download),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const SizedBox(
                          height: 100,
                          width: 100,
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dalleMessageController,
                    onChanged: (value) {
                      value.isNotEmpty
                          ? setDalleInputMode(DalleInputMode.text)
                          : setDalleInputMode(DalleInputMode.voice);
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'ask to generate image!',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 112, 41, 65),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    minimumSize: null,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Try AI Chat!'),
                ),
                const SizedBox(
                  width: 10,
                ),
                DalleToggleButton(
                  isReplying: _dalleIsReplying,
                  isListening: _dalleIsListening,
                  dalleInputMode: _dalleInputMode,
                  sendTextMessage: () {
                    final message = _dalleMessageController.text;
                    _dalleMessageController.clear();
                    sendDalleTextMessage(message);
                  },
                  sendVoiceMessage: sendDalleVoiceMessage,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              speechResult,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  void setDalleInputMode(DalleInputMode dalleInputMode) {
    setState(() {
      _dalleInputMode = dalleInputMode;
    });
  }

  void sendDalleVoiceMessage() async {
    if (voiceHandler.speechToText.isListening) {
      await voiceHandler.stopListening();
      setListeningstate(false);
    } else {
      setListeningstate(true);
      final dalleResult = await voiceHandler.startListening();
      speechResult = dalleResult;
      returnDalleResult();
      setListeningstate(false);
      sendDalleTextMessage(dalleResult);
    }
  }

  void returnDalleResult() {
    print(speechResult);
  }

  void sendDalleTextMessage(String message) async {
    setReplyingstate(true);
    setDalleInputMode(DalleInputMode.voice);
    // text to speech aiResponse using await flutterTts.speak();
    final List<String> generatedImageUrls =
        await dalleAIService.dallEAPI(message);
    generatedImageUrl = generatedImageUrls;
    print(generatedImageUrls[0]);
    print('\n');
    print(generatedImageUrls[1]);
    print('\n');
    print(generatedImageUrls[2]);
    print('\n');

    setReplyingstate(false);
  }

  void setReplyingstate(bool dalleIsReplying) {
    setState(
      () {
        _dalleIsReplying = dalleIsReplying;
      },
    );
  }

  void setListeningstate(bool dalleIsListening) {
    setState(() {
      _dalleIsListening = dalleIsListening;
    });
  }
}
