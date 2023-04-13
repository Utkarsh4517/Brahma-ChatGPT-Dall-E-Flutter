import 'package:animate_do/animate_do.dart';
import 'package:brahma/constants/api_key.dart';
import 'package:brahma/provider/chats_provider.dart';
import 'package:brahma/services/api_read_from_database.dart';
import 'package:brahma/widgets/body_text.dart';
import 'package:brahma/widgets/chat_item.dart';
import 'package:brahma/widgets/text_and_voice_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String? apiKEY;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextAndVoiceField textAndVoiceField = const TextAndVoiceField();
  final _scrollController = ScrollController();
  final user = FirebaseAuth.instance.currentUser!;
 // static String? fetchedApiKey;
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: FadeIn(
          duration: const Duration(milliseconds: 1500),
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
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
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
            const SizedBox(
              height: 0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextAndVoiceField(),
            ),
            const BodyText(bodyText: 'Swipe right to Generate Image'),
            
          ],
        ),
      ),
    );
  }

  void jumpToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

}
