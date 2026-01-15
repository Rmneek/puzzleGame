import 'package:clean_architecture/features/data/repositories/game_repository.dart';
import 'package:clean_architecture/features/domain/repositories/leaderboard_repository.dart';
import 'package:clean_architecture/features/presentation/controllers/sound_service.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class GameController extends ChangeNotifier {
  bool isCorrect = false;

  // celebration controller
  final ConfettiController confettiController = ConfettiController(
    duration: Duration(seconds: 2),
  );

  void celebrate() => confettiController.play();
  @override
  void dispose() {
    super.dispose();
    return confettiController.dispose();
  }

  // merged game controller

  final GameRepository repo = GameRepository();
  final ConfettiController confetti = ConfettiController(
    duration: Duration(seconds: 2),
  );

  int levelIndex = 0;
  List<String?> slotsdata = [];
  List<String> letters = [];

  GameController() {
    loadLevel();
  }

  void loadLevel() {
    final level = repo.levels[levelIndex];
    slotsdata = List.filled(level.word.length, null);
    letters = List.from(level.letters);
    notifyListeners();
  }

  void placeLetter(String letter, int index) {
    slotsdata[index] = letter;
    notifyListeners();
    SoundService.playDrop();
    checkWin();
  }

  void checkWin() {
    final formed = slotsdata.join();
    if (formed == repo.levels[levelIndex].word) {
      confetti.play();
      final leaderboardRepo = LeaderboardRepository();
      leaderboardRepo.addScore("Player", levelIndex + 1);
      SoundService.playWin();
      Future.delayed(Duration(seconds: 2), nextLevel);
    }
  }

  void nextLevel() {
    if (levelIndex < repo.levels.length - 1) {
      levelIndex++;
      loadLevel();
    }
  }
}
