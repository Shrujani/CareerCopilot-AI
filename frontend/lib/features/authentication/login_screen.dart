import 'package:flutter/material.dart';

import 'widgets/auth_button.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/password_field.dart';
import 'widgets/social_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login functionality coming soon")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                Text(
                  "Welcome Back 👋",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                const SizedBox(height: 8),

                Text(
                  "Sign in to continue your career journey.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 40),

                AuthTextField(
                  controller: _emailController,
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 20),

                PasswordField(controller: _passwordController),

                const SizedBox(height: 12),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Forgot Password?"),
                  ),
                ),

                const SizedBox(height: 20),

                AuthButton(text: "Login", onPressed: _login),

                const SizedBox(height: 30),

                const Center(child: Text("OR")),

                const SizedBox(height: 20),

                SocialLoginButton(
                  icon: Icons.g_mobiledata,
                  text: "Continue with Google",
                  onPressed: () {},
                ),

                const SizedBox(height: 16),

                SocialLoginButton(
                  icon: Icons.code,
                  text: "Continue with GitHub",
                  onPressed: () {},
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),

                    TextButton(onPressed: () {}, child: const Text("Register")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
