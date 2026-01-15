import 'package:flutter/material.dart';

class TutorialOverlay extends StatelessWidget {
  final String text;

  const TutorialOverlay({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.6),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                text,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
