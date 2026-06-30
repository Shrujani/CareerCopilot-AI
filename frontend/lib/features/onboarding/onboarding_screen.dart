import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import 'onboarding_data.dart';
import 'onboarding_page.dart';
import 'widgets/next_button.dart';
import 'widgets/page_indicator.dart';
import 'widgets/skip_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  bool get isLastPage => _currentPage == onboardingPages.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (isLastPage) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _skip() {
    _pageController.jumpToPage(onboardingPages.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [if (!isLastPage) SkipButton(onPressed: _skip)]),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingPages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingPage(page: onboardingPages[index]);
                },
              ),
            ),
            PageIndicator(
              controller: _pageController,
              count: onboardingPages.length,
            ),
            const SizedBox(height: 30),
            NextButton(isLastPage: isLastPage, onPressed: _nextPage),
          ],
        ),
      ),
    );
  }
}
