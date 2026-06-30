import 'package:flutter/material.dart';

import 'models/chat_message.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/message_input.dart';
import 'widgets/suggestion_chip.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<ChatMessage> _messages = [
     ChatMessage(
      message: "Hi 👋 I'm CareerPilot AI. How can I help you today?",
      sender: MessageSender.ai,
      timestamp: DateTime.now(),
    ),
  ];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          message: text,
          sender: MessageSender.user,
          timestamp: DateTime.now(),
        ),
      );

      // Fake AI response
      _messages.add(
        ChatMessage(
          message: _generateResponse(text),
          sender: MessageSender.ai,
          timestamp: DateTime.now(),
        ),
      );
    });

    _controller.clear();
  }

  String _generateResponse(String input) {
    final text = input.toLowerCase();

    if (text.contains("resume")) {
      return "I can help you improve your resume. Upload it later and I'll analyze it!";
    } else if (text.contains("interview")) {
      return "Let's prepare for interviews. I can ask you mock questions.";
    } else if (text.contains("roadmap") ||
        text.contains("career")) {
      return "I can create a personalized career roadmap for you.";
    }

    return "Got it! I'll help you with that. Can you give more details?";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Mentor"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // Suggestions
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                SuggestionChip(
                  label: "Resume Review",
                  onTap: () => _sendMessage("Review my resume"),
                ),
                const SizedBox(width: 8),
                SuggestionChip(
                  label: "Mock Interview",
                  onTap: () => _sendMessage("Mock interview"),
                ),
                const SizedBox(width: 8),
                SuggestionChip(
                  label: "Career Roadmap",
                  onTap: () => _sendMessage("Create career roadmap"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Chat messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: _messages[index]);
              },
            ),
          ),

          // Input
          MessageInput(
            controller: _controller,
            onSend: () => _sendMessage(_controller.text),
          ),
        ],
      ),
    );
  }
}