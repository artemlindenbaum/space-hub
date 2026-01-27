import 'dart:async';

import 'package:dio/dio.dart';
import 'package:l/l.dart';

class RefreshInterceptor extends Interceptor {
  RefreshInterceptor(this.accessToken);

  final String? accessToken;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    _logRequest(options, accessToken);
    options.headers['Authorization'] = 'Bearer $accessToken';
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    _logError(err);
    handler.next(err);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    _logResponse(response);
    handler.next(response);
  }
}

void _logRequest(RequestOptions options, String? token) {
  l
    ..vvvvvv('--------------')
    ..vvvvvv('REQUEST: ${options.method}:${options.path}')
    ..vvvvvv('Data: ${options.data}')
    ..vvvvvv('Query Parameters: ${options.queryParameters}')
    ..vvvvvv('--------------');
}

void _logError(DioException err) {
  l
    ..vvvvvv('--------------')
    ..vvvvvv(
      'RESPONSE ERROR: ${err.requestOptions.method}:${err.requestOptions.path}',
    )
    ..vvvvvv('Response Data: ${err.response?.data}')
    ..vvvvvv('Status Code: ${err.response?.statusCode}')
    ..vvvvvv('Status Message: ${err.response?.statusMessage}')
    ..vvvvvv('--------------');
}

void _logResponse(Response<dynamic> response) {
  l
    ..vvvvvv('--------------')
    ..vvvvvv('RESPONSE: ${response.requestOptions.path}')
    ..vvvvvv('Status Code: ${response.statusCode}')
    ..vvvvvv('Data: ${response.data}')
    ..vvvvvv('--------------');
}
