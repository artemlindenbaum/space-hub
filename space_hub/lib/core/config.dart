import 'package:l/l.dart';

/// Application configuration from compile-time environment variables
/// Pass variables via: flutter run --dart-define-from-file=.env.dev
abstract class Config {
  // Environment
  static const env = String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');

  // API Configuration
  static const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://api-dev.truxway.ru/api/',
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
  static bool get isDev => env == 'dev';
  // static bool get isProd => env == 'prod';

  // Print config (for debugging)
  static void logConfig() {
    // ignore: avoid_print
    l.i('''\n
╔════════════════════════════════════════╗
║         App Configuration              ║
╠════════════════════════════════════════╣
║ Environment: $env
║ Base URL: $baseUrl
║ Log Config Enabled: $configLogEnabled
║ Some Feature Flag: $someFeatureFlag
╚════════════════════════════════════════╝
    ''');
  }
}
