import 'package:brahma/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            );
          },
          child: const Text('Chat'),
        ),
      ),
    );
  }
}
