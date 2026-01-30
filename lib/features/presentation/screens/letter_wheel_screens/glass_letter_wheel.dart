import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:word_puzzle/features/presentation/screens/letter_wheel_screens/letter_wheel_screen.dart';

class GlassLetterWheel extends StatelessWidget {
  final List<String> letters;
  final GlobalKey<LetterWheelState> letterWheelKey;

  const GlassLetterWheel({
    super.key,
    required this.letters,
    required this.letterWheelKey,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.22),
            border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
          ),
          child: LetterWheel(key: letterWheelKey, letters: letters),
        ),
      ),
    );
  }
}
