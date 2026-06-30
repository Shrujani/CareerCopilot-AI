import 'dart:convert';

import 'package:http/http.dart' as http;

class ChatService {
  // Android Emulator:
  // static const String _baseUrl = "http://10.0.2.2:8000";

  // iPhone Simulator / macOS:
  static const String _baseUrl = "http://127.0.0.1:8000";

  // Physical phone:
  // static const String _baseUrl = "http://YOUR_IP:8000";

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/chat"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "message": message,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data["reply"];
      }

      return "Server Error (${response.statusCode})";
    } catch (e) {
      return "Connection Error: $e";
    }
  }
}