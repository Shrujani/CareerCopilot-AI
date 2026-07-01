import 'package:flutter/material.dart';

import 'primary_button.dart';

class ErrorDialog {
  ErrorDialog._();

  static Future<void> show(
    BuildContext context, {
    String title = "Something went wrong",
    required String message,
  }) async {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: const [
              Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Error",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            PrimaryButton(
              text: "OK",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}