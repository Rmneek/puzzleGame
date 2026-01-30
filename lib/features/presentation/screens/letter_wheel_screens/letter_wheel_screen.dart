import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_puzzle/features/presentation/controllers/game_controller.dart';
import 'package:word_puzzle/features/presentation/screens/custom_paint_screens/wheel_painter.dart';

class LetterWheel extends StatefulWidget {
  final List<String> letters;
  const LetterWheel({super.key, required this.letters});

  @override
  State<LetterWheel> createState() => LetterWheelState();
}

class LetterWheelState extends State<LetterWheel>
    with SingleTickerProviderStateMixin {
  final nodes = <LetterNode>[];
  final path = <Offset>[];
  bool tutorialMode = false;

  @override
  void initState() {
    super.initState();
    _buildNodes();

    _shuffleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _rotationAnim =
        Tween<double>(begin: 0, end: 2 * pi).animate(
          CurvedAnimation(
            parent: _shuffleController,
            curve: Curves.easeOutCubic,
          ),
        )..addListener(() {
          setState(() {
            _rotation = _rotationAnim.value;
          });
        });
  }

  @override
  void dispose() {
    _shuffleController.dispose();
    super.dispose();
  }

  void animateShuffle(List<String> newLetters) async {
    if (_shuffleController.isAnimating) return;

    await _shuffleController.forward(from: 0);

    for (int i = 0; i < nodes.length; i++) {
      nodes[i].char = newLetters[i];
      nodes[i].selected = false;
    }

    path.clear();
    _rotation = 0;
    setState(() {});
  }

  late AnimationController _shuffleController;
  late Animation<double> _rotationAnim;
  double _rotation = 0;

  final Set<LetterNode> tutorialNodes = {};

  @override
  void didUpdateWidget(covariant LetterWheel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.letters != widget.letters) {
      nodes.clear();
      path.clear();
      _buildNodes();
      setState(() {});
    }
  }

  List<Offset> getGlobalPath() {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return [];

    return path
        .map(
          (p) => box.localToGlobal(
            p + Offset(box.size.width / 2, box.size.height / 2),
          ),
        )
        .toList();
  }

  bool _isRunningTutorial = false;

  List<Offset> getGlobalNodes() {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return [];

    return nodes
        .map(
          (n) => box.localToGlobal(
            n.offset + Offset(box.size.width / 2, box.size.height / 2),
          ),
        )
        .toList();
  }

  void _buildNodes() {
    const radius = 90.0;
    for (int i = 0; i < widget.letters.length; i++) {
      final a = (2 * pi / widget.letters.length) * i;
      nodes.add(
        LetterNode(widget.letters[i], Offset(cos(a) * radius, sin(a) * radius)),
      );
    }
  }

  void _onPanUpdate(DragUpdateDetails d) {
    if (tutorialMode) return;

    final box = context.findRenderObject() as RenderBox;
    final local =
        box.globalToLocal(d.globalPosition) -
        Offset(box.size.width / 2, box.size.height / 2);

    for (final n in nodes) {
      if (!n.selected && (n.offset - local).distance < 30) {
        n.selected = true;
        path.add(n.offset);
        context.read<GameController>().addLetter(n.char);
        setState(() {});
      }
    }
  }

  void _onPanEnd(DragEndDetails d) {
    if (tutorialMode) return;

    context.read<GameController>().submit();
    _reset();
  }

  void _reset() {
    for (final n in nodes) {
      n.selected = false;
    }
    path.clear();
    setState(() {});
  }

  Future<void> playTutorialWord(String word) async {
    tutorialMode = true;
    _isRunningTutorial = true;
    tutorialNodes.clear();
    final game = context.read<GameController>();

    for (final c in word.split('')) {
      final node = nodes.firstWhere((n) => n.char == c && !n.selected);
      node.selected = true;
      path.add(node.offset);
      tutorialNodes.add(node);
      game.addLetter(c);
      setState(() {});
      await Future.delayed(const Duration(milliseconds: 400));
    }

    await Future.delayed(const Duration(milliseconds: 500));
    await Future.delayed(const Duration(milliseconds: 300));

    tutorialMode = false;
    _isRunningTutorial = false;
    tutorialNodes.clear();
    _reset();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: SizedBox(
        width: 260,
        height: 260,
        child: CustomPaint(
          painter: WheelPainter(
            nodes,
            path,
            tutorialMode,
            _isRunningTutorial,
            tutorialNodes,
            _rotation,
          ),
        ),
      ),
    );
  }
}
