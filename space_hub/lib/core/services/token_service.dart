import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:l/l.dart';
import 'package:space_hub/core/const/storage_keys.dart';

enum SessionMode { temporary, persistent }

/// Сервис управления токенами аутентификации.
/// - всегда держит токены в памяти (для текущего запуска)
/// - опционально сохраняет/восстанавливает их через TokenStore (remember me)
class TokenService {
  TokenService(FlutterSecureStorage storage, this._mode)
    : _store = _TokenStore(storage);

  final _TokenStore _store;

  SessionMode _mode;
  String? _accessToken;
  String? _refreshToken;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  SessionMode get mode => _mode;

  Future<void> init() async {
    if (_mode == SessionMode.persistent) {
      _accessToken = await _store.readAccessToken();
      _refreshToken = await _store.readRefreshToken();
    } else {
      // на всякий случай, чтобы не подтянуть старые значения
      _accessToken = null;
      _refreshToken = null;
      await _store.clearTokens();
    }
  }

  /// Основной метод установки токенов после логина/refresh.
  /// - всегда кладёт в память
  /// - при persistent дополнительно сохраняет в store
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;

    if (_mode == SessionMode.persistent) {
      await _store.saveTokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
    }
  }

  Future<void> setMode(SessionMode mode) async {
    if (_mode == mode) return;

    _mode = mode;

    if (_mode == SessionMode.persistent) {
      if (_accessToken != null && _refreshToken != null) {
        await _store.saveTokens(
          accessToken: _accessToken!,
          refreshToken: _refreshToken!,
        );
      }
    } else {
      await _store.clearTokens();
    }
  }

  Future<void> clearTokens() async {
    l.i('Clearing tokens');
    _accessToken = null;
    _refreshToken = null;
    await _store.clearTokens();
  }
}

class _TokenStore {
  _TokenStore(this._storage);

  final FlutterSecureStorage _storage;

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: StorageKeys.accessToken, value: accessToken);
    await _storage.write(key: StorageKeys.refreshToken, value: refreshToken);
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: StorageKeys.accessToken);
    await _storage.delete(key: StorageKeys.refreshToken);
  }

  Future<String?> readAccessToken() async =>
      _storage.read(key: StorageKeys.accessToken);

  Future<String?> readRefreshToken() async =>
      _storage.read(key: StorageKeys.refreshToken);
}
