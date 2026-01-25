import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:space_hub/app/app.dart';
import 'package:space_hub/app/dependencies.dart';

Future<void> $initializeApp({
  void Function(String progress, String message)? onProgress,
  void Function(/* Dependencies dependencies */)? onSuccess,
  void Function(Object error, StackTrace stackTrace)? onError,
}) async {
  // сохраняем сплэшскрин до окончания инициализации
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  try {
    // Initialize application step by step
    final dependencies = await Dependencies.init(onProgress);

    FlutterNativeSplash.remove();

    runApp(dependencies.inject(child: const App()));
  } on Object catch (error, st) {
    onError?.call(error, st);
    FlutterNativeSplash.remove();

    runApp(_AppError(error: error, stackTrace: st));
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
