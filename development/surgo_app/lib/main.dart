// main entrypoint

import 'package:flutter/material.dart';
import 'app/app.dart'; // import global config app

Future<void> main() async {
  // Ensure flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized;

  // Supabase Initialization (TODO)

  // Run App
  runApp(const App());
}
