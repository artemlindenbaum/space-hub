import 'package:dio/dio.dart';
import 'package:space_hub/core/utills.dart';

class ProfileApi {
  ProfileApi(this._apiClient);

  final Dio _apiClient;

  Future<String> test() async {
    final response = await _apiClient.get(
      '/',
      options: options(authRequired: true),
    );
    return response.data['telegramChannelUrl'];
  }
}
