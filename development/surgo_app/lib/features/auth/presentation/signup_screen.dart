// package imports
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

// local imports
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/utils/app_notifier.dart';
import '../data/auth_repository.dart';

// SignUpScreen Stateful
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

// SignUpScreen extension of stateful
class _SignUpScreenState extends State<SignUpScreen> {
  //  controllers and formkey
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Show/Hide Passwords - bools
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  // authRepo class instance
  final _authRepo = AuthRepository();

  // override dispose function -- free up controllers
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // function to handle signup (used in signup button)
  Future<void> _handleSignup(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await _authRepo.signup(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      ); // call auth repo functino signup
      if (!mounted) return; // mounted check to see if widget is alive

      AppNotifier.showSuccess(
        context,
        "Signup successful. Please confirm your email.",
      );

      Navigator.pushReplacementNamed(context, '/login');
    } catch (err) {
      if (!mounted) return;
      AppNotifier.showError(context, err);
    }
  }

  // function to build scaffold/layout page
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                // Surgo Title
                Text("Surgo", style: theme.textTheme.displayMedium),
                const SizedBox(height: 40),

                // SignUp Title
                Text("Sign Up", style: theme.textTheme.titleMedium),
                const SizedBox(height: 24),

                // Email FormField
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
                const SizedBox(height: 16),

                // Password FormField
                TextFormField(
                  controller: _passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: theme.iconTheme.color,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    // optional basic password check
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // confirm password textfield
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: theme.iconTheme.color,
                      ),
                      onPressed: () {
                        setState(
                          () => isConfirmPasswordVisible =
                              !isConfirmPasswordVisible,
                        );
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // sign up button
                CustomButton(
                  text: "Sign Up",
                  onPressed: () {
                    _handleSignup(context);
                  },
                ),
                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    "Already a member? Log In",
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
