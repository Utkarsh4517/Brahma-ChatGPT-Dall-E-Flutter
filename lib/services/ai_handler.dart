import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:firebase_database/firebase_database.dart';

class AIHandler {
  final DatabaseReference apikeyRef = FirebaseDatabase.instance.ref().child('api');

  Future<OpenAI> _getOpenAI() async {
    final event = await apikeyRef.once();
    final String apiKey = event.snapshot.value as String;

    final openAI = OpenAI.instance.build(
      token: apiKey,
      baseOption: HttpSetup(
        receiveTimeout: const Duration(milliseconds: 60000),
      ),
    );
    return openAI;
  }

  Future<String> getResponse(String message) async {
    try {
      final openAI = await _getOpenAI();
      final request = ChatCompleteText(
          messages: [Map.of({"role": "user", "content": message})],
          maxToken: 200,
          model: kChatGptTurbo0301Model);

      final response = await openAI.onChatCompletion(request: request);
      if (response != null) {
        String generatedResponse = response.choices[0].message.content.trim();
        // ignore: avoid_print
        print("Generated response : $generatedResponse ");
        return generatedResponse;
      }

      return 'Something went wrong';
    } catch (e) {
      return e.toString();
    }
  }

 /* void dispose() {
    // ignore: deprecated_member_use
    _openAI.close();
  }
  */
}
