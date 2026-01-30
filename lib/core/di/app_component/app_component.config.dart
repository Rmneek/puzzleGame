// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:word_puzzle/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart'
    as _i345;
import 'package:word_puzzle/core/utils/helpers/app_flavor_helper/app_flavors_helper.dart'
    as _i1011;
import 'package:word_puzzle/core/utils/helpers/connectivity_helper/connectivity_helper/connectivity_checker_helper.dart'
    as _i901;
import 'package:word_puzzle/core/utils/helpers/http_strategy_helper/http_request_context.dart'
    as _i229;
import 'package:word_puzzle/core/utils/helpers/responsive_ui_helper/responsive_config.dart'
    as _i687;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i901.ConnectivityCheckerHelper>(
      () => _i901.ConnectivityCheckerHelper(),
    );
    gh.singleton<_i687.ResponsiveUiConfig>(() => _i687.ResponsiveUiConfig());
    gh.singleton<_i1011.AppFlavorsHelper>(() => _i1011.AppFlavorsHelper());
    gh.singleton<_i345.AppConfigurations>(() => _i345.AppConfigurations());
    gh.factory<_i229.HttpRequestContext>(
      () => _i229.HttpRequestContext(gh<_i901.ConnectivityCheckerHelper>()),
    );
    return this;
  }
}
