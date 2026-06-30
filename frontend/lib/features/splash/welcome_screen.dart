import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/app_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CareerPilot AI'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.psychology,
                size: 80,
              ),
              const SizedBox(height: 20),

              const Text(
                'Welcome to CareerPilot AI',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading,
              ),

              const SizedBox(height: 15),

              const Text(
                'Your Intelligent Career Mentor',
                textAlign: TextAlign.center,
                style: AppTextStyles.subHeading,
              ),

              const SizedBox(height: 40),

              AppButton(
                text: 'Get Started',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.onboarding,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}