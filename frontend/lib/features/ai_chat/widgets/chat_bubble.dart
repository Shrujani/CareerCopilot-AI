import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../models/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MessageSender.user;

    return Align(
      alignment:
          isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: isUser
              ? Colors.blue
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(18),
        ),
        child: isUser
            ? Text(
                message.message,
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            : MarkdownBody(
                data: message.message,
                selectable: true,
              ),
      ),
    );
  }
}