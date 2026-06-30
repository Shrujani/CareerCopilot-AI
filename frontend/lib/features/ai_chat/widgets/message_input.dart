import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool enabled;

  const MessageInput({
    super.key,
    required this.controller,
    required this.onSend,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                enabled: enabled,
                decoration: const InputDecoration(
                  hintText: "Ask CareerPilot AI...",
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) {
                  if (enabled) onSend();
                },
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: enabled ? onSend : null,
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}