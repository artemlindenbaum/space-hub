import 'package:go_router/go_router.dart';
import 'package:space_hub/app/app_shell.dart';
import 'package:space_hub/features/auth/presentation/ui/login_screen.dart';
import 'package:space_hub/features/auth/presentation/ui/registration_screen.dart';
import 'package:space_hub/features/auth/presentation/ui/welcome_screen.dart';
import 'package:space_hub/features/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:space_hub/features/news/presentation/detailed_ui/detailed_screen.dart';
import 'package:space_hub/features/news/presentation/feed_ui/feed_screen.dart';
import 'package:space_hub/features/news/presentation/search_ui/search_screen.dart';
import 'package:space_hub/features/profile/presentation/ui/profile_screen.dart';
import 'package:ui_kit/ui_kit.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _dashboardNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'dashboard',
);
final _feedNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'feed');
final _searchNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'search');
final _profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

enum Routes {
  welcome('/welcome'),
  registration('/registration'),
  auth('/auth'),

  dashboard('/dashboard'),
  feed('/feed'),
  search('/search'),
  profile('/profile'),

  detailed('/detailed');

  const Routes(this.path);

  final String path;
}

final router = GoRouter(
  initialLocation: Routes.welcome.path,
  navigatorKey: _rootNavigatorKey,
  routes: [
    fadeTransitionRoute(
      path: Routes.welcome.path,
      builder: (context, state) => const WelcomeScreen(),
      routes: [
        fadeTransitionRoute(
          path: Routes.registration.path,
          builder: (context, state) => const RegistrationScreen(),
        ),
        fadeTransitionRoute(
          path: Routes.auth.path,
          builder: (context, state) => const LoginScreen(),
        ),
      ],
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell), //Scaffold
      branches: [
        StatefulShellBranch(
          navigatorKey: _dashboardNavigatorKey,
          routes: [
            fadeTransitionRoute(
              path: Routes.dashboard.path,
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _feedNavigatorKey,
          routes: [
            fadeTransitionRoute(
              path: Routes.feed.path,
              builder: (context, state) => FeedScreen(
                onNewsTap: (id) => context.push('${Routes.detailed.path}/$id'),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _searchNavigatorKey,
          routes: [
            fadeTransitionRoute(
              path: Routes.search.path,
              builder: (context, state) => SearchScreen(
                onNewsTap: (id) => context.push('${Routes.detailed.path}/$id'),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _profileNavigatorKey,
          routes: [
            fadeTransitionRoute(
              path: Routes.profile.path,
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    fadeTransitionRoute(
      path: '${Routes.detailed.path}/:id', // /detailed/:id
      builder: (context, state) {
        final id = state.pathParameters['id']!;

        return DetailedScreen(id: id);
      },
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
