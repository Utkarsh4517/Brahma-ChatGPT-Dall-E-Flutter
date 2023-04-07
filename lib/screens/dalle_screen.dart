import 'package:animate_do/animate_do.dart';
import 'package:brahma/screens/chat_screen.dart';
import 'package:brahma/widgets/dalle_text_and_voice_field.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        title: FadeIn(
          duration: const Duration(milliseconds: 3000),
          child: const Text(
            'B R A H M A',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.menu_book)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              DalleTextAndVoiceField(),
            ],
          ),
        ),
      ),
    );
  }
}
