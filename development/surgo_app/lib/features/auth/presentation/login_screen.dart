// package imports
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// local imports
import '../../../shared/widgets/custom_button.dart';
import '../data/auth_repository.dart';

// stateful login screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// extension of stateful login screen
class _LoginScreenState extends State<LoginScreen> {
  // form controllers + global key
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // functionality showing/hiding password
  bool isPasswordVisible = false;

  // repository + secure storage variables
  final _authRepo =
      AuthRepository(); // assign authRepo the authrepository class
  final _secureStorage = const FlutterSecureStorage();

  // function to dispose of controller to free resources
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // function to login the user (used in login button)
  Future<void> _handleLogin(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final token = await _authRepo.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      await _secureStorage.write(key: 'jwt', value: token);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } catch (err) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login failed: $err')));
    }
  }

  // function to build the scaffold/page layout
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(
      context,
    ); // theme generalization -- defined in lib/app/theme

    //return the login screen layout
    return Scaffold(
      backgroundColor:
          theme.scaffoldBackgroundColor, // generalized color scheme
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

                // text LOGIN title
                Text("Login", style: theme.textTheme.titleMedium),

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
                const SizedBox(height: 16),

                // label 'password' + // textfield - enter password + show/hide password
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
                const SizedBox(height: 24),

                // login button custom -- navigation to home screen -- authentication/validation on click
                CustomButton(
                  text: "Login",
                  onPressed: () {
                    _handleLogin(context);
                  },
                ),
                const SizedBox(height: 20),

                // text button - no account -- sign up screen. -- LINK NAVIGATION TO SIGN UP PAGE -- should this use replacement named
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    "Don't have an account? Sign Up",
                    style: theme.textTheme.bodyMedium,
                  ),
                ),

                // text button - forgot password navigation to password reset -- LINK NAVIGATION LATER ON
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ], // Children
            ),
          ),
        ),
      ),
    );
  }
}
