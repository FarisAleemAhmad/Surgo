// basic imports
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

// screen imports

// auth screens
import '../features/auth/presentation/login_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Surgo",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,

      // ROUTING
      home: const LoginScreen(), // hardcoded - fix later
    );
  }
}
