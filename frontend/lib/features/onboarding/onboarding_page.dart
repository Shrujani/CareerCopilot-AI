import 'package:flutter/material.dart';

import 'models/onboarding_page_model.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingPageModel page;

  const OnboardingPage({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(page.icon, style: const TextStyle(fontSize: 90)),

          const SizedBox(height: 40),

          Text(
            page.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          const SizedBox(height: 20),

          Text(
            page.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
