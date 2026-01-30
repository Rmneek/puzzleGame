import 'package:word_puzzle/features/domain/repositories/word_game_repository.dart';

class CheckWordUseCase {
  final WordGameRepository repository;

  CheckWordUseCase(this.repository);

  bool call(String input, String answer) {
    return input.toLowerCase() == answer.toLowerCase();
  }
}
