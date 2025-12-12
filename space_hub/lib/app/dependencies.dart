import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_hub/core/config.dart';


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

  late final Dio dio;

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

  onProgress?.call('2', 'Loading shared preferences...');
  dependencies.sharedPreferences = await SharedPreferences.getInstance();

  onProgress?.call('3', 'Setting up API client...');
  dependencies.dio = Dio(BaseOptions(baseUrl: Config.baseUrl));

  onProgress?.call('4', 'dependencies initialized');

  return dependencies;
}
