import 'package:brahma/widgets/text_and_voice_field.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatefulWidget {
  final String text;
  final bool isMe;
  const ChatItem({
    super.key,
    required this.text,
    required this.isMe,
  });

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  TextAndVoiceField textAndVoiceField = const TextAndVoiceField();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),
      child: Row(
        mainAxisAlignment:
            widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!widget.isMe) ProfileContainer(isMe: widget.isMe),
          if (!widget.isMe)
            const SizedBox(
              width: 15,
            ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.60),
            decoration: BoxDecoration(
              color: widget.isMe ? Colors.green : Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: Radius.circular(widget.isMe ? 15 : 0),
                bottomRight: Radius.circular(widget.isMe ? 0 : 15),
              ),
            ),
            child: Text(
              widget.text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          if (widget.isMe)
            const SizedBox(
              width: 15,
            ),
          if (widget.isMe) ProfileContainer(isMe: widget.isMe),
        ],
      ),
    );
  }
}

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    super.key,
    required this.isMe,
  });

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color:
            isMe ? const Color.fromARGB(255, 56, 180, 60) : Colors.blueAccent,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10),
          bottomLeft: Radius.circular(isMe ? 0 : 15),
          bottomRight: Radius.circular(isMe ? 15 : 0),
        ),
      ),
      child: Icon(
        isMe ? Icons.person : Icons.computer,
        color: Colors.white,
      ),
    );
  }
}
