import 'package:clean_architecture/features/domain/entities/word_level.dart';

class WordLevelModel extends WordLevel {
  WordLevelModel({
    required super.level,
    required super.answer,
    required super.letters,
    required super.maxHints,
  });

  factory WordLevelModel.fromJson(Map<String, dynamic> json) {
    return WordLevelModel(
      level: json['level'],
      answer: json['answer'],
      letters: List<String>.from(json['letters']),
      maxHints: json['maxHints'],
    );
  }
}
