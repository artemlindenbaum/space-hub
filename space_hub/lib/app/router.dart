import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:space_hub/app/app_shell.dart';
import 'package:space_hub/core/services/session_service/notifier/session_service.dart';
import 'package:space_hub/core/theme/extensions.dart';
import 'package:space_hub/features/auth/presentation/ui/login_screen.dart';
import 'package:space_hub/features/auth/presentation/ui/registration_screen.dart';
import 'package:space_hub/features/auth/presentation/ui/welcome_screen.dart';
import 'package:space_hub/features/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:space_hub/features/news/presentation/detailed_ui/detailed_screen.dart';
import 'package:space_hub/features/news/presentation/feed_ui/feed_screen.dart';
import 'package:space_hub/features/news/presentation/search_ui/search_screen.dart';
import 'package:space_hub/features/profile/presentation/ui/profile_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _dashboardNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'dashboard',
);
final _feedNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'feed');
final _searchNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'search');
final _profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

abstract final class Seg {
  static const welcome = 'welcome';
  static const registration = 'registration';
  static const auth = 'auth';

  static const dashboard = 'dashboard';
  static const feed = 'feed';
  static const search = 'search';
  static const profile = 'profile';

  static const detailed = 'detailed';
}

enum Routes {
  welcome,
  registration,
  auth,

  dashboard,
  feed,
  search,
  profile,

  detailed,
}

class AppRouter {
  AppRouter(SessionNotifier sessionService)
    : router = _createRouter(sessionService);

  final GoRouter router;

  static GoRouter _createRouter(SessionNotifier sessionService) => GoRouter(
    initialLocation: '/${Seg.welcome}',
    refreshListenable: sessionService,
    redirect: (context, state) {
      return null;
    },
    navigatorKey: _rootNavigatorKey,
    routes: [
      fadeTransitionRoute(
        name: Routes.welcome.name,
        path: '/${Seg.welcome}',
        builder: (context, state) => const WelcomeScreen(),
        routes: [
          fadeTransitionRoute(
            name: Routes.registration.name,
            path: Seg.registration,
            builder: (context, state) => const RegistrationScreen(),
          ),
          fadeTransitionRoute(
            name: Routes.auth.name,
            path: Seg.auth,
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
                name: Routes.dashboard.name,
                path: '/${Seg.dashboard}',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _feedNavigatorKey,
            routes: [
              fadeTransitionRoute(
                name: Routes.feed.name,
                path: '/${Seg.feed}',
                builder: (context, state) => FeedScreen(
                  onNewsTap: (id) =>
                      context.pushNamed('${Routes.detailed.name}/$id'),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _searchNavigatorKey,
            routes: [
              fadeTransitionRoute(
                name: Routes.search.name,
                path: '/${Seg.search}',
                builder: (context, state) => SearchScreen(
                  onNewsTap: (id) =>
                      context.pushNamed('${Routes.detailed.name}/$id'),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              fadeTransitionRoute(
                name: Routes.profile.name,
                path: '/${Seg.profile}',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      fadeTransitionRoute(
        name: Routes.detailed.name,
        path: '/${Seg.detailed}/:id', // /detailed/:id
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return DetailedScreen(id);
        },
      ),
    ],
  );
}

GoRoute fadeTransitionRoute({
  required String path,
  required String name,
  required Widget Function(BuildContext, GoRouterState) builder,
  List<GoRoute> routes = const [],
}) {
  return GoRoute(
    path: path,
    name: name,
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
