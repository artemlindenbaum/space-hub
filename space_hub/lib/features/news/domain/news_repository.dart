import 'package:dio/dio.dart';
import 'package:space_hub/core/exceptions.dart';
import 'package:space_hub/features/news/data/news_api.dart';

class NewsRepository {
  NewsRepository(this._api);

  final NewsApi _api;

  Future<List<dynamic>> getNews() async {
    try {
      final news = await _api.getNews();
      return news;
    } on DioException catch (e) {
      throw mapDioToAppException(e);
    } catch (e) {
      throw const AppUnknownException();
    }
  }

  Future<Map<String, dynamic>> getNewsDetails(String newsId) async {
    try {
      final details = await _api.getNewsDetails(newsId);
      return details;
    } on DioException catch (e) {
      throw mapDioToAppException(e);
    } catch (e) {
      throw const AppUnknownException();
    }
  }

  Future<List<dynamic>> searchNews(String query) async {
    try {
      final results = await _api.searchNews(query);
      return results;
    } on DioException catch (e) {
      throw mapDioToAppException(e);
    } catch (e) {
      throw const AppUnknownException();
    }
  }

  Future<void> loadNews() async {
    try {
      await getNews();
    } on DioException catch (e) {
      throw mapDioToAppException(e);
    } catch (e) {
      throw const AppUnknownException();
    }
  }
}
