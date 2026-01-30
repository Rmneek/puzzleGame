import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_puzzle/features/presentation/controllers/game_controller.dart';

class TopGameBar extends StatelessWidget {
  final GlobalKey scoreKey;
  final GlobalKey levelKey;

  const TopGameBar({super.key, required this.scoreKey, required this.levelKey});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _InfoCard("LEVEL", "${game.levelIndex + 1}", key: levelKey),
          _InfoCard("SCORE", "${game.score}", key: scoreKey),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;

  const _InfoCard(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
