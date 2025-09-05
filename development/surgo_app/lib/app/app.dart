// basic imports
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

// screen imports

// auth screens
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/signup_screen.dart';
import '../features/home/presentation/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Surgo",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,

      // ROUTING
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
