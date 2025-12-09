import 'package:l/l.dart';

/// Application configuration from compile-time environment variables
/// Pass variables via: flutter run --dart-define-from-file=.env.dev
abstract class AppConfig {
  // Environment
  static const environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'dev',
  );

  // API Configuration
  static const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://dev-api.example.com',
  );

  static const configLogEnabled = bool.fromEnvironment(
    'CONFIG_LOG_ENABLED',
    defaultValue: true,
  );

  // Feature Flags
  static const someFeatureFlag = bool.fromEnvironment(
    'SOME_FEATURE_FLAG',
    defaultValue: true,
  );

  // Helpers
  static bool get isDev => environment == 'dev';
  static bool get isProd => environment == 'prod';

  // Print config (for debugging)
  static void logConfig() {
    // ignore: avoid_print
    l.i('''\n
╔════════════════════════════════════════╗
║         App Configuration              ║
╠════════════════════════════════════════╣
║ Environment: $environment
║ Base URL: $baseUrl
║ Log Config Enabled: $configLogEnabled
║ Some Feature Flag: $someFeatureFlag
╚════════════════════════════════════════╝
    ''');
  }
}
