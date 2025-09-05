//mockup home screen for auth testing -- chatgpt generated

import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App title
              Text("Surgo", style: theme.textTheme.displayMedium),
              const SizedBox(height: 20),

              // Welcome/Home text
              Text("Home", style: theme.textTheme.titleMedium),
              const SizedBox(height: 40),

              // Placeholder content
              Text(
                "Welcome to your gym tracker!",
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),

              // Logout button
              CustomButton(
                text: "Logout",
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
