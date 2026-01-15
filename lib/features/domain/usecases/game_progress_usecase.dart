import 'package:clean_architecture/features/domain/entities/game_progress.dart';

class AdvanceLevelUseCase {
  GameProgress call(GameProgress progress) {
    return GameProgress(
      currentLevel: progress.currentLevel + 1,
      totalLevels: progress.totalLevels,
    );
  }
}
