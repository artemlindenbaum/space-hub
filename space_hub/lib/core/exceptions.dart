import 'package:dio/dio.dart';
import 'package:space_hub/core/interceptors/token_interceptor.dart';

// DioException это библиотечная сетевая обертка, которая содержит в себе контекст и объект ошибки
// AppException это ошибка переведенная на доменный язык приложения

abstract class AppException implements Exception {
  const AppException([this.message]);
  final String? message;
}

// --------- СЕТЕВЫЕ ИСКЛЮЧЕНИЯ ---------

// 400 bad request
class AppBadRequestException extends AppException {
  const AppBadRequestException([super.message]);
}

//401 unauthorized
class AppUnauthorizedException extends AppException {
  const AppUnauthorizedException([super.message]);
}

// 403 forbidden
class AppForbiddenException extends AppException {
  const AppForbiddenException([super.message]);
}

// 404 not found
class AppNotFoundException extends AppException {
  const AppNotFoundException([super.message]);
}

//409 conflict
class AppConflictException extends AppException {
  const AppConflictException([super.message]);
}

// 422 unprocessable entity
class AppUnprocessableEntityException extends AppException {
  const AppUnprocessableEntityException([super.message]);
}

class AppUnknownException extends AppException {
  const AppUnknownException([super.message]);
}

class AppNetworkException extends AppException {
  const AppNetworkException([super.message]);
}

class AppBadCertificateException extends AppException {
  const AppBadCertificateException([super.message]);
}

class AppRequestCancelledException extends AppException {
  const AppRequestCancelledException([super.message]);
}

class AppNoRoleException extends AppException {
  const AppNoRoleException([super.message]);
}

AppException mapDioToAppException(DioException e) {
  // l.i("mapDioToAppException: ${e.type}, ${e.message ?? "no message"}");

  switch (e.type) {
    case DioExceptionType.badResponse:
      final code = e.response?.statusCode;
      if (code == 400) {
        return AppBadRequestException(e.message);
      }
      if (code == 401 || e.error is BadTokens) {
        return AppUnauthorizedException(e.message);
      }
      if (code == 403) {
        return AppForbiddenException(e.message);
      }
      if (code == 404) {
        return AppNotFoundException(e.message);
      }
      if (code == 409) {
        return AppConflictException(e.message);
      }
      if (code == 422) {
        return AppUnprocessableEntityException(e.message);
      }
      return AppUnknownException(e.message);
    case DioExceptionType.connectionError:
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return AppNetworkException(e.message);
    case DioExceptionType.badCertificate:
      return AppBadCertificateException(e.message);
    case DioExceptionType.cancel:
      return AppRequestCancelledException(e.message);
    case DioExceptionType.unknown:
      if (e.error is NoTokens) {
        return AppUnauthorizedException(e.message);
      }
      return AppUnknownException(e.message);
  }
}

// connectionError — SocketException и прочий сетевой трэш
// connectionTimeout — не смогли вообще подключиться
// sendTimeout — не смогли отправить запрос
// receiveTimeout — не получили ответ
// unknown — только если внутри e.error что-то из сетевых (SocketException и т.п.)

//badCertificate — отдельная история: проблема с SSL/сертификатом
// лучше показать специфическое сообщение “Не удалось установить защищённое соединение”
