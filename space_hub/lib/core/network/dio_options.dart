import 'package:dio/dio.dart';

Options options({required bool authRequired, bool log = true}) =>
    Options(extra: {'authRequired': authRequired, 'log': log});
