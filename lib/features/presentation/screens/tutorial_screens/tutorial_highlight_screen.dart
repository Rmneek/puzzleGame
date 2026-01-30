import 'package:flutter/material.dart';

class TutorialHighlight extends StatelessWidget {
  final GlobalKey targetKey;

  const TutorialHighlight({super.key, required this.targetKey});

  @override
  Widget build(BuildContext context) {
    final box = targetKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return const SizedBox();

    final pos = box.localToGlobal(Offset.zero);
    final size = box.size;

    return Stack(
      children: [
        Positioned.fill(
          child: ClipPath(
            clipper: _HoleClipper(
              holeRect: Rect.fromLTWH(
                pos.dx - 12,
                pos.dy - 12,
                size.width + 24,
                size.height + 24,
              ),
              radius: 22,
            ),
            child: Container(color: Colors.black.withValues(alpha: 0.75)),
          ),
        ),

        Positioned(
          left: pos.dx - 12,
          top: pos.dy - 12,
          width: size.width + 24,
          height: size.height + 24,
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.4),
                    blurRadius: 18,
                    spreadRadius: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HoleClipper extends CustomClipper<Path> {
  final Rect holeRect;
  final double radius;

  _HoleClipper({required this.holeRect, required this.radius});

  @override
  Path getClip(Size size) {
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(holeRect, Radius.circular(radius)))
      ..fillType = PathFillType.evenOdd; 

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
