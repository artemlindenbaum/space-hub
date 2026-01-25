import 'package:dio/dio.dart';
import 'package:l/l.dart';
import 'package:space_hub/core/exceptions.dart';
import 'package:space_hub/core/services/session_service/data/session_api.dart';
import 'package:space_hub/core/services/token_service.dart';

class SessionRepository {
  SessionRepository(this._api, this._tokenService);
  final SessionApi _api;
  final TokenService _tokenService;

  // валидация кода
  Future<void> authorize() async {
    try {
      final tokens = await _api.authorize();
      await _tokenService.saveTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );
    } on DioException catch (e) {
      throw mapDioToAppException(e);
    } catch (e) {
      throw const AppUnknownException();
    }
  }

  Future<void> deleteUser() async {
    try {
      await _api.deleteUser();
      await _tokenService.clearTokens();
    } on DioException catch (e) {
      throw mapDioToAppException(e);
    } catch (e) {
      throw const AppUnknownException();
    }
  }

  Future<void> refreshTokens() async {
    if (_tokenService.accessToken == null ||
        _tokenService.refreshToken == null) {
      l.i('No tokens available for refresh');
      throw const AppUnauthorizedException();
    }
    try {
      final tokens = await _api.refreshTokens(
        refreshToken: _tokenService.refreshToken!,
      );
      await _tokenService.saveTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );
    } on AppUnauthorizedException {
      rethrow;
    } on DioException catch (e) {
      throw mapDioToAppException(e);
    } catch (e) {
      l.e('Unknown error during token refresh: $e');
      throw const AppUnknownException();
    }
  }

  Future<void> logOut() async {
    try {
      await _api.logOut();
      await _tokenService.clearTokens();
    } on DioException catch (e) {
      throw mapDioToAppException(e);
    } catch (e) {
      throw const AppUnknownException();
    }
  }
}
