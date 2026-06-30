import 'package:flutter/material.dart';

import 'widgets/auth_button.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/password_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration functionality coming soon")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Account"), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Your Account",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                const SizedBox(height: 8),

                Text(
                  "Start your journey with CareerPilot AI.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 40),

                AuthTextField(controller: _nameController, label: "Full Name"),

                const SizedBox(height: 20),

                AuthTextField(
                  controller: _emailController,
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 20),

                PasswordField(controller: _passwordController),

                const SizedBox(height: 20),

                PasswordField(
                  controller: _confirmPasswordController,
                  label: "Confirm Password",
                ),

                const SizedBox(height: 30),

                AuthButton(text: "Create Account", onPressed: _register),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
