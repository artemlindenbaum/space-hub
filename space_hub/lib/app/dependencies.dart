import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_hub/core/config.dart';
import 'package:space_hub/core/const/storage_keys.dart';
import 'package:space_hub/core/interceptors/token_interceptor.dart';
import 'package:space_hub/core/services/session_service/data/session_api.dart';
import 'package:space_hub/core/services/session_service/domain/session_repository.dart';
import 'package:space_hub/core/services/session_service/notifier/session_service.dart';
import 'package:space_hub/core/services/token_service.dart';

class Dependencies {
  Dependencies();

  /// The state from the closest instance of this class.
  factory Dependencies.of(BuildContext context) =>
      InheritedDependencies.of(context);

  /// Inject dependencies to the widget tree.
  Widget inject({required Widget child, Key? key}) =>
      InheritedDependencies(dependencies: this, key: key, child: child);

  // Shared preferences
  late final SharedPreferences sharedPreferences;

  late final FlutterSecureStorage secureStorage;

  late final Dio apiClient;

  late final TokenService tokenService;

  late final SessionNotifier sessionService;

  @override
  String toString() => 'Dependencies{}';

  static Future<Dependencies> init(
    void Function(String progress, String message)? onProgress,
  ) => _initializeDependencies(onProgress);
}

/// Fake Dependencies
@visibleForTesting
class FakeDependencies extends Dependencies {
  FakeDependencies();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    // ... implement fake dependencies
    throw UnimplementedError();
  }
}

class InheritedDependencies extends InheritedWidget {
  /// {@macro inherited_dependencies}
  const InheritedDependencies({
    required this.dependencies,
    required super.child,
    super.key,
  });

  final Dependencies dependencies;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  static Dependencies? maybeOf(BuildContext context) =>
      (context
                  .getElementForInheritedWidgetOfExactType<
                    InheritedDependencies
                  >()
                  ?.widget
              as InheritedDependencies?)
          ?.dependencies;

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
    'Out of scope, not found inherited widget '
        'a InheritedDependencies of the exact type',
    'out_of_scope',
  );

  /// The state from the closest instance of this class
  /// that encloses the given context.
  static Dependencies of(BuildContext context) =>
      maybeOf(context) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(covariant InheritedDependencies oldWidget) => false;
}

/// Initializes the app and returns a [Dependencies] object
Future<Dependencies> _initializeDependencies(
  void Function(String progress, String message)? onProgress,
) async {
  if (Config.configLogEnabled) {
    Config.logConfig();
  }

  onProgress?.call('1', 'Initializing dependencies...');
  final dependencies = Dependencies();

  onProgress?.call('2', 'Loading storage preferences...');
  dependencies.sharedPreferences = await SharedPreferences.getInstance();
  dependencies.secureStorage = const FlutterSecureStorage();
  // await dependencies.sharedPreferences.clear();
  // await dependencies.secureStorage.deleteAll();

  onProgress?.call('3', 'Setting up API client...');
  dependencies.apiClient = Dio(BaseOptions(baseUrl: Config.baseUrl));

  onProgress?.call('5', 'Setting up TokenService...');
  final sessionMode =
      dependencies.sharedPreferences.getBool(StorageKeys.rememberMe) == true
      ? SessionMode.persistent
      : SessionMode.temporary;

  dependencies.tokenService = TokenService(
    dependencies.secureStorage,
    sessionMode,
  );
  await dependencies.tokenService.init();

  onProgress?.call('6', 'Setting up SessionNotifier...');

  dependencies.sessionService = SessionNotifier(
    SessionRepository(
      SessionApi(dependencies.apiClient),
      dependencies.tokenService,
    ),
  );

  onProgress?.call('7', 'adding interceptors...');
  dependencies.apiClient.interceptors.addAll([
    TokenInterceptor(
      dependencies.tokenService,
      dependencies.sessionService,
      dependencies.apiClient,
    ),
  ]);

  onProgress?.call('8', 'initializing session...');

  await dependencies.sessionService.initializeSession();

  onProgress?.call('9', 'dependencies initialized');

  return dependencies;
}
