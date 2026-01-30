import 'package:flutter/material.dart';

enum BackgroundTheme { sky, night, forest }

enum TutorialStep { makeWord, showLevel, showScore, done }

class GameLevel {
  final List<String> letters;
  final List<String> words;
  GameLevel({required this.letters, required this.words});
}

class LetterNode {
  String char;
  final Offset offset;
  bool selected = false;
  LetterNode(this.char, this.offset);
}

class GameController extends ChangeNotifier {
  BackgroundTheme theme = BackgroundTheme.sky;
  void setTheme(BackgroundTheme t) {
    theme = t;
    notifyListeners();
  }

  int tutorialPlayCount = 0;
  final int maxTutorialPlays = 5;
int makeWordRuns = 0;
final int maxMakeWordRuns = 4;

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

  final levels = [
    GameLevel(letters: ["D", "O", "G"], words: ["DOG", "GOD", "ODG"]),
    GameLevel(letters: ["C", "A", "T"], words: ["CAT", "ACT", "TAC"]),
    GameLevel(letters: ["M", "O", "O", "N"], words: ["MOON", "MONO", "NOOM"]),
  ];
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
