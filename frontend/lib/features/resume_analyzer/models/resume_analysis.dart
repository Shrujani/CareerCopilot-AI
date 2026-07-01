class ResumeAnalysis {
  final int atsScore;
  final String summary;
  final List<String> strengths;
  final List<String> weaknesses;
  final List<String> missingSkills;
  final List<String> improvements;

  const ResumeAnalysis({
    required this.atsScore,
    required this.summary,
    required this.strengths,
    required this.weaknesses,
    required this.missingSkills,
    required this.improvements,
  });

  factory ResumeAnalysis.fromJson(Map<String, dynamic> json) {
    return ResumeAnalysis(
      atsScore: json['ats_score'] ?? 0,
      summary: json['summary'] ?? '',
      strengths: List<String>.from(json['strengths'] ?? []),
      weaknesses: List<String>.from(json['weaknesses'] ?? []),
      missingSkills: List<String>.from(json['missing_skills'] ?? []),
      improvements: List<String>.from(json['improvements'] ?? []),
    );
  }
}