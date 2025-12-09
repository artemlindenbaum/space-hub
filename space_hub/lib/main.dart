import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:l/l.dart';
import 'package:space_hub/app/app.dart';
import 'package:space_hub/app/app_bloc_observer.dart';
import 'package:space_hub/app/itinialization.dart';
import 'package:space_hub/core/logger.dart';

void main() => l.capture<void>(
  () => runZonedGuarded<void>(
    () async {
      Bloc.observer = AppBlocObserver();

      await $initializeApp(
        onProgress: (progress, message) {
          l.i('[$progress] $message');
        },
        onSuccess: () {
          l.i('App initialized successfully');
        },
        onError: (error, stackTrace) {
          l.e('Initialization error: $error', stackTrace);
        },
      );
      FlutterNativeSplash.remove();
      runApp(const App());
    },
    (e, stack) {
      l.e('Uncaught zone error: $e', stack);
    },
  ),
  const LogOptions(
    printColors: false,
    output: LogOutput.print,
    overrideOutput: $customFormatter,
  ),
);
