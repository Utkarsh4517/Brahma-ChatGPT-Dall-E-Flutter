import 'package:brahma/provider/chats_provider.dart';
import 'package:brahma/widgets/chat_item.dart';
import 'package:brahma/widgets/text_and_voice_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'B R A H M A',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 250, 223, 220),
                borderRadius:
                    BorderRadius.circular(20), // Update the border radius here
              ),
              child: Consumer(builder: (context, ref, child) {
                final chats = ref.watch(chatsProvider);
                return ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) => ChatItem(
                    text: chats[index].message,
                    isMe: chats[index].isMe,
                  ),
                );
              }),
            ),
            const SizedBox(
              height: 80,
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: TextAndVoiceField(),
            ),
          ],
        ),
      ),
    );
  }
}
