import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class AIHandler {
  final _openAI = OpenAI.instance.build(
    token: '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',
    baseOption: HttpSetup(
      receiveTimeout: const Duration(milliseconds: 20000),
    ),
  );

  Future<String> getResponse(String message) async {
    try {
      final request = CompleteText(prompt: message, model: kChatGptTurbo0301Model);
      final response = await _openAI.onCompletion(request: request);
      if(response != null){
        return response.choices[0].text.trim();
      }
      return 'Something went wrong';
    } catch (e) {
      return 'Bad Response';
    }
  }
  void dispose(){
    // ignore: deprecated_member_use
    _openAI.close();
  }
}
