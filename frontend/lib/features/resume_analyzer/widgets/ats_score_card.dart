import 'package:flutter/material.dart';

class ATSScoreCard extends StatelessWidget {
  final int score;

  const ATSScoreCard({
    super.key,
    required this.score,
  });

  Color get scoreColor {
    if (score >= 80) {
      return Colors.green;
    } else if (score >= 60) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String get title {
    if (score >= 80) {
      return "Excellent Resume";
    } else if (score >= 60) {
      return "Good Resume";
    } else {
      return "Needs Improvement";
    }
  }

  String get subtitle {
    if (score >= 80) {
      return "Your resume is highly ATS compatible.";
    } else if (score >= 60) {
      return "A few improvements can make your resume stronger.";
    } else {
      return "Your resume needs significant improvements for better ATS performance.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: scoreColor.withValues(alpha: 0.25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 28,
        ),
        child: Column(
          children: [
            const Text(
              "ATS SCORE",
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            TweenAnimationBuilder<double>(
              tween: Tween(
                begin: 0,
                end: score / 100,
              ),
              duration: const Duration(milliseconds: 1500),
              builder: (context, value, child) {
                return SizedBox(
                  width: 170,
                  height: 170,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: value,
                        strokeWidth: 12,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation(scoreColor),
                      ),

                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$score",
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: scoreColor,
                              ),
                            ),
                            const Text(
                              "/100",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: scoreColor,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}