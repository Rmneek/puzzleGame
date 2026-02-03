import 'package:flutter/material.dart';
import 'package:word_puzzle/features/data/datasources/local_word_data.dart';
import 'package:word_puzzle/features/domain/entities/game_level.dart';
import 'package:word_puzzle/features/domain/enum/tutorial_step_enum.dart';




class GameController extends ChangeNotifier {

  bool isTutorialRunning = false;

  void startTutorial() {
    isTutorialRunning = true;
    notifyListeners();
  }

  void endTutorial() {
    isTutorialRunning = false;
    notifyListeners();
  }

  int tutorialPlayCount = 0;
  final int maxTutorialPlays = 2;
  int makeWordRuns = 0;
  final int maxMakeWordRuns = 2;

  bool get hasTutorialPlayed => tutorialPlayCount >= maxTutorialPlays;

  void markTutorialPlayedOnce() {
    tutorialPlayCount++;
    notifyListeners();
  }

  TutorialStep tutorialStep = TutorialStep.makeWord;

  void advanceTutorial() {
    switch (tutorialStep) {
      case TutorialStep.makeWord:
        makeWordRuns++;
        if (makeWordRuns >= maxMakeWordRuns) {
          tutorialStep = TutorialStep.showLevel;
        }
        break;
      case TutorialStep.showLevel:
        tutorialStep = TutorialStep.showScore;
        break;
      case TutorialStep.showScore:
        tutorialStep = TutorialStep.done;
        break;
      case TutorialStep.done:
        break;
    }
    notifyListeners();
  }

  bool showLevelCompleteUI = false;

  void completeLevel() {
    showLevelCompleteUI = true;
    notifyListeners();
  }

  void proceedNext(BuildContext context) {
    showLevelCompleteUI = false;

    if (levelIndex < levels.length - 1) {
      nextLevel();
    }

    notifyListeners();
  }

 
  void shuffleLetters() {
    level.letters.shuffle();
    notifyListeners();
  }

  int levelIndex = 0;
  String input = "";
  int score = 0;
  bool levelCompleted = false;
  final Set<String> foundWords = {};

  GameLevel get level => levels[levelIndex];

  void addLetter(String c) {
    input += c;
    notifyListeners();
  }

  void submit() {
    if (level.words.contains(input) && !foundWords.contains(input)) {
      foundWords.add(input);
      score += 50;
      if (foundWords.length == level.words.length) {
        levelCompleted = true;
        completeLevel();
        return;
      }
    }
    input = "";
    notifyListeners();
  }

  void nextLevel() {
    if (levelIndex < levels.length - 1) {
      levelIndex++;
      tutorialStep = TutorialStep.done;
      foundWords.clear();
      input = "";
      levelCompleted = false;
      notifyListeners();
    }
  }
}
