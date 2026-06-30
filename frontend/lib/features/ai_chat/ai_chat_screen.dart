import 'package:flutter/material.dart';

import '../../services/chat_service.dart';
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
  final ChatService _chatService = ChatService();

  bool _isLoading = false;

  final List<ChatMessage> _messages = [
    ChatMessage(
      message: "Hi 👋 I'm CareerPilot AI. How can I help you today?",
      sender: MessageSender.ai,
      timestamp: DateTime.now(),
    ),
  ];

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty || _isLoading) return;

    setState(() {
      _messages.add(
        ChatMessage(
          message: text,
          sender: MessageSender.user,
          timestamp: DateTime.now(),
        ),
      );

      _isLoading = true;
    });

    _controller.clear();

    final reply = await _chatService.sendMessage(text);

    if (!mounted) return;

    setState(() {
      _messages.add(
        ChatMessage(
          message: reply,
          sender: MessageSender.ai,
          timestamp: DateTime.now(),
        ),
      );

      _isLoading = false;
    });
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

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isLoading && index == _messages.length) {
                  return const Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 12),
                        Text("CareerPilot AI is thinking..."),
                      ],
                    ),
                  );
                }

                return ChatBubble(message: _messages[index]);
              },
            ),
          ),

          MessageInput(
            controller: _controller,
            onSend: () => _sendMessage(_controller.text),
          ),
        ],
      ),
    );
  }
}