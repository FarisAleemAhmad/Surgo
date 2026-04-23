// package imports
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

// local imports
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/utils/app_notifier.dart';
import '../data/auth_repository.dart';

// stateful forgot password screen
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

// extension of stateful forgot password screen
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // form controller + global key
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  // authRepo class instance
  final _authRepo = AuthRepository();

  // function to dispose of controller to free resources
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // function to request password reset (used in send reset email button)
  Future<void> _handleForgotPassword(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await _authRepo.forgotPassword(_emailController.text.trim());
      if (!mounted) return;

      // always show success -- server does not reveal if email is registered
      AppNotifier.showSuccess(
        context,
        "If that email is registered, a reset link has been sent.",
      );

      Navigator.pushReplacementNamed(context, '/login');
    } catch (err) {
      if (!mounted) return;
      AppNotifier.showError(context, err);
    }
  }

  // function to build the scaffold/page layout
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // theme generalization -- defined in lib/app/theme

    // return the forgot password screen layout
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // text SURGO title
                Text("Surgo", style: theme.textTheme.displayMedium),
                const SizedBox(height: 40),

                // text Forgot Password title
                Text("Forgot Password", style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),

                // instructional subtitle
                Text(
                  "Enter your email and we'll send you a reset link.",
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // email field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: (value) {
                    // null / empty
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    // email syntax check
                    if (!EmailValidator.validate(value.trim())) {
                      return 'Enter a valid email';
                    }
                    // no error
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // send reset email button
                CustomButton(
                  text: "Send Reset Email",
                  onPressed: () {
                    _handleForgotPassword(context);
                  },
                ),
                const SizedBox(height: 20),

                // text button - back to login
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    "Back to Login",
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
