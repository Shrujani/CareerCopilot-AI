import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/resume_analysis.dart';

class ResumeService {
  static const String baseUrl = "http://127.0.0.1:8000";

  Future<ResumeAnalysis> analyzeResume(File resumeFile) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/resume/analyze"),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        "file",
        resumeFile.path,
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (streamedResponse.statusCode != 200) {
      throw _parseErrorMessage(response.body);
    }

    return ResumeAnalysis.fromJson(
      jsonDecode(response.body),
    );
  }

  String _parseErrorMessage(String body) {
    try {
      final decoded = jsonDecode(body);

      if (decoded is Map<String, dynamic>) {
        final error = decoded['error'];
        if (error is Map<String, dynamic>) {
          final message = error['message'];
          if (message is String && message.isNotEmpty) {
            return message;
          }
        }

        final detail = decoded['detail'];
        if (detail is String && detail.isNotEmpty) {
          return detail;
        }
      }
    } catch (_) {}

    return 'Resume analysis failed.';
  }
}