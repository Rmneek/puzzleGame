import 'package:flutter/material.dart';

class WordGrid extends StatelessWidget {
  final String word;
  final bool filled;
  const WordGrid({super.key, required this.word, required this.filled});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: word.split("").map((c) {
        return Container(
          margin: const EdgeInsets.all(6),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: filled
                ? const LinearGradient(
                    colors: [Color(0xFF6EE7B7), Color(0xFF34D399)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.9),
                      Colors.white.withValues(alpha: 0.6),
                    ],
                  ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: filled
                ? [
                    BoxShadow(
                      color: const Color(0xFF34D399).withValues(alpha: 0.9),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
          ),
          alignment: Alignment.center,
          child: AnimatedScale(
            scale: filled ? 1 : 0.6,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutBack,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              opacity: filled ? 1 : 0,
              child: Text(
                c,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
