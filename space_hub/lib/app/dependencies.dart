import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_hub/core/config.dart';
import 'package:space_hub/core/const/storage_keys.dart';
import 'package:space_hub/core/network/refresh_interceptor.dart';
import 'package:space_hub/core/network/session_interceptor.dart';
import 'package:space_hub/core/services/session_service/data/session_api.dart';
import 'package:space_hub/core/services/session_service/domain/session_repository.dart';
import 'package:space_hub/core/services/session_service/notifier/session_service.dart';
import 'package:space_hub/core/services/token_service.dart';

class Dependencies {
  Dependencies({
    required this.sharedPreferences,
    required this.secureStorage,
    required this.apiClient,
    required this.refreshClient,
    required this.tokenService,
    required this.sessionService,
  });

  /// The state from the closest instance of this class.
  factory Dependencies.of(BuildContext context) =>
      InheritedDependencies.of(context);

  /// Inject dependencies to the widget tree.
  Widget inject({required Widget child, Key? key}) =>
      InheritedDependencies(dependencies: this, key: key, child: child);

  final SharedPreferences sharedPreferences;

  final FlutterSecureStorage secureStorage;

  final Dio apiClient;

  final Dio refreshClient;

  final TokenService tokenService;

  final SessionService sessionService;

  @override
  String toString() => 'Dependencies{}';

  static Future<Dependencies> init(
    void Function(String progress, String message)? onProgress,
  ) => _initializeDependencies(onProgress);
}

/// Fake Dependencies
@visibleForTesting
class FakeDependencies extends Dependencies {
  FakeDependencies({
    required super.sharedPreferences,
    required super.secureStorage,
    required super.apiClient,
    required super.refreshClient,
    required super.tokenService,
    required super.sessionService,
  });

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

  onProgress?.call('2', 'Loading storage preferences...');
  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  // await sharedPreferences.clear();
  // await secureStorage.deleteAll();

  onProgress?.call('3', 'Setting up API client...');
  final apiClient = Dio(BaseOptions(baseUrl: Config.baseUrl));
  final refreshClient = Dio(BaseOptions(baseUrl: Config.baseUrl));

  onProgress?.call('5', 'Setting up TokenService...');
  final sessionMode = sharedPreferences.getBool(StorageKeys.rememberMe) == true
      ? SessionMode.persistent
      : SessionMode.temporary;

  final tokenService = TokenService(secureStorage, sessionMode);
  await tokenService.init();

  onProgress?.call('8', 'Setting up SessionService...');

  final sessionService = SessionService(
    SessionRepository(
     SessionApi(apiClient, refreshClient),
      tokenService,
    ),
  );

  onProgress?.call('9', 'adding interceptors...');
  // final adapter = apiClient.httpClientAdapter;

  // apiClient.httpClientAdapter = createFailingAdapter(adapter, {
  //   'GET auth/me': (o) => _unauthorized(o),
  // });

  // refreshClient.httpClientAdapter = createFailingAdapter(adapter, {
  //   'POST auth/refresh-token': (o) => _unauthorized(o),
  // });

  apiClient.interceptors.addAll([
    SessionInterceptor(tokenService, sessionService, apiClient),
  ]);

  refreshClient.interceptors.addAll([
    RefreshInterceptor(tokenService.accessToken),
  ]);

  onProgress?.call('10', 'initializing session...');
  await sessionService.initializeSession();

  onProgress?.call('11', 'dependencies initialized');

  final dependencies = Dependencies(
    sharedPreferences: sharedPreferences,
    secureStorage: secureStorage,
    apiClient: apiClient,
    refreshClient: refreshClient,
    tokenService: tokenService,
    sessionService: sessionService,
  );

  return dependencies;
}

// --------- Примеры DioException для тестов ---------
// ignore: unused_element
DioException _badRequest(RequestOptions options) => DioException(
  requestOptions: options,
  type: DioExceptionType.badResponse,
  response: Response(requestOptions: options, statusCode: 400),
);

// ignore: unused_element
DioException _unauthorized(RequestOptions options) => DioException(
  requestOptions: options,
  type: DioExceptionType.badResponse,
  response: Response(requestOptions: options, statusCode: 401),
);

// ignore: unused_element
DioException _forbidden(RequestOptions options) => DioException(
  requestOptions: options,
  type: DioExceptionType.badResponse,
  response: Response(requestOptions: options, statusCode: 403),
);

// ignore: unused_element
DioException _notFound(RequestOptions options) => DioException(
  requestOptions: options,
  type: DioExceptionType.badResponse,
  response: Response(requestOptions: options, statusCode: 404),
);

// ignore: unused_element
DioException _conflictError(RequestOptions options) => DioException(
  requestOptions: options,
  type: DioExceptionType.badResponse,
  response: Response(requestOptions: options, statusCode: 409),
);

// ignore: unused_element
DioException _unprocessableEntityError(RequestOptions options) => DioException(
  requestOptions: options,
  type: DioExceptionType.badResponse,
  response: Response(requestOptions: options, statusCode: 422),
);
