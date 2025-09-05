// main entrypoint

import 'package:flutter/material.dart';
import 'app/app.dart'; // import global config app

Future<void> main() async {
  // Ensure flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Run App
  runApp(const App());
}
