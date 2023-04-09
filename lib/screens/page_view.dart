import 'package:brahma/screens/chat_screen.dart';
import 'package:brahma/screens/dalle_screen.dart';
import 'package:flutter/material.dart';

class PageViewHome extends StatelessWidget {
  const PageViewHome({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      children: const [
        ChatScreen(),
        ImageScreen()
      ],
    );
  }
}