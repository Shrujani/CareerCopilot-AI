import 'package:flutter/material.dart';

import '../../features/ai_chat/ai_chat_screen.dart';
import '../../features/authentication/forgot_password_screen.dart';
import '../../features/authentication/login_screen.dart';
import '../../features/authentication/register_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/resume_analyzer/resume_upload_screen.dart';
import '../../features/splash/welcome_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcome:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );

      case AppRoutes.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );

      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );

      case AppRoutes.dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );

      case AppRoutes.aiChat:
        return MaterialPageRoute(
          builder: (_) => const AiChatScreen(),
        );

      case AppRoutes.resumeAnalyzer:
        return MaterialPageRoute(
          builder: (_) => const ResumeUploadScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );
    }
  }
}