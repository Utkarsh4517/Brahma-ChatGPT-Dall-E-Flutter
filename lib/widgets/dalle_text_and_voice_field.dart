import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:brahma/screens/chat_screen.dart';
import 'package:brahma/services/dalle_ai_handler.dart';
import 'package:brahma/widgets/body_text.dart';
import 'package:flutter/material.dart';
import 'package:brahma/widgets/dalle_toggle_button.dart';
import 'package:brahma/services/voice_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
      // ADS
  late BannerAd bannerAd;
  var adUnitId = 'ca-app-pub-3940256099942544/6300978111'; // testing ad id
  bool isAdLoaded = false;
    //
  DalleInputMode _dalleInputMode = DalleInputMode.voice;
  final _dalleMessageController = TextEditingController();
  var _dalleIsReplying = false;
  var _dalleIsListening = false;
  final String swipeText = "Swipe right to see more images";
  // create dalleAi handler instance here

  final VoiceHandler voiceHandler = VoiceHandler();
  final DalleAIService dalleAIService = DalleAIService();
  var speechResult = "tap the mic to say";
  List<String>? generatedImageUrl;

  Future<void> _downloadImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    final directory = await getApplicationDocumentsDirectory();
    final file =
        File('${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await file.writeAsBytes(bytes);
  }

  @override
  void initState() {
    voiceHandler.initSpeech();
    initBannerAd();
    super.initState();
  }

    initBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print(error);
        },
      ),
      request: const AdRequest(),
    );
    bannerAd.load();
  }

  @override
  void dispose() {
    _dalleMessageController.dispose();
    // dispose dalleAi handler instance here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20).copyWith(top: 5),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black, // Update the border radius here
            ),
            child: Visibility(
              visible: generatedImageUrl != null,
              child: generatedImageUrl != null
                  ? Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          swipeText,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 420,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.86,
                                margin: const EdgeInsets.only(left: 10),
                                padding:
                                    const EdgeInsets.all(10).copyWith(top: 0),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.all(10).copyWith(top: 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          generatedImageUrl![index],
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    const AlwaysStoppedAnimation<
                                                        Color>(Colors.red),
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return const Text(
                                                'Failed to load image');
                                          },
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: ElevatedButton(
                                            onPressed: () => _downloadImage(
                                                generatedImageUrl![index]),
                                            child: const Icon(Icons.download),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : const Text(
                      'Generating new images',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
          const SizedBox(
            height: 12,
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
                    fillColor: Colors.grey[200],
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'ask to generate image!',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(90, 0, 0, 0),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
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
                  speechResult = message;
                  _dalleMessageController.clear();
                  sendDalleTextMessage(message);
                  generatedImageUrl = null;
                },
                sendVoiceMessage: sendDalleVoiceMessage,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          BodyText(bodyText: speechResult),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
          isAdLoaded
                ? SizedBox(
                    height: bannerAd.size.height.toDouble(),
                    width: bannerAd.size.width.toDouble(),
                    child: AdWidget(ad: bannerAd),
                  )
                : const SizedBox(),
        ],
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
    print('\n');
    print('printing generatedImageUrl');
    print('\n');
    print(generatedImageUrl?[0]);

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
