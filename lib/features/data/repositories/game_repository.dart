import 'package:clean_architecture/features/domain/entities/letter_level.dart';

class GameRepository {
  List<LetterLevel> levels = [
    LetterLevel(word: "FLUTTER", letters: ["F", "L", "U", "T", "T", "E", "R"]),
    LetterLevel(word: "DART", letters: ["D", "A", "R", "T"]),
    LetterLevel(word: "WIDGET", letters: ["W", "I", "D", "G", "E", "T"]),
  ];
}
