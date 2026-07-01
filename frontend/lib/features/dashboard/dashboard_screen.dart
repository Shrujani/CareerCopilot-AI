import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import 'models/dashboard_item.dart';
import 'widgets/progress_card.dart';
import 'widgets/quick_action_card.dart';
import 'widgets/recent_activity_card.dart';
import 'widgets/section_header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DashboardItem> actions = [
      DashboardItem(
        title: "AI Mentor",
        icon: Icons.smart_toy_outlined,
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.aiChat,
          );
        },
      ),
      DashboardItem(
        title: "Resume Analyzer",
        icon: Icons.description_outlined,
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.resumeAnalyzer,
          );
        },
      ),
      DashboardItem(
        title: "Mock Interview",
        icon: Icons.record_voice_over_outlined,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Mock Interview - Coming Soon"),
            ),
          );
        },
      ),
      DashboardItem(
        title: "Career Roadmap",
        icon: Icons.map_outlined,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Career Roadmap - Coming Soon"),
            ),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("CareerPilot AI"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "👋 Good Morning,",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Shrujani",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Let's build your dream career today.",
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 28),

              const ProgressCard(progress: 0.78),

              const SizedBox(height: 30),

              const SectionHeader(
                title: "Quick Actions",
              ),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: actions.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  final item = actions[index];

                  return QuickActionCard(
                    icon: item.icon,
                    title: item.title,
                    onTap: item.onTap,
                  );
                },
              ),

              const SizedBox(height: 30),

              const SectionHeader(
                title: "Recent Activity",
              ),

              const RecentActivityCard(
                activities: [
                  "Resume analyzed",
                  "Interview completed",
                  "Roadmap generated",
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}