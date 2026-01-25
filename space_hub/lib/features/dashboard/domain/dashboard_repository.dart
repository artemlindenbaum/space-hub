import 'package:dio/dio.dart';
import 'package:space_hub/core/exceptions.dart';
import 'package:space_hub/features/dashboard/data/dashboard_api.dart';

class DashboardRepository {
  DashboardRepository(this._api);

  final DashboardApi _api;

  Future<Map<String, dynamic>> getData() async {
    try {
      final data = await _api.getData();
      return data;
    } on DioException catch (e) {
      throw mapDioToAppException(e);
    } catch (e) {
      throw const AppUnknownException();
    }
  }

  Future<void> refresh() async {
    try {
      await _api.refresh();
    } on DioException catch (e) {
      throw mapDioToAppException(e);
    } catch (e) {
      throw const AppUnknownException();
    }
  }

  Future<void> loadData() async {
    try {
      await getData();
    } on DioException catch (e) {
      throw mapDioToAppException(e);
    } catch (e) {
      throw const AppUnknownException();
    }
  }
}
