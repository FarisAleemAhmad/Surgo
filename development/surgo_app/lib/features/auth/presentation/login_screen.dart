import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(
      context,
    ); // theme generalization -- defined in lib/app/theme

    //return the login screen layout
    return Scaffold(
      backgroundColor: const Color(0xFF2A2A2B), // hardcoded color - generalize
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // text SURGO title
              Text(
                "Surgo",
                style: theme.textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              // text LOGIN title
              Text(
                "Login",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // labeled 'email' + textfield - enter email
              TextField(decoration: const InputDecoration(labelText: "Email")),
              const SizedBox(height: 16),

              // label 'password' + // textfield - enter password
              TextField(
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              const SizedBox(height: 24),

              // login button custom -- link navigation to homescreen and include authentication etc
              CustomButton(text: "Login", onPressed: () {}),
              const SizedBox(height: 20),

              // text button - no account -- sign up screen. -- LINK NAVIGATION TO SIGN UP PAGE
              TextButton(
                onPressed: () {},
                child: const Text("Don't have an account? Sign Up"),
              ),

              // text button - forgot password navigation to password reset -- LINK NAVIGATION LATER ON
              TextButton(
                onPressed: () {},
                child: const Text("Forgot Password?"),
              ),
            ], // Children
          ),
        ),
      ),
    );
  }
}
