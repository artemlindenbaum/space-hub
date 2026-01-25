import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:space_hub/app/router.dart';
import 'package:space_hub/core/extensions.dart';
import 'package:space_hub/core/localization/generated/l10n.dart';
import 'package:space_hub/core/services/session_service/notifier/session_state.dart';
import 'package:space_hub/core/theme/ui_kit_theme.dart';
import 'package:space_hub/features/auth/data/auth_api.dart';
import 'package:space_hub/features/auth/domain/auth_repository.dart';
import 'package:space_hub/features/auth/presentation/bloc/auth_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AppRouter? _router;
  SessionState? _prevSessionState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final sessionService = context.get.sessionService;

    _router ??= AppRouter(context.get.sessionService);

    if (_prevSessionState == null) {
      _prevSessionState = sessionService.state;
      sessionService.addListener(_onSessionChanged);
    }
  }

  void _onSessionChanged() {
    final sessionService = context.get.sessionService;
    final next = sessionService.state;
    final prev = _prevSessionState;

    if (prev?.authStatus != next.authStatus &&
        next.authStatus == AuthStatus.unauthorized) {
      // тут ресетим блоки если нужно
    }

    _prevSessionState = next;
  }

  @override
  void dispose() {
    context.get.sessionService.removeListener(_onSessionChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
            AuthCubit(AuthRepository(AuthApi(context.get.apiClient))),
      ),
    ],
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: MaterialApp.router(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        routerConfig: _router!.router,
      ),
    ),
  );
}
