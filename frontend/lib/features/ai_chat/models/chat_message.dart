enum MessageSender {
  user,
  ai,
}

class ChatMessage {
  final String message;
  final MessageSender sender;
  final DateTime timestamp;

  const ChatMessage({
    required this.message,
    required this.sender,
    required this.timestamp,
  });

  bool get isUser => sender == MessageSender.user;
}