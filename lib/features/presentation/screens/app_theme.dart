import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color(0xFFF4F6FA);
  static const letter = Colors.white;
  static const letterText = Color(0xFF1E293B);
  static const path = Color(0xFF60A5FA);
  static const gridFilled = Color(0xFF22C55E);
}

class AppText {
  static const title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: Color(0xFF0F172A),
  );

  static const letter = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.letterText,
  );
}
