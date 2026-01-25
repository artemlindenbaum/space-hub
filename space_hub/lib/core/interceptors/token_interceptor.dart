import 'dart:async';

import 'package:dio/dio.dart';
import 'package:l/l.dart';
import 'package:space_hub/core/services/session_service/notifier/session_service.dart';
import 'package:space_hub/core/services/token_service.dart';


class NoTokens {}

class BadTokens {}

class TokenInterceptor extends Interceptor {
  TokenInterceptor(this._tokenService, this._sessionService, this._apiClient);

  final TokenService _tokenService;
  final SessionNotifier _sessionService;
  final Dio _apiClient;

  Completer<void>? _refreshing;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {

    if (_refreshing != null) await _refreshing!.future;

    final authRequired = options.extra['authRequired'] ?? false;

    if (options.extra['log'] ?? false) {
      _logRequest(options, _tokenService);
    }

    if (authRequired) {
      final accessToken = _tokenService.accessToken;

      if (accessToken == null) {
        handler.reject(
          DioException(error: NoTokens(), requestOptions: options),
        );
        return;
      }
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {

    _logError(err);
    final requestOptions = err.requestOptions;
    final authRequired = requestOptions.extra['authRequired'] == true;

    if (err.response?.statusCode != 401 || !authRequired) {
      handler.next(err);
      return;
    }

    if (requestOptions.extra['isRefreshRequest'] == true) {
      handler.reject(
        DioException(error: BadTokens(), requestOptions: requestOptions),
      );
      return;
    }

    if (requestOptions.extra['retried'] == true) {
      handler.reject(
        DioException(error: BadTokens(), requestOptions: requestOptions),
      );
      return;
    }

    try {
      if (_refreshing == null) {
        _refreshing = Completer<void>();
        try {
          await _sessionService.refreshTokens();
          _refreshing!.complete();
          _refreshing = null;
        } catch (e, st) {
          _refreshing!.completeError(e, st);
          _refreshing = null;
          rethrow;
        }
      } else {
        await _refreshing!.future;
      }

      final newToken = _tokenService.accessToken;

      if (newToken == null) {
        handler.reject(
          DioException(error: BadTokens(), requestOptions: requestOptions),
        );
        return;
      }

      requestOptions.extra['retried'] = true;
      requestOptions.headers['Authorization'] = 'Bearer $newToken';

      final response = await _apiClient.fetch(requestOptions);
      handler.resolve(response);
      return;
    } catch (e) {
      handler.reject(
        DioException(error: BadTokens(), requestOptions: requestOptions),
      );
      return;
    }
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.requestOptions.extra['log'] != false) {
      _logResponse(response);
    }
    handler.next(response);
  }
}

void _logRequest(RequestOptions options, TokenService? tokenService) {
  l
    ..vvvvvv('--------------')
    ..vvvvvv('REQUEST: ${options.method}:${options.path}')
    ..vvvvvv('Bearer ${tokenService?.accessToken}')
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
