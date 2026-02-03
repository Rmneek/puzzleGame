import 'package:word_puzzle/core/di/app_component/app_component.config.dart';
import 'package:word_puzzle/features/domain/repositories/word_game_repository.dart';
import 'package:word_puzzle/features/domain/usecases/check_word_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:word_puzzle/features/presentation/controllers/game_controller.dart';

final GetIt locator = GetIt.I;

@InjectableInit(preferRelativeImports: false)
Future<void> initAppComponentLocator() async => locator.init();
void setupLocator() {
  locator.registerLazySingleton(() => CheckWordUseCase(locator()));

  locator.registerLazySingleton(() => GameController());
}
