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
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": message})
      ], maxToken: 200, model: kChatGptTurbo0301Model);

      final response = await _openAI.onChatCompletion(request: request);
      if (response != null) {
        return response.choices[0].message.content.trim();
      }

      return 'Some thing went wrong';
    } catch (e) {
      return e.toString();
    }
  }
  void dispose(){
    // ignore: deprecated_member_use
    _openAI.close();
  }
}
