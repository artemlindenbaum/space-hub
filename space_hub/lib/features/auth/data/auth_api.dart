import 'package:dio/dio.dart';
import 'package:space_hub/core/utills.dart';

class AuthApi {
  AuthApi(this._apiClient);

  final Dio _apiClient;

  Future<String> login(String email, String password) async {
    final response = await _apiClient.post(
      '/auth/login',
      data: {'email': email, 'password': password},
      options: options(authRequired: false),
    );
    return response.data['token'];
  }

  Future<String> register(String email, String password) async {
    final response = await _apiClient.post(
      '/auth/register',
      data: {'email': email, 'password': password},
      options: options(authRequired: false),
    );
    return response.data['token'];
  }

  Future<void> logout() async {
    await _apiClient.post('/auth/logout', options: options(authRequired: true));
  }
}
