import 'package:dio/dio.dart';
import 'package:space_hub/core/utills.dart';

class DashboardApi {
  DashboardApi(this._apiClient);

  final Dio _apiClient;

  Future<Map<String, dynamic>> getData() async {
    final response = await _apiClient.get(
      '/dashboard',
      options: options(authRequired: true),
    );
    return response.data;
  }

  Future<void> refresh() async {
    await _apiClient.post(
      '/dashboard/refresh',
      options: options(authRequired: true),
    );
  }
}
