import 'package:go_router/go_router.dart';
import 'package:space_hub/app/app_shell.dart';
import 'package:space_hub/features/auth/presentation/ui/auth_screen.dart';
import 'package:space_hub/features/home/presentation/ui/home_screen.dart';
import 'package:ui_kit/ui_kit.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');

enum Routes {
  registration('/registration'),
  home('/home');

  const Routes(this.path);

  final String path;
}

final router = GoRouter(
  initialLocation: Routes.registration.path,
  navigatorKey: _rootNavigatorKey,
  routes: [
    fadeTransitionRoute(
      path: Routes.registration.path,
      builder: (context, state) => const AuthScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell), //Scaffold
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            fadeTransitionRoute(
              path: Routes.home.path,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

GoRoute fadeTransitionRoute({
  required String path,
  required Widget Function(BuildContext, GoRouterState) builder,
  List<GoRoute> routes = const [],
}) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: builder(context, state),
      transitionDuration: const Duration(milliseconds: 150),
      reverseTransitionDuration: const Duration(milliseconds: 150),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Stack(
          children: [
            FadeTransition(
              opacity: animation,
              child: Container(color: context.style.backgroundPrimary),
            ),
            FadeTransition(opacity: animation, child: child),
          ],
        );
      },
    ),
    routes: routes,
  );
}
