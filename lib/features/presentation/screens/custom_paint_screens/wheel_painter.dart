import 'package:flutter/material.dart';
import 'package:word_puzzle/features/domain/entities/letter_node.dart';

class WheelPainter extends CustomPainter {
  final List<LetterNode> nodes;
  final List<Offset> path;
  final bool tutorialMode;
  final bool isRunningTutorial;
  final Set<LetterNode> tutorialNodes;
  final double rotation;
  static const double radius = 26;

  WheelPainter(
    this.nodes,
    this.path,
    this.tutorialMode,
    this.isRunningTutorial,
    this.tutorialNodes,
    this.rotation,
  );

  @override
  void paint(Canvas c, Size s) {
    c.translate(s.width / 2, s.height / 2);
    c.rotate(rotation);
    for (final n in nodes) {
      final selected = isRunningTutorial ? true : n.selected;
      c.drawCircle(
        n.offset,
        radius,
        Paint()..color = selected ? Colors.blueAccent : Colors.white,
      );

      final tp = TextPainter(
        text: TextSpan(
          text: n.char,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      tp.paint(c, n.offset - Offset(tp.width / 2, tp.height / 2));
    }

    if (path.length > 1) {
      final paint = Paint()
        ..color = Colors.blueAccent
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round;

      for (int i = 0; i < path.length - 1; i++) {
        final a = path[i];
        final b = path[i + 1];
        final dir = b - a;
        final len = dir.distance;
        if (len == 0) continue;
        final unit = dir / len;
        final start = a + unit * radius;
        final end = b - unit * radius;
        c.drawLine(start, end, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant WheelPainter oldDelegate) => true;
}
