// basic imports
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF2A2A2B),
      // self defined color scheme
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF7B2CBF),
        secondary: Color(0xFF3B3B3D),
      ),

      // self defined text scheme
      textTheme: const TextTheme(
        // display medium
        displayMedium: TextStyle(
          fontFamily: 'Pontano Sans',
          fontWeight: FontWeight.bold,
          fontSize: 32,
          color: Colors.white,
        ),

        // title medium
        titleMedium: TextStyle(
          fontFamily: 'Pontano Sans',
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Colors.white,
        ),

        // body medium
        bodyMedium: TextStyle(
          fontFamily: 'Pontano Sans',
          fontSize: 16,
          color: Colors.white70,
        ),
      ),

      // self defined elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7B2CBF),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),

      // input decoration theme
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          fontFamily: 'Pontano Sans',
          color: Colors.white70,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white30),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF7B2CBF)),
        ),
      ),

      iconTheme: const IconThemeData(color: Colors.white70, size: 24),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.red.shade400, // error background
        contentTextStyle: TextStyle(color: Colors.white), // text color
        behavior: SnackBarBehavior.floating, // nice floating look
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: const EdgeInsets.all(16),
      ),
    );
  }
}
