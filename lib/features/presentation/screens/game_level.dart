import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_puzzle/features/presentation/controllers/game_controller.dart';
import 'package:word_puzzle/features/presentation/screens/animated_scenery/animated_scenery.dart';
import 'package:word_puzzle/features/presentation/screens/letter_wheel_screens/glass_letter_wheel.dart';
import 'package:word_puzzle/features/presentation/screens/letter_wheel_screens/letter_wheel_screen.dart';
import 'package:word_puzzle/features/presentation/screens/letter_wheel_screens/word_grid_screen.dart';
import 'package:word_puzzle/features/presentation/screens/success_full_level.dart';
import 'package:word_puzzle/features/presentation/screens/top_game_appbar.dart';
import 'package:word_puzzle/features/presentation/screens/tutorial_screens/tutorial_overlay_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  final GlobalKey<LetterWheelState> letterWheelKey =
      GlobalKey<LetterWheelState>();

  final GlobalKey scoreKey = GlobalKey();
  final GlobalKey levelKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameController>();

    return Scaffold(
      body: Stack(
        children: [
          WordscapesAnimatedBackground(),
          Positioned.fill(
            child: Container(color: Colors.white.withValues(alpha: 0.08)),
          ),
          SafeArea(
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOutCubic,
              offset: game.showLevelCompleteUI
                  ? const Offset(0, 0.4)
                  : Offset.zero,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: game.showLevelCompleteUI ? 0 : 1,
                child: Column(
                  children: [
                    TopGameBar(scoreKey: scoreKey, levelKey: levelKey),
                    const SizedBox(height: 16),
                    Column(
                      children: game.level.words
                          .map(
                            (w) => WordGrid(
                              word: w,
                              filled: game.foundWords.contains(w),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    Visibility(
                      visible: !game.isTutorialRunning,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          game.input,
                          key: ValueKey(game.input),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 24,
                                offset: Offset(0, 12),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              final wheel = letterWheelKey.currentState;

                              game.shuffleLetters();
                              wheel?.animateShuffle(game.level.letters);
                            },

                            icon: Image.asset(
                              'assets/backgrounds/shuffle.png',
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        GlassLetterWheel(
                          letters: game.level.letters,
                          letterWheelKey: letterWheelKey,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          const LevelSuccessPanel(),
          if (!game.hasTutorialPlayed)
            Positioned.fill(
              child: AbsorbPointer(
                absorbing: game.isTutorialRunning, 
                child: TutorialOverlay(wheelKey: letterWheelKey),
              ),
            ),

        ],
      ),
    );
  }
}
