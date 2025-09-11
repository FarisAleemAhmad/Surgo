//mockup home screen for auth testing -- chatgpt generated

// package imports
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// local imports
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/utils/app_notifier.dart';
import '../../auth/data/auth_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // add secure storage + repo instance
  static final _authRepo = AuthRepository();
  static final _secureStorage = const FlutterSecureStorage();

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
                onPressed: () async {
                  await _secureStorage.delete(key: 'jwt');
                  if (!context.mounted) return;
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
              const SizedBox(height: 20),

              // Delete Account button
              CustomButton(
                text: "Delete Account",
                onPressed: () async {
                  try {
                    await _authRepo.deleteAccount();
                    await _secureStorage.delete(key: 'jwt');
                    if (!context.mounted) return;
                    AppNotifier.showSuccess(
                      context,
                      "Your account has been deleted.",
                    );
                    Navigator.pushReplacementNamed(context, '/login');
                  } catch (err) {
                    if (!context.mounted) return;
                    AppNotifier.showError(context, err);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
