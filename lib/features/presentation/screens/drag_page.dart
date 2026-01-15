import 'package:clean_architecture/core/utils/values/colors.dart';
import 'package:clean_architecture/features/presentation/controllers/sound_service.dart';
import 'package:flutter/material.dart';

class LetterTile extends StatelessWidget {
  final String letter;

  const LetterTile(this.letter, {super.key});

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: letter,
      feedback: tile(letter, dragging: true),
      childWhenDragging: tile(letter, faded: true),
      child: tile(letter),
      onDragStarted: () => SoundService.playTap(),
      onDragEnd: (_) => SoundService.playDrop(),
      onDragCompleted: () => SoundService.playDrop(),
    );
  }

  Widget tile(String text, {bool dragging = false, bool faded = false}) {
    return Opacity(
      opacity: faded ? 0.3 : 1,
      child: Container(
        width: 55,
        margin: EdgeInsets.all(4),
        height: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: dragging
                ? [Colors.orange, primary]
                : [primary, primary.withValues(alpha: 0.85)],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: primary.withValues(alpha: 0.35),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
