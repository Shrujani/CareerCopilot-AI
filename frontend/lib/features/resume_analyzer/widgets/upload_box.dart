import 'package:flutter/material.dart';

class UploadBox extends StatelessWidget {
  final String? fileName;
  final VoidCallback onTap;

  const UploadBox({
    super.key,
    required this.fileName,
    required this.onTap,
  });

  bool get hasFile => fileName != null;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 32,
        ),
        decoration: BoxDecoration(
          color: hasFile
              ? Colors.green.withValues(alpha: 0.06)
              : Colors.blue.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: hasFile ? Colors.green : Colors.blue,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: hasFile
                  ? Colors.green.withValues(alpha: 0.15)
                  : Colors.blue.withValues(alpha: 0.15),
              child: Icon(
                hasFile
                    ? Icons.check_circle
                    : Icons.cloud_upload_outlined,
                size: 42,
                color: hasFile
                    ? Colors.green
                    : Colors.blue,
              ),
            ),

            const SizedBox(height: 22),

            Text(
              hasFile
                  ? "Resume Selected"
                  : "Upload Resume",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              hasFile
                  ? fileName!
                  : "Tap here to choose a PDF resume",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 18),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: hasFile
                    ? Colors.green
                    : Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                hasFile
                    ? "Choose Another Resume"
                    : "Browse Files",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}