import 'package:clean_architecture/core/utils/constants/app_constants.dart';

class EnvironmentConfig {
  static const String buildVariant = String.fromEnvironment(
    'BUILD_VARIANT',
    defaultValue: devEnvironmentString,
  );
}
