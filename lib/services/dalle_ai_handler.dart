import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

class DalleAIService {
  final List<Map<String, String>> messages = [];

  Future<List<String>> dallEAPI(String prompt) async {
    // Retrieve API key from Firebase
    final apikeyRef = FirebaseDatabase.instance.ref().child('api');
    final  event = await apikeyRef.once();
    final String apiKey = event.snapshot.value as String;

    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
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
