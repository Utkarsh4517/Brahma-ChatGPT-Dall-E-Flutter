import 'package:animate_do/animate_do.dart';
import 'package:brahma/provider/chats_provider.dart';
import 'package:brahma/widgets/chat_item.dart';
import 'package:brahma/widgets/text_and_voice_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextAndVoiceField textAndVoiceField = const TextAndVoiceField();
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: FadeIn(
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
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            FadeInDown(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black, // Update the border radius here
                ),
                child: Consumer(builder: (context, ref, child) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                  // This code will run after the ChatItem has been built
                  jumpToBottom();
                });
                  final chats = ref.watch(chatsProvider);
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: chats.length,
                    itemBuilder: (context, index) => ChatItem(
                      text: chats[index].message,
                      isMe: chats[index].isMe,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextAndVoiceField(),
            ),
          ],
        ),
      ),
    );
  }
  void jumpToBottom(){
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }
}
