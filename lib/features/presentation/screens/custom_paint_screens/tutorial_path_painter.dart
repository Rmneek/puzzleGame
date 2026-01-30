import 'package:flutter/material.dart';

class TutorialPathPainter extends CustomPainter {
  final List<Offset> points;
  final double progress;

  static const double radius = 26;

  TutorialPathPainter(this.points, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final totalSegments = points.length - 1;
    final totalProgress = progress * totalSegments;

    final fullSegments = totalProgress.floor();
    final partialT = totalProgress - fullSegments;

    for (int i = 0; i < fullSegments; i++) {
      _drawSegment(canvas, points[i], points[i + 1], paint);
    }

    if (fullSegments < totalSegments) {
      final a = points[fullSegments];
      final b = points[fullSegments + 1];
      final p = Offset.lerp(a, b, partialT)!;
      _drawSegment(canvas, a, p, paint);
    }
  }

  void _drawSegment(Canvas c, Offset a, Offset b, Paint paint) {
    final dir = b - a;
    final len = dir.distance;
    if (len == 0) return;

    final unit = dir / len;
    final start = a + unit * radius;
    final end = b - unit * radius;

    c.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant TutorialPathPainter old) =>
      old.progress != progress || old.points != points;
}
