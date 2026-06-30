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
  final ScrollController _scrollController = ScrollController();

  final ChatService _chatService = ChatService();

  bool _isLoading = false;

  final List<ChatMessage> _messages = [
    ChatMessage(
      message: "Hi 👋 I'm CareerPilot AI. How can I help you today?",
      sender: MessageSender.ai,
      timestamp: DateTime.now(),
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty || _isLoading) return;

    final userMessage = text.trim();

    setState(() {
      _messages.add(
        ChatMessage(
          message: userMessage,
          sender: MessageSender.user,
          timestamp: DateTime.now(),
        ),
      );

      _isLoading = true;
    });

    _controller.clear();
    _scrollToBottom();

    final reply = await _chatService.sendMessage(userMessage);

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

    _scrollToBottom();
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
                  onTap: () => _sendMessage("Conduct a mock interview"),
                ),
                const SizedBox(width: 8),
                SuggestionChip(
                  label: "Career Roadmap",
                  onTap: () => _sendMessage("Create a career roadmap"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isLoading && index == _messages.length) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text("CareerPilot AI is thinking..."),
                        ],
                      ),
                    ),
                  );
                }

                return ChatBubble(
                  message: _messages[index],
                );
              },
            ),
          ),

          MessageInput(
            controller: _controller,
            enabled: !_isLoading,
            onSend: () => _sendMessage(_controller.text),
          ),
        ],
      ),
    );
  }
}