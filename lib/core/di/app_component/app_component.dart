import 'package:clean_architecture/core/di/app_component/app_component.config.dart';
import 'package:clean_architecture/features/data/repositories/word_game_repository_impl.dart';
import 'package:clean_architecture/features/domain/repositories/word_game_repository.dart';
import 'package:clean_architecture/features/domain/usecases/check_word_usecase.dart';
import 'package:clean_architecture/features/presentation/controllers/game_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt locator = GetIt.I;

@InjectableInit(preferRelativeImports: false)
Future<void> initAppComponentLocator() async => locator.init();
void setupLocator() {
  locator.registerLazySingleton<WordGameRepository>(
    () => WordGameRepositoryImpl(),
  );
  locator.registerLazySingleton(() => CheckWordUseCase(locator()));

  locator.registerLazySingleton(() => GameController());
}
