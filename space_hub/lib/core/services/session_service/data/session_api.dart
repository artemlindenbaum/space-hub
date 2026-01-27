import 'package:dio/dio.dart';
import 'package:space_hub/core/const/typedefs.dart';
import 'package:space_hub/core/utills.dart';

class SessionApi {
  SessionApi(this._apiClient, this._refreshClient);
  final Dio _apiClient;
  final Dio _refreshClient;

  Future<Tokens> authorize() async {
    final response = await _apiClient.post(
      '/',
      options: options(authRequired: false),
    );
    return (
      accessToken: response.data['data']['accessToken'] as String,
      refreshToken: response.data['data']['refreshToken'] as String,
    );
  }

  Future<Tokens> refreshTokens({required String refreshToken}) async {
    final response = await _refreshClient.post(
      'auth/refresh-token',
      data: {'refreshToken': refreshToken},
    );
    return (
      accessToken: response.data['data']['accessToken'] as String,
      refreshToken: response.data['data']['refreshToken'] as String,
    );
  }

  Future<void> logOut() =>
      _apiClient.delete('auth/session', options: options(authRequired: true));

  Future<void> deleteUser() =>
      _apiClient.delete('auth/account', options: options(authRequired: true));
}
