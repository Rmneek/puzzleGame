import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_puzzle/features/presentation/controllers/game_controller.dart';
import 'package:word_puzzle/features/presentation/screens/custom_paint_screens/tutorial_path_painter.dart';

class TutorialFingerGuide extends StatefulWidget {
  final List<Offset> path;
  final int loops;

  const TutorialFingerGuide({super.key, required this.path, this.loops = 3});

  @override
  State<TutorialFingerGuide> createState() => _TutorialFingerGuideState();
}

class _TutorialFingerGuideState extends State<TutorialFingerGuide>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progress;
  void _onFinished() {
    context.read<GameController>().submit();
    context.read<GameController>().advanceTutorial();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _progress = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        loopsDone++;
        if (loopsDone >= widget.loops) {
          _controller.stop();
          _onFinished();
        } else {
          _controller.forward(from: 0);
        }
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset _interpolatedPosition() {
    final loopT = _progress.value;
    final t = loopT * (widget.path.length - 1);
    final i = t.floor();
    final frac = t - i;

    if (i >= widget.path.length - 1) {
      return widget.path.last;
    }

    return Offset.lerp(widget.path[i], widget.path[i + 1], frac)!;
  }

  int loopsDone = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.path.length < 2) return const SizedBox();

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) {
        final fingerPos = _interpolatedPosition();

        return Stack(
          children: [
            CustomPaint(
              painter: TutorialPathPainter(widget.path, _progress.value),
            ),
            Positioned(
              left: fingerPos.dx - 24,
              top: fingerPos.dy - 24,
              child: const Icon(Icons.touch_app, size: 48, color: Colors.white),
            ),
            Positioned(
              top: 400,
              left: 100,
              width: 300,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Text(
                    "Connect Letters to make a word",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
