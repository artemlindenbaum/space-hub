import 'package:flutter/foundation.dart' show PlatformDispatcher;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:l/l.dart';
import 'package:space_hub/app/app.dart';
import 'package:space_hub/app/dependencies.dart';

Future<void> $initializeApp({
  void Function(String progress, String message)? onProgress,
  void Function(/* Dependencies dependencies */)? onSuccess,
  void Function(Object error, StackTrace stackTrace)? onError,
}) async {
  // Defer the first frame until everything is initialized
  // and the app is ready to be displayed.
  final binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();

  try {
    // Handle errors that occur in the app
    // and send them as breadcrumbs to Sentry.
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      l.e('Top level error: $error', stackTrace);
      return true;
    };

    // Initialize application step by step
    final dependencies = await Dependencies.init(onProgress);

    binding.allowFirstFrame();
    
    runApp(dependencies.inject(child: const App()));
  } on Object catch (error, stackTrace) {
    onError?.call(error, stackTrace);
    binding.allowFirstFrame();

    runApp(_AppError(error: error, stackTrace: stackTrace));
  }
}

class _AppError extends StatelessWidget {
  const _AppError({required this.error, required this.stackTrace});
  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Initialization Error')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              const Text(
                'An error occurred during app initialization:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(error.toString(), style: const TextStyle(color: Colors.red)),
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
