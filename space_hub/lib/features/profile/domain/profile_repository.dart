
import 'package:dio/dio.dart';
import 'package:space_hub/core/exceptions.dart';
import 'package:space_hub/features/profile/data/profile_api.dart';

class ProfileRepository {
  ProfileRepository(this._api);

  final ProfileApi _api;

  Future<String> test() async {
    try {
      final link = await _api.test();
      return link;
    } on DioException catch (e) {
      throw mapDioToAppException(e);
    } catch (e) {
      throw const AppUnknownException();
    }
  }
}
