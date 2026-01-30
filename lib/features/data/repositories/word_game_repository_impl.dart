import 'package:word_puzzle/features/domain/repositories/word_game_repository.dart';

class WordGameRepositoryImpl implements WordGameRepository {
  @override
  Future<bool> checkAnswer(String input, String correct) async {
    return input.toLowerCase() == correct.toLowerCase();
  }
}
