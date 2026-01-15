import 'package:clean_architecture/features/presentation/controllers/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LetterSlot extends StatelessWidget {
  final int index;

  const LetterSlot(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();

    return DragTarget<String>(
      onAccept: (data) {
        controller.placeLetter(data, index);
      },
      builder: (context, candidate, rejected) {
        final isActive = candidate.isNotEmpty;

        return AnimatedContainer(
          duration: Duration(milliseconds: 150),
          width: 55,
          height: 55,
          margin: EdgeInsets.all(6),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: isActive ? Colors.orange : Colors.deepPurple,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(14),
            color: isActive ? Colors.orange.withValues(alpha: 0.1) : null,
          ),
          child: Text(
            controller.slotsdata[index] ?? "",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
