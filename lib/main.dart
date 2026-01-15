import 'dart:developer';

import 'package:clean_architecture/core/di/app_component/app_component.dart';
import 'package:clean_architecture/core/theme/app_theme.dart';
import 'package:clean_architecture/core/utils/helpers/app_flavor_helper/app_flavors_helper.dart';
import 'package:clean_architecture/core/utils/helpers/app_flavor_helper/environment_config.dart';
import 'package:clean_architecture/features/presentation/controllers/game_controller.dart';
import 'package:clean_architecture/features/presentation/screens/tutorial_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initAppComponentLocator();
  setupLocator();
  final AppFlavorsHelper configService = locator<AppFlavorsHelper>();
  final ProductFlavor? productFlavor = EnvironmentConfig.buildVariant
      .toProductFlavor();
  configService.configure(productFlavor: productFlavor);
  log(' buildVariant = ${EnvironmentConfig.buildVariant}');
  log(' Base URL = ${configService.baseUrl}');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: locator<GameController>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: TutorialPage(),
      ),
    );
  }
}
