import 'package:clean_architecture/core/utils/values/colors.dart';
import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final Widget child;

  const GameCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}
