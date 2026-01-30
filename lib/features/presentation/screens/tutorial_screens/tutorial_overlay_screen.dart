import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_puzzle/features/presentation/controllers/game_controller.dart';
import 'package:word_puzzle/features/presentation/screens/game_level.dart';
import 'package:word_puzzle/features/presentation/screens/letter_wheel_screens/letter_wheel_screen.dart';
import 'package:word_puzzle/features/presentation/screens/tutorial_screens/tutorial_arrow_hint.dart';
import 'package:word_puzzle/features/presentation/screens/tutorial_screens/tutorial_dialog.dart';
import 'package:word_puzzle/features/presentation/screens/tutorial_screens/tutorial_finger_guide_widget.dart';
import 'package:word_puzzle/features/presentation/screens/tutorial_screens/tutorial_highlight_screen.dart';

class TutorialOverlay extends StatefulWidget {
  final GlobalKey<LetterWheelState> wheelKey;
  const TutorialOverlay({super.key, required this.wheelKey});

  @override
  State<TutorialOverlay> createState() => _TutorialOverlayState();
}

class _TutorialOverlayState extends State<TutorialOverlay> {
  bool started = false;

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameController>();
    final wheelState = widget.wheelKey.currentState;

    if (game.hasTutorialPlayed) return const SizedBox();
    switch (game.tutorialStep) {
      case TutorialStep.makeWord:
        if (wheelState == null || wheelState.nodes.isEmpty) {
          return const SizedBox();
        }

        final globalPath = wheelState.getGlobalPath();
        final globalNodes = wheelState.getGlobalNodes();

        if (!started) {
          started = true;
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await wheelState.playTutorialWord(game.level.words.first);
            game.advanceTutorial();
            started = false;
          });
        }
        return IgnorePointer(
          child: Stack(
            children: [
              Positioned.fill(
                child: TutorialFingerGuide(path: globalPath, loops: 5),
              ),
              if (globalNodes.isNotEmpty)
                TutorialArrowHint(target: globalNodes.first),
            ],
          ),
        );
      case TutorialStep.showLevel:
        return Stack(
          children: [
            TutorialHighlight(
              targetKey: context
                  .findAncestorStateOfType<GameScreenState>()!
                  .levelKey,
            ),
            TutorialDialog(
              value: "This shows your current level ",
              onGotIt: () {
                context.read<GameController>().advanceTutorial();
              },
            ),
          ],
        );

      case TutorialStep.showScore:
        return Stack(
          children: [
            TutorialHighlight(
              targetKey: context
                  .findAncestorStateOfType<GameScreenState>()!
                  .scoreKey,
            ),
            TutorialDialog(
              value: "Your score increases as you find words",
              onGotIt: () {
                context.read<GameController>().advanceTutorial();
              },
            ),
          ],
        );
      case TutorialStep.done:
        return const SizedBox();
    }
  }
}
