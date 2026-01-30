import 'package:flutter/material.dart';
class AppTheme {
  static ThemeData cyberNeon() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF0B0F1A),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: Colors.cyanAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
