import 'package:flutter/material.dart';

import '../../features/onboarding/onboarding_screen.dart';
import '../../features/splash/welcome_screen.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static Map<String, WidgetBuilder> get routes => {
        AppRoutes.welcome: (context) => const WelcomeScreen(),
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
      };
}