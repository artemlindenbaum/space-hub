/// Keys for SharedPreferences storage
abstract class StorageKeys {
  // Auth
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String isAuthorized = 'is_authorized';

  // User
  static const String userName = 'user_name';
  static const String userEmail = 'user_email';
  static const String userPhone = 'user_phone';

  // App Settings
  static const String locale = 'locale';
  static const String themeMode = 'theme_mode';
  static const String isFirstLaunch = 'is_first_launch';

  // Onboarding
  static const String onboardingCompleted = 'onboarding_completed';
  static const String termsAccepted = 'terms_accepted';
}
