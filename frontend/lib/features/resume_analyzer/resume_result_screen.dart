import 'package:flutter/material.dart';

import 'models/resume_analysis.dart';
import 'widgets/ats_score_card.dart';
import 'widgets/info_card.dart';

class ResumeResultScreen extends StatelessWidget {
  final ResumeAnalysis analysis;

  const ResumeResultScreen({
    super.key,
    required this.analysis,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume Analysis"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ATSScoreCard(
                score: analysis.atsScore,
              ),

              const SizedBox(height: 24),

              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.description_outlined,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Executive Summary",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Text(
                        analysis.summary,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              InfoCard(
                title: "Strengths",
                items: analysis.strengths,
                icon: Icons.check_circle,
                color: Colors.green,
              ),

              InfoCard(
                title: "Weaknesses",
                items: analysis.weaknesses,
                icon: Icons.warning_amber_rounded,
                color: Colors.red,
              ),

              InfoCard(
                title: "Missing Skills",
                items: analysis.missingSkills,
                icon: Icons.psychology_alt_outlined,
                color: Colors.orange,
              ),

              InfoCard(
                title: "AI Recommendations",
                items: analysis.improvements,
                icon: Icons.auto_awesome,
                color: Colors.blue,
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "PDF report generation will be available soon.",
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.picture_as_pdf_outlined),
                  label: const Text(
                    "Download Report",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.upload_file),
                  label: const Text(
                    "Analyze Another Resume",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}