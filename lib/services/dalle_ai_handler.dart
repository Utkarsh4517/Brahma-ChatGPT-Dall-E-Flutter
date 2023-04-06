import 'dart:convert';
import 'package:brahma/constants/api_key.dart';
import 'package:http/http.dart' as http;

class DalleAIService {
  final List<Map<String, String>> messages = [];

  Future<List<String>> dallEAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          'prompt': prompt,
          'n': 3,
        }),
      );

      if (res.statusCode == 200) {
        List<String> imageUrls = [];
        for (var i = 0; i < 3; i++) {
          String imageUrl = jsonDecode(res.body)['data'][i]['url'];
          imageUrl = imageUrl.trim();
          imageUrls.add(imageUrl);
          messages.add({
            'role': 'assistant',
            'content': imageUrl,
          });
        }
        return imageUrls;
      }
      return ['An internal error occurred'];
    } catch (e) {
      return [e.toString()];
    }
  }
}
