import 'package:dio/dio.dart';

Options options({
  required bool authRequired,
  bool log = true,
  bool isRefreshRequest = false,
}) => Options(
  extra: {
    'authRequired': authRequired,
    'log': log,
    'isRefreshRequest': isRefreshRequest,
  },
);
