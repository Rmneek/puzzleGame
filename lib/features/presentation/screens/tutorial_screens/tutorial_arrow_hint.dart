import 'package:flutter/material.dart';

class TutorialArrowHint extends StatefulWidget {
  final Offset target;

  const TutorialArrowHint({super.key, required this.target});

  @override
  State<TutorialArrowHint> createState() => _TutorialArrowHintState();
}

class _TutorialArrowHintState extends State<TutorialArrowHint>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) => Positioned(
        left: widget.target.dx - 20,
        top: widget.target.dy - 60 - (_controller.value * 10),
        child: const Icon(
          Icons.arrow_downward_rounded,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
