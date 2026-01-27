import 'dart:async';

import 'package:dio/dio.dart';
import 'package:l/l.dart';
import 'package:space_hub/core/services/session_service/notifier/session_service.dart';
import 'package:space_hub/core/services/token_service.dart';

class SessionInterceptor extends Interceptor {
  SessionInterceptor(this._tokenService, this._sessionService, this._apiClient);

  final TokenService _tokenService;
  final SessionService _sessionService;
  final Dio _apiClient;

  Completer<void>? _refreshing;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // если кто-то уже обновляет токен — ждём
    if (_refreshing != null) {
      try {
        await _refreshing!.future;
      } catch (e, st) {
        handler.reject(
          DioException(requestOptions: options, error: e, stackTrace: st),
        );
        return;
      }
    }

    final authRequired = options.extra['authRequired'] == true;

    if (options.extra['log'] == true) {
      _logRequest(options, _tokenService);
    }

    if (authRequired) {
      final accessToken = _tokenService.accessToken;

      if (accessToken == null) {
        handler.reject(DioException(requestOptions: options));
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
    // отвечает на 401 ошибку (остальные никак не обрабатывает)

    // пробует рефреш если есть
    // если рефреш успешен - повторяет запрос
    // если рефреш неуспешен - кидает NoOrBadTokens
    // скипает множественные одновременные запросы с 401

    _logError(err);
    final requestOptions = err.requestOptions;
    final authRequired = requestOptions.extra['authRequired'] == true;

    // ставим гвард
    // Рефрешим только auth-запросы и только при 401
    if (err.response?.statusCode != 401 || !authRequired) {
      handler.next(err);
      return;
    }

    // если retried значит токены были получены, но запрос всё равно упал с 401
    if (requestOptions.extra['retried'] == true) {
      handler.next(err);
      return;
    }

    // RefreshService обязан делать один refresh на всех
    // если уже кто-то обновляет - ждём
    if (_refreshing == null) {
      _refreshing = Completer<void>();
      try {
        await _sessionService.refreshTokens();
        _refreshing!.complete();
      } catch (e, st) {
        _refreshing!.completeError(e, st);
        _refreshing = null;

        handler.next(err);
        return;
      }
      _refreshing = null;
    } else {
      //  если refresh уже идёт — ждём его результат
      try {
        await _refreshing!.future;
      } catch (e, st) {
        handler.reject(
          DioException(
            requestOptions: requestOptions,
            error: e,
            stackTrace: st,
          ),
        );
        return;
      }
    }

    final newToken = _tokenService.accessToken;
    // если после рефреша токена нет - ошибка
    if (newToken == null) {
      handler.next(err);
      return;
    }

    // помечаем запрос как повторный, ставим новый токен и повторяем
    requestOptions.extra['retried'] = true;
    requestOptions.headers['Authorization'] = 'Bearer $newToken';

    final response = await _apiClient.fetch(requestOptions);
    handler.resolve(response);
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
    // ..vvvvvv('Bearer ${tokenService?.accessToken}')
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
