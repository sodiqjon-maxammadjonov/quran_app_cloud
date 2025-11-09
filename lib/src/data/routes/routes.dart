import 'package:quran_app_cloud/src/view/main/main_screen.dart';

import '../library/library.dart';

class RouteNames {
  static const String main = '/';
  static const String home = '/home';

}

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.main,
  routes: [
    GoRoute(
      path: RouteNames.main,
      name: 'main',
      pageBuilder: (context, state) => const CupertinoPage(child: MainScreen()),
    ),

    GoRoute(
      path: RouteNames.home,
      name: 'home',
      pageBuilder: (context, state) => const CupertinoPage(child: Home()),
    )
  ],
);
