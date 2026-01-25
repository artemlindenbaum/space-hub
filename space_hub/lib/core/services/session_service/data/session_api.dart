import 'package:dio/dio.dart';
import 'package:space_hub/core/const/typedefs.dart';
import 'package:space_hub/core/utills.dart';

class SessionApi {
  SessionApi(this._apiClient);
  final Dio _apiClient;

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
    final response = await _apiClient.post(
      '/',
      data: {'refreshToken': refreshToken},
      options: options(authRequired: true, isRefreshRequest: true),
    );
    return (
      accessToken: response.data['data']['accessToken'] as String,
      refreshToken: response.data['data']['refreshToken'] as String,
    );
  }

  Future<void> logOut() =>
      _apiClient.delete('/', options: options(authRequired: true));

  Future<void> deleteUser() =>
      _apiClient.delete('/', options: options(authRequired: true));
}
