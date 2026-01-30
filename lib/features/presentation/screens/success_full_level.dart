import 'dart:math';
import 'dart:ui';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:word_puzzle/features/presentation/controllers/game_controller.dart';

class LevelSuccessPanel extends StatefulWidget {
  const LevelSuccessPanel({super.key});

  @override
  State<LevelSuccessPanel> createState() => _LevelSuccessPanelState();
}

class _LevelSuccessPanelState extends State<LevelSuccessPanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _panelController;
  late final ConfettiController _centerStarController;
  late final ConfettiController _topConfettiController;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    _panelController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _centerStarController = ConfettiController(
      duration: const Duration(seconds: 2),
    );

    _topConfettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final game = context.watch<GameController>();

    if (game.showLevelCompleteUI) {
      _panelController.forward();
      _centerStarController.play();
      _topConfettiController.play();
      _playWinSound();
    } else {
      _panelController.reverse();
      _centerStarController.stop();
      _topConfettiController.stop();
    }
  }

  void _playWinSound() {
    _audioPlayer.play(AssetSource("sounds/win.mp3"), volume: 0.6);
  }

  @override
  void dispose() {
    _panelController.dispose();
    _centerStarController.dispose();
    _topConfettiController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameController>();
    final isLast = game.levelIndex == game.levels.length - 1;

    return IgnorePointer(
      ignoring: !game.showLevelCompleteUI,
      child: Stack(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: game.showLevelCompleteUI ? 1 : 0,
            child: Container(color: Colors.black.withOpacity(0.45)),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _topConfettiController,
              blastDirection: pi / 2,
              emissionFrequency: 0.05,
              numberOfParticles: 10,
              maxBlastForce: 15,
              minBlastForce: 8,
              gravity: 0.35,
              shouldLoop: false,
              colors: const [
                Colors.pink,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.purple,
              ],
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _centerStarController,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: 0,
              numberOfParticles: 22,
              maxBlastForce: 28,
              minBlastForce: 18,
              gravity: 0.25,
              shouldLoop: false,
              createParticlePath: (_) {
                final path = Path();
                path.addPolygon([
                  const Offset(0.5, 0),
                  const Offset(0.62, 0.38),
                  const Offset(1, 0.38),
                  const Offset(0.69, 0.62),
                  const Offset(0.82, 1),
                  const Offset(0.5, 0.75),
                  const Offset(0.18, 1),
                  const Offset(0.31, 0.62),
                  const Offset(0, 0.38),
                  const Offset(0.38, 0.38),
                ], true);
                return path;
              },
              colors: const [Colors.amber, Colors.yellow, Color(0xFFFFE082)],
            ),
          ),

          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Lottie.asset(
              "assets/backgrounds/Confetti.json",
              height: 180,
              repeat: false,
            ),
          ),

          Center(
            child: AnimatedBuilder(
              animation: _panelController,
              builder: (_, __) {
                return Opacity(
                  opacity: _panelController.value,
                  child: Transform.scale(
                    scale: 0.85 + (_panelController.value * 0.15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(36),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
                        child: Container(
                          width: 320,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 38,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.26),
                            borderRadius: BorderRadius.circular(36),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.45),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("🏆", style: TextStyle(fontSize: 60)),
                              const SizedBox(height: 12),
                              Text(
                                isLast ? "Fantastic!" : "Level Complete",
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                isLast
                                    ? "You’re officially a word master!"
                                    : "You crushed it — ready for more?",
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 28),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<GameController>().proceedNext(
                                    context,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 44,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                ),
                                child: Text(isLast ? "FINISH" : "NEXT LEVEL"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
