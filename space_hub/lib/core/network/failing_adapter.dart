// ignore_for_file: unused_element
import 'dart:typed_data';
import 'package:dio/dio.dart';

typedef DioErrorBuilder = DioException Function(RequestOptions options);

FailAdapter createFailingAdapter(
  HttpClientAdapter inner,
  Map<String, DioErrorBuilder> failures,
) => FailAdapter(inner: inner, failures: failures);

class FailAdapter implements HttpClientAdapter {
  FailAdapter({required this.inner, required this.failures});

  final HttpClientAdapter inner;

  /// key format: 'GET auth/me'
  final Map<String, DioErrorBuilder> failures;

  @override
  void close({bool force = false}) => inner.close(force: force);

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final key = '${options.method.toUpperCase()} ${options.path}';
    final builder = failures[key];
    if (builder != null) {
      throw builder(options);
    }

    return inner.fetch(options, requestStream, cancelFuture);
  }
}
