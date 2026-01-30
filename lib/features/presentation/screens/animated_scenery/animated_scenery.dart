import 'package:flutter/material.dart';

class WordscapesAnimatedBackground extends StatelessWidget {
  const WordscapesAnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: const [_BaseScenery(), _FlyingBirdsLayer()]);
  }
}

class _BaseScenery extends StatelessWidget {
  const _BaseScenery();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset('assets/backgrounds/sunset1.webp', fit: BoxFit.cover),
    );
  }
}

class _FlyingBirdsLayer extends StatelessWidget {
  const _FlyingBirdsLayer();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        _BirdsRow(top: 120, speedSeconds: 28, scale: 1.0),
        _BirdsRow(top: 180, speedSeconds: 35, scale: 0.7),
      ],
    );
  }
}

class _BirdsRow extends StatefulWidget {
  final double top;
  final int speedSeconds;
  final double scale;

  const _BirdsRow({
    required this.top,
    required this.speedSeconds,
    required this.scale,
  });

  @override
  State<_BirdsRow> createState() => _BirdsRowState();
}

class _BirdsRowState extends State<_BirdsRow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.speedSeconds),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) {
        final x = -250 + (screenWidth + 500) * _controller.value;

        return Positioned(
          top: widget.top,
          right: x,
          child: Transform.scale(
            scale: widget.scale,
            child: Opacity(
              opacity: 0.45,
              child: Image.asset('assets/backgrounds/birdy.png', width: 220),
            ),
          ),
        );
      },
    );
  }
}