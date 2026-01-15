import 'package:auto_route/auto_route.dart';
part 'auto_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[];
}
