import 'package:flutter/foundation.dart' show PlatformDispatcher;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:l/l.dart';
import 'package:space_hub/app/app.dart';
import 'package:space_hub/app/initialize_dependencies.dart';

Future<void> $initializeApp({
  void Function(String progress, String message)? onProgress,
  void Function(/* Dependencies dependencies */)? onSuccess,
  void Function(Object error, StackTrace stackTrace)? onError,
}) async {
  // Defer the first frame until everything is initialized
  // and the app is ready to be displayed.
  final binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  try {
    // Handle errors that occur in the app
    // and send them as breadcrumbs to Sentry.
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      l.e('Top level error: $error', stackTrace);
      return true;
    };

    // Initialize application step by step
    final dependencies = await $initializeDependencies(onProgress: onProgress);

    Future<void> appRunner() async {
      // Allow the first frame to be displayed after the app is initialized.
      SchedulerBinding.instance.addPostFrameCallback((_) {
        binding.allowFirstFrame();
        onSuccess?.call();
      });

      runApp(dependencies.inject(child: const App()));
    }

    await appRunner();
  } on Object catch (error, stackTrace) {
    onError?.call(error, stackTrace);
    binding.allowFirstFrame();
    runApp($AppError(error: error, stackTrace: stackTrace));
  }
}

class $AppError extends StatelessWidget {
  const $AppError({required this.error, required this.stackTrace, super.key});
  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Initialization Error')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'An error occurred during app initialization:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  error.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                Text(
                  stackTrace.toString(),
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
