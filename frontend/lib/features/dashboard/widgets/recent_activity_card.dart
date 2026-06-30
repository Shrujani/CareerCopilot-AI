import 'package:flutter/material.dart';

import 'dashboard_card.dart';

class RecentActivityCard extends StatelessWidget {
  final List<String> activities;

  const RecentActivityCard({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: activities
            .map(
              (activity) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(activity)),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}