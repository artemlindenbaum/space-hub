import 'package:dio/dio.dart';
import 'package:space_hub/core/exceptions.dart';
import 'package:space_hub/features/auth/data/auth_api.dart';

class AuthRepository {
  AuthRepository(this._api);

  final AuthApi _api;

  Future<String> login(String email, String password) async {
    try {
      final token = await _api.login(email, password);
      return token;
    } on DioException catch (e) {
      throw mapDioToAppException(e);
    } catch (e) {
      throw const AppUnknownException();
    }
  }

  Future<String> register(String email, String password) async {
    try {
      final token = await _api.register(email, password);
      return token;
    } on DioException catch (e) {
      throw mapDioToAppException(e);
    } catch (e) {
      throw const AppUnknownException();
    }
  }

  Future<void> logout() async {
    try {
      await _api.logout();
    } on DioException catch (e) {
      throw mapDioToAppException(e);
    } catch (e) {
      throw const AppUnknownException();
    }
  }

  Future<void> loadUser() async {
    try {
      // TODO: Implement load user logic
    } on DioException catch (e) {
      throw mapDioToAppException(e);
    } catch (e) {
      throw const AppUnknownException();
    }
  }
}
