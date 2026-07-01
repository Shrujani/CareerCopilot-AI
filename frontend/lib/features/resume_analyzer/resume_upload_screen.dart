import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/error_dialog.dart';
import '../../core/widgets/loading_dialog.dart';
import 'models/resume_analysis.dart';
import 'resume_result_screen.dart';
import 'services/resume_service.dart';
import 'widgets/upload_box.dart';

class ResumeUploadScreen extends StatefulWidget {
  const ResumeUploadScreen({super.key});

  @override
  State<ResumeUploadScreen> createState() => _ResumeUploadScreenState();
}

class _ResumeUploadScreenState extends State<ResumeUploadScreen> {
  File? _selectedFile;

  final ResumeService _resumeService = ResumeService();

  Future<void> _pickResume() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) return;

    final path = result.files.single.path;

    if (path == null) return;

    setState(() {
      _selectedFile = File(path);
    });
  }

  Future<void> _analyzeResume() async {
    if (_selectedFile == null) return;

    LoadingDialog.show(context);

    try {
      final ResumeAnalysis analysis =
          await _resumeService.analyzeResume(_selectedFile!);

      if (!mounted) return;

      LoadingDialog.hide(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResumeResultScreen(
            analysis: analysis,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      LoadingDialog.hide(context);

      await ErrorDialog.show(
        context,
        title: "Resume Analysis Failed",
        message:
            "Unable to analyze your resume.\n\n${e.toString()}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileName = _selectedFile?.path.split('/').last;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume Analyzer"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 10),

              const CircleAvatar(
                radius: 45,
                backgroundColor: Color(0xffE8F1FF),
                child: Icon(
                  Icons.description_outlined,
                  size: 48,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                "AI Resume Analyzer",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Upload your resume and receive an ATS score, AI feedback, strengths, weaknesses and improvement suggestions.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 35),

              UploadBox(
                fileName: fileName,
                onTap: _pickResume,
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed:
                      _selectedFile == null ? null : _analyzeResume,
                  icon: const Icon(Icons.analytics_outlined),
                  label: const Text(
                    "Analyze Resume",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Text(
                "Supported format: PDF",
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}