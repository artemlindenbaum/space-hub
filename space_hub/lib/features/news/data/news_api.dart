import 'package:dio/dio.dart';
import 'package:space_hub/core/utills.dart';

class NewsApi {
  NewsApi(this._apiClient);

  final Dio _apiClient;

  Future<List<dynamic>> getNews() async {
    final response = await _apiClient.get(
      '/news',
      options: options(authRequired: true),
    );
    return response.data['articles'] ?? [];
  }

  Future<Map<String, dynamic>> getNewsDetails(String newsId) async {
    final response = await _apiClient.get(
      '/news/$newsId',
      options: options(authRequired: true),
    );
    return response.data;
  }

  Future<List<dynamic>> searchNews(String query) async {
    final response = await _apiClient.get(
      '/news/search',
      queryParameters: {'q': query},
      options: options(authRequired: true),
    );
    return response.data['articles'] ?? [];
  }
}
