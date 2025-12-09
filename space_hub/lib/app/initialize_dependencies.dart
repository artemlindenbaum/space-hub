import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_hub/app/dependencies.dart';
import 'package:space_hub/core/config.dart';

/// Initializes the app and returns a [Dependencies] object
Future<Dependencies> $initializeDependencies({
  void Function(String progress, String message)? onProgress,
}) async {
  if (AppConfig.configLogEnabled) {
    AppConfig.logConfig();
  }

  onProgress?.call('...', 'Initializing dependencies...');
  final dependencies = Dependencies();

  onProgress?.call('1/2', 'Loading shared preferences...');
  dependencies.sharedPreferences = await SharedPreferences.getInstance();

  onProgress?.call('2/2', 'Setting up API client...');
  dependencies.dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));

  onProgress?.call(':2/2', 'Dependencies initialized');

  return dependencies;
}
